Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDBAC6FD1C
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:03:02 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.37557.1679472177771708543
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:02:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=e76fBnka;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id cu12so5322686pfb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679472177;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AjqOLr1PAl+b3vh/zNwghuZmsXt6A5lw6JF+QQuyRpw=;
        b=e76fBnkapYxDSevDL/NgPCXZ28UyLhUQuz1aXaNPWxk6KVdbFxUw19AFTpSBY8p6DI
         alKnciOMrgkSRRFmjIX/IINBP/cVoyckfh1Vam7inzF69YEucqwjwEGU+OU17SM9h0uj
         gE7P8XovMF7oWXY5woUYMw7AHlJ+MzxMwr1JZaQZVOgjaTPf0Rd48plk1hxomFaVTwwc
         ilLuLD59q+cHUBA0jLZzicZap2+EEfC9ADcjnAK739COTK95uAIbTtuCwlNMewYJRp5N
         ybobPnTTKFsk7sPlBxkt2hnFAQCTq99NA4tRmm4xvoeaJzG2X8AEqv+fG9QQ6QwT2R0x
         6QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679472177;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AjqOLr1PAl+b3vh/zNwghuZmsXt6A5lw6JF+QQuyRpw=;
        b=pyiuI8i4pXSW0WB/rP4+c/gZKlD2UAuOe0jWFuEu5wpw/xV0TCKAurB0KZ+6HGO9bf
         Jwb+ksRXpiJZYgxvSgX+uxWnJQRfIj/CVjBylaKV8VH7lt1E0AjeSi35+NgunHMmKO1G
         pE4nN2y7mC65iMTf4tikMe66Sr6PpyC/mCviojdx4Fal/q03ZwBHR6O0j7qScgpsENQN
         XQWQl1DjtCKeEQAS5+NrrKKgiwJOvuAEvFzqMvUCNclo4s9dDuE9kYEqyydyp+9tYRhh
         r62dxu5FNJEzPyxf2h5hVMda7YJXNRlXA9ovnHl0HuiNXiKxIFC0mvv9JQXji6JlsVlT
         Fu4g==
X-Gm-Message-State: AO0yUKU9CJ/mGLYevMCW+TsrooZXkZRnXNZmWED/7u8NqwGUw8J8KkCw
	BzQ3YC21du+j8/nH1DWrhTdlPeDrmlDCV7QfZW4=
X-Google-Smtp-Source: AK7set/hSXIWwVnYmd0W5udfPacEBv1jRxnh/tiFhvBAS4QSVPOVXLwkHc7OYQ+t7R8umG9ybYf3Yw==
X-Received: by 2002:aa7:95ab:0:b0:627:fc3b:4cb4 with SMTP id a11-20020aa795ab000000b00627fc3b4cb4mr2282363pfk.19.1679472176860;
        Wed, 22 Mar 2023 01:02:56 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v20-20020aa78094000000b006089fb79f1esm9689174pff.96.2023.03.22.01.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:02:56 -0700 (PDT)
Message-ID: <641ab630.a70a0220.281c2.17b4@mx.google.com>
Date: Wed, 22 Mar 2023 01:02:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29
Subject: cip/linux-5.10.y-cip baseline-nfs: 46 runs,
 16 regressions (v5.10.175-cip29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:03:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11047

cip/linux-5.10.y-cip baseline-nfs: 46 runs, 16 regressions (v5.10.175-cip29)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.175-cip29/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.175-cip29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bb7267e6d2a6f131bb46ba14f0d3c418379e8bd4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa84b1c035f7a349c950c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641aa84b1c035f7a349c9515
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:03:28.556916  [   19.227868] <LAVA_SIGNAL_ENDRUN 0_dmesg =
9726618_1.5.2.3.1>

    2023-03-22T07:03:28.560829  + set +x

    2023-03-22T07:03:28.674669  / # #

    2023-03-22T07:03:28.777908  export SHELL=3D/bin/sh

    2023-03-22T07:03:28.778823  #

    2023-03-22T07:03:28.880727  / # export SHELL=3D/bin/sh. /lava-9726618/e=
nvironment

    2023-03-22T07:03:28.881700  =


    2023-03-22T07:03:28.983756  / # . /lava-9726618/environment/lava-972661=
8/bin/lava-test-runner /lava-9726618/1

    2023-03-22T07:03:28.985135  =


    2023-03-22T07:03:28.990550  / # /lava-9726618/bin/lava-test-runner /lav=
a-9726618/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa94f16cd3fd3449c9529

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641aa94f16cd3fd34=
49c952a
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa94fbcd66af1329c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641aa94fbcd66af13=
29c9506
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa85e8cfe864f0d9c9540

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641aa85e8cfe864f0d9c9549
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:03:38.660901  + set +x

    2023-03-22T07:03:38.665943  <8>[   19.433754] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9726674_1.5.2.3.1>

    2023-03-22T07:03:38.777777  =


    2023-03-22T07:03:38.880113  / # #export SHELL=3D/bin/sh

    2023-03-22T07:03:38.880983  =


    2023-03-22T07:03:38.982679  / # export SHELL=3D/bin/sh. /lava-9726674/e=
nvironment

    2023-03-22T07:03:38.983549  =


    2023-03-22T07:03:39.085472  / # . /lava-9726674/environment/lava-972667=
4/bin/lava-test-runner /lava-9726674/1

    2023-03-22T07:03:39.086873  =


    2023-03-22T07:03:39.089330  / # /lava-9726674/bin/lava-test-runner /lav=
a-9726674/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-cx9400-volteer          | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa951422bd127839c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641aa951422bd1278=
39c9506
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641aac7d96bb4a250c9c95a9

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641aac7d96bb4a250c9c95e1
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:20:51.550770  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 205607_1.6.2=
.4.1>
    2023-03-22T07:20:51.681542  #
    2023-03-22T07:20:51.784780  / # #export SHELL=3D/bin/sh
    2023-03-22T07:20:51.785596  =

    2023-03-22T07:20:51.887564  / # export SHELL=3D/bin/sh. /lava-205607/en=
vironment
    2023-03-22T07:20:51.888386  =

    2023-03-22T07:20:51.990400  / # . /lava-205607/environment/lava-205607/=
bin/lava-test-runner /lava-205607/1
    2023-03-22T07:20:51.991691  =

    2023-03-22T07:20:51.997953  / # /lava-205607/bin/lava-test-runner /lava=
-205607/1
    2023-03-22T07:20:52.393271  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641ab007285a845f8b9c9505

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641ab007285a845f8b9c9535
        failing since 67 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.162-cip24)

    2023-03-22T07:35:58.981945  <8>[   56.791496] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 205715_1.6.2.4.1>
    2023-03-22T07:35:59.119641  / # #
    2023-03-22T07:35:59.222513  export SHELL=3D/bin/sh
    2023-03-22T07:35:59.223246  #
    2023-03-22T07:35:59.325405  / # export SHELL=3D/bin/sh. /lava-205715/en=
vironment
    2023-03-22T07:35:59.326156  =

    2023-03-22T07:35:59.428552  / # . /lava-205715/environment/lava-205715/=
bin/lava-test-runner /lava-205715/1
    2023-03-22T07:35:59.429750  =

    2023-03-22T07:35:59.434315  / # /lava-205715/bin/lava-test-runner /lava=
-205715/1
    2023-03-22T07:35:59.653728  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641aad151c10820c149c9512

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641aad151c10820c149c954c
        failing since 49 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.165-cip25)

    2023-03-22T07:23:06.502190  + set +x
    2023-03-22T07:23:06.504942  <8>[   55.841001] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 205636_1.6.2.4.1>
    2023-03-22T07:23:06.796474  #
    2023-03-22T07:23:06.918560  / # #export SHELL=3D/bin/sh
    2023-03-22T07:23:06.925628  =

    2023-03-22T07:23:06.931244  / # export SHELL=3D/bin/sh
    2023-03-22T07:23:07.042556  . /lava-205636/environment
    2023-03-22T07:23:07.157781  / # . /lava-205636/environment/lava-205636/=
bin/lava-test-runner /lava-205636/1
    2023-03-22T07:23:07.169926  =

    2023-03-22T07:23:07.173802  / # /lava-205636/bin/lava-test-runner /lava=
-205636/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...4305U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa94d9b61cebbf69c9508

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-dell-latitude-5400-4305U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-dell-latitude-5400-4305U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641aa94d9b61cebbf=
69c9509
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
dell-latitude...8665U-sarien | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa962e4b5c8c1589c9520

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-dell-latitude-5400-8665U-sarien.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-dell-latitude-5400-8665U-sarien.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641aa962e4b5c8c15=
89c9521
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa950bcd66af1329c9508

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641aa950bcd66af13=
29c9509
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641aafbeef07c4e1b99c9514

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641aafbeef07c4e1b99c951d
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:35:11.483243  + set[   30.411306] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 9726928_1.6.2.4.1>

    2023-03-22T07:35:11.483479   +x

    2023-03-22T07:35:11.590987  / ##

    2023-03-22T07:35:11.692901  export SHELL=3D/bin/sh

    2023-03-22T07:35:11.693493   #

    2023-03-22T07:35:11.794883  / # export SHELL=3D/bin/sh. /lava-9726928/e=
nvironment

    2023-03-22T07:35:11.795477  =


    2023-03-22T07:35:11.896894  / # . /lava-9726928/environment/lava-972692=
8/bin/lava-test-runner /lava-9726928/1

    2023-03-22T07:35:11.897704  =


    2023-03-22T07:35:11.900194  / # /lava-9726928/bin/lava-test-runner /lav=
a-9726928/1
 =

    ... (16 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641aae610ac735a7b69c955c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641aae610ac735a7b=
69c955d
        failing since 8 days (last pass: v5.10.168-cip27, first fail: v5.10=
.173-cip28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/641aacbf45d50721a99c9505

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/641aacbf45d50721a99c950f
        new failure (last pass: v5.10.173-cip28)

    2023-03-22T07:22:27.676922  /lava-9726862/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/641aacbf45d50721a99c9510
        new failure (last pass: v5.10.173-cip28)

    2023-03-22T07:22:25.502222  <8>[   36.508477] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-03-22T07:22:26.576896  /lava-9726862/1/../bin/lava-test-case

    2023-03-22T07:22:26.616764  <8>[   37.625668] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641aaf2867cfb2e4649c9528

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641aaf2867cfb2e4649c9556
        failing since 67 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-22T07:32:18.066120  <8>[   55.223527] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 205684_1.6.2.4.1>
    2023-03-22T07:32:18.331453  / # #
    2023-03-22T07:32:18.434186  export SHELL=3D/bin/sh
    2023-03-22T07:32:18.434628  #
    2023-03-22T07:32:18.536005  / # export SHELL=3D/bin/sh. /lava-205684/en=
vironment
    2023-03-22T07:32:18.536904  =

    2023-03-22T07:32:18.638569  / # . /lava-205684/environment/lava-205684/=
bin/lava-test-runner /lava-205684/1
    2023-03-22T07:32:18.639820  =

    2023-03-22T07:32:18.644156  /lava-205684/bin/lava-test-runner /lava-205=
684/1/ # =

    2023-03-22T07:32:18.869709  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

