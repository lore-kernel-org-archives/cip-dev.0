Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E664CD13D1
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 15:25:38 +0000 (UTC)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
 by mx.groups.io with SMTP id smtpd.web11.12495.1695137136019792601
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 08:25:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Pf4AULqy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.42, mailfrom: bot@kernelci.org)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso201284339f.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695137135; x=1695741935; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9eKkfmmNew5/fxhHmTcCUg5zp3y4xiZj6OPmk6o/UI=;
        b=Pf4AULqy/QbduYuNuCjMByCy8EVD5xLVigi5ODIrULfGCdh8BUR1Od/MXMAfZ+TFGL
         yFgKTTZ2JQBtKN9F//W090gRhNrFe3rxFIqDFnErOM5gst1VRWknRqmW58hyjroGsotu
         mm64Sq0tV00UU4HVqBltmhKHLQg3+IGXEHJd154+74x7nXcCuwnvcPyC6ZCWq8tB13qE
         3G/3BUTwLn2DTzD8/HPvr/y8iXqwnOghDk2NGq03jYaRKVcF1vHL31rTIwVpkHZyozWJ
         Jfsc6Hw6nqVWE1eSKYMvxn6G07Eb11Vr1I4m6KgupH3v3bb6SAW/w4OH5R/sGw4kBIKs
         Xp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695137135; x=1695741935;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9eKkfmmNew5/fxhHmTcCUg5zp3y4xiZj6OPmk6o/UI=;
        b=bvXsofqi5GYoAqQdT7LIUfOkz5pA3YxykZQC+XKVgzPtiH0y78QYs9HBuZp2kfSB8p
         Ft4kHOlTusMSpbEjQjM10ynTkSzF2Gf1mmZ0yU2+dNgC3EMilJw0BQcnPE/y4c3zo6Wt
         TYdV5SbFj59FeFgRaxTpfnDXr8BpZgd0GTeX7SOYP8/OW9/qgsRapsHZbYG7htmgOted
         QpmSCcPvQ8w4fdVCzsZoG1wI/9IcRUxNwZu9ZQ0Xugxbxgv09uLeD3XukP/2vzvpUUL+
         etNmareRukyd3h1tpveTiTNf99iN/R24asQDL4eoRtcztNn2mf5BK4BvNTaossckByxT
         OprQ==
X-Gm-Message-State: AOJu0YzMFE0i+B0ZTlZaa05SjNMpyx/qgaB1A4wbMWel90giM5JyvgTw
	pMTxKd63f1JDMSOana7inAdHRnHkQ7u473EY1MYkng==
X-Google-Smtp-Source: AGHT+IGap5Q1yQGnj8jFFhYnVMjKvpLW/UjSC4oZKh8lV/muMplU1D9ZH8osG9S3VmbXr7jvVDwmFQ==
X-Received: by 2002:a05:6e02:f05:b0:34b:ba9f:679c with SMTP id x5-20020a056e020f0500b0034bba9f679cmr132197ilj.16.1695137134532;
        Tue, 19 Sep 2023 08:25:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b127-20020a633485000000b005709b5aea02sm8155713pga.63.2023.09.19.08.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 08:25:34 -0700 (PDT)
Message-ID: <6509bd6e.630a0220.6d66.bab7@mx.google.com>
Date: Tue, 19 Sep 2023 08:25:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 22 runs,
 11 regressions (v5.10.194-cip39)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 15:25:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13156

cip/linux-5.10.y-cip baseline-nfs: 22 runs, 11 regressions (v5.10.194-cip39)

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

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ecda23c2ad8c5eae1f19054d0b67a7904546b7f4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b3c8bf5a36977e8a0a60

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6509b3c8bf5a36977e8a0a91
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:43:35.226610  <8>[   53.627125] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 118276_1.6.2.4.1>
    2023-09-19T14:43:35.376422  / # #
    2023-09-19T14:43:35.478503  export SHELL=3D/bin/sh
    2023-09-19T14:43:35.479117  #
    2023-09-19T14:43:35.580783  / # export SHELL=3D/bin/sh. /lava-118276/en=
vironment
    2023-09-19T14:43:35.581731  =

    2023-09-19T14:43:35.683696  / # . /lava-118276/environment/lava-118276/=
bin/lava-test-runner /lava-118276/1
    2023-09-19T14:43:35.685383  =

    2023-09-19T14:43:35.689492  / # /lava-118276/bin/lava-test-runner /lava=
-118276/1
    2023-09-19T14:43:35.942050  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b598f0f9ee4a458a0a7e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6509b598f0f9ee4a458a0a85
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:51:18.432805  + set +x
    2023-09-19T14:51:18.434887  <8>[   45.870780] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010462_1.6.2.4.1>
    2023-09-19T14:51:18.551829  #
    2023-09-19T14:51:18.654070  / # #export SHELL=3D/bin/sh
    2023-09-19T14:51:18.654586  =

    2023-09-19T14:51:18.755992  / # export SHELL=3D/bin/sh. /lava-1010462/e=
nvironment
    2023-09-19T14:51:18.756481  =

    2023-09-19T14:51:18.857917  / # . /lava-1010462/environment/lava-101046=
2/bin/lava-test-runner /lava-1010462/1
    2023-09-19T14:51:18.858760  =

    2023-09-19T14:51:18.860700  / # /lava-1010462/bin/lava-test-runner /lav=
a-1010462/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b35f60df6b1f728a0ac9

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6509b35f60df6b1f728a0b03
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:42:15.976032  + set +x
    2023-09-19T14:42:15.978986  <8>[   46.490676] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 118241_1.6.2.4.1>
    2023-09-19T14:42:16.094848  / # #
    2023-09-19T14:42:16.197678  export SHELL=3D/bin/sh
    2023-09-19T14:42:16.198385  #
    2023-09-19T14:42:16.300052  / # export SHELL=3D/bin/sh. /lava-118241/en=
vironment
    2023-09-19T14:42:16.300704  =

    2023-09-19T14:42:16.402962  / # . /lava-118241/environment/lava-118241/=
bin/lava-test-runner /lava-118241/1
    2023-09-19T14:42:16.404009  =

    2023-09-19T14:42:16.407231  / # /lava-118241/bin/lava-test-runner /lava=
-118241/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b3e0075e51db8e8a0aa8

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6509b3e0075e51db8e8a0aaf
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:44:29.305244  + set +x
    2023-09-19T14:44:29.307286  <8>[   39.383890] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010448_1.6.2.4.1>
    2023-09-19T14:44:29.426053  #
    2023-09-19T14:44:29.528261  / # #export SHELL=3D/bin/sh
    2023-09-19T14:44:29.528710  =

    2023-09-19T14:44:29.630135  / # export SHELL=3D/bin/sh. /lava-1010448/e=
nvironment
    2023-09-19T14:44:29.630597  =

    2023-09-19T14:44:29.732021  / # . /lava-1010448/environment/lava-101044=
8/bin/lava-test-runner /lava-1010448/1
    2023-09-19T14:44:29.732777  =

    2023-09-19T14:44:29.734827  / # /lava-1010448/bin/lava-test-runner /lav=
a-1010448/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b5805fd40e17f68a0a94

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6509b5805fd40e17f68a0a9d
        failing since 158 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-09-19T14:51:27.555311  + <8>[   18.605801] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11571907_1.5.2.3.1>

    2023-09-19T14:51:27.555437  set +x

    2023-09-19T14:51:27.659349  / # #

    2023-09-19T14:51:27.759946  export SHELL=3D/bin/sh

    2023-09-19T14:51:27.760120  #

    2023-09-19T14:51:27.860644  / # export SHELL=3D/bin/sh. /lava-11571907/=
environment

    2023-09-19T14:51:27.860827  =


    2023-09-19T14:51:27.961367  / # . /lava-11571907/environment/lava-11571=
907/bin/lava-test-runner /lava-11571907/1

    2023-09-19T14:51:27.961656  =


    2023-09-19T14:51:27.965942  / # /lava-11571907/bin/lava-test-runner /la=
va-11571907/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b58f960702505e8a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6509b58f960702505e8a0a4b
        failing since 158 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-09-19T14:51:36.189649  + set +x

    2023-09-19T14:51:36.196299  <8>[   18.684189] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571924_1.5.2.3.1>

    2023-09-19T14:51:36.302401  / # #

    2023-09-19T14:51:36.404525  export SHELL=3D/bin/sh

    2023-09-19T14:51:36.405224  #

    2023-09-19T14:51:36.506454  / # export SHELL=3D/bin/sh. /lava-11571924/=
environment

    2023-09-19T14:51:36.507117  =


    2023-09-19T14:51:36.608474  / # . /lava-11571924/environment/lava-11571=
924/bin/lava-test-runner /lava-11571924/1

    2023-09-19T14:51:36.609651  =


    2023-09-19T14:51:36.614605  / # /lava-11571924/bin/lava-test-runner /la=
va-11571924/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b381598379af2d8a0a51

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6509b381598379af2d8a0a5a
        failing since 248 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-19T14:42:51.196588  / # #

    2023-09-19T14:42:51.299158  export SHELL=3D/bin/sh

    2023-09-19T14:42:51.299903  #

    2023-09-19T14:42:51.401683  / # export SHELL=3D/bin/sh. /lava-11571727/=
environment

    2023-09-19T14:42:51.402428  =


    2023-09-19T14:42:51.504328  / # . /lava-11571727/environment/lava-11571=
727/bin/lava-test-runner /lava-11571727/1

    2023-09-19T14:42:51.505471  =


    2023-09-19T14:42:51.509813  / # /lava-11571727/bin/lava-test-runner /la=
va-11571727/1

    2023-09-19T14:42:51.701641  + export TESTRUN_ID=3D1_bootrr

    2023-09-19T14:42:51.702110  + cd /lava-11571727/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b75ed65831d2748a0ac3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6509b75ed65831d27=
48a0ac4
        failing since 34 days (last pass: v5.10.186-cip37-13-g260094841fe1a=
, first fail: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6509b79a69e671f3408a0a44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6509b79a69e671f34=
08a0a45
        failing since 28 days (last pass: v5.10.186-cip37-14-gc9b5a049d8ea,=
 first fail: v5.10.186-cip37-27-gd6d928db0a620) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6509b6fda6239f20718a0a49

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6509b6fda6239f20718a0a53
        failing since 181 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-09-19T14:58:06.209588  <8>[   37.703001] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-09-19T14:58:07.272161  /lava-11571989/1/../bin/lava-test-case

    2023-09-19T14:58:07.308757  <8>[   38.803171] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6509b6fda6239f20718a0a54
        failing since 181 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-09-19T14:58:05.091020  <8>[   36.583655] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-09-19T14:58:06.169863  /lava-11571989/1/../bin/lava-test-case
   =

 =20

