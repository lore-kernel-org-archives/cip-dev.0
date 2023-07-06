Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA894EB64DD
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 04:00:17 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
 by mx.groups.io with SMTP id smtpd.web10.14039.1688616010987469647
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Jul 2023 21:00:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Qi2qGK1g;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.222.179, mailfrom: bot@kernelci.org)
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7654e1d83e8so31672885a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 05 Jul 2023 21:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688616009; x=1691208009;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K2x+0W/aUDZkhCysM11dPThIWIpGFhK6ek80026hLkY=;
        b=Qi2qGK1geQzefkJS6RjzRFn0qj4EVkFwFb93gwFSt6zW8RStaRfl2GwFbif4BHEy8Z
         un81TyJXy+UqDpt1YzJ1LtSONs+GnpDe1cDOHXzTJsmdXzGT+kttf2zXvRNuvO6IPAB4
         vlMBfuVUA5TbwQ5vJ/knUsc4Jplch1xILJW62caKkmVmh3tCuniGbM/69D0nusBPK1zK
         yp1vpuP7/4St/9e9SX8yKsb0SsABJ1L1Cx9vG8UT6FcDQNTLAYHwEcNg4Fr62KZQX73p
         3HC6EQuMXI8y09FgPn3YpBkcqMQgA7qF4kQaB+pLNVF70FlsTAHBcdjthcY3yB98gf9z
         9Scg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688616009; x=1691208009;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K2x+0W/aUDZkhCysM11dPThIWIpGFhK6ek80026hLkY=;
        b=O1iu19e+oiG2EBzhHRfs9xHJR+rQ0JYnczOYt4GJsW/2GIlswCKAKi+9zyNFF5eedy
         bJgDSMN5Zf8YfRZs6ZsMpuJ6c59J1+n3DmKBeKs9VcPuwH6g0YeZcNKYv3MFNTqZqHgJ
         Ht3LiZaOP+bJtImpng2t59kMimwgvNI+Q8I43Jqyhucz6wOXh+2P0+aERdKH0YhY71hM
         fNfKfWakO5oLAF5kaFem3KeyTFA4aCvsV+0CpnjGgCe3HBG5b6NY7pD33zPcu/+hiqML
         oXcjrJqeOaK/s+3mT+fpf7RGZFUtgUBv3ZlEcCbn67zslabmqKlR4gxonL39DO9Cb2iN
         yCSQ==
X-Gm-Message-State: ABy/qLZEc8HkO5wU0268iOhxCxconktqmsaM76i+XEKklXclUfItmyLN
	1uSPSicDC9EUcMJq3MDYfwrH+sHcEgfogRhZDuU3oA==
X-Google-Smtp-Source: APBJJlEdhGzKe42vePApJtJmk5uCxv6G5pAmnej1NYGHH3C32D6umeol9hbGV/lAchyelniBSAB8Jw==
X-Received: by 2002:a05:620a:4541:b0:765:ad1b:c864 with SMTP id u1-20020a05620a454100b00765ad1bc864mr690994qkp.65.1688616009360;
        Wed, 05 Jul 2023 21:00:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y20-20020aa78054000000b00668821499c3sm261722pfm.156.2023.07.05.21.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 21:00:07 -0700 (PDT)
Message-ID: <64a63c47.a70a0220.99a3c.0c8a@mx.google.com>
Date: Wed, 05 Jul 2023 21:00:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-8-gb192df20e8c9
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 17 runs,
 6 regressions (v5.10.184-cip36-8-gb192df20e8c9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 04:00:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12246

cip/linux-5.10.y-cip baseline-nfs: 17 runs, 6 regressions (v5.10.184-cip36-=
8-gb192df20e8c9)

Regressions Summary
-------------------

platform         | arch | lab           | compiler | defconfig           | =
regressions
-----------------+------+---------------+----------+---------------------+-=
-----------
at91sam9g20ek    | arm  | lab-broonie   | gcc-10   | multi_v5_defconfig  | =
1          =

beaglebone-black | arm  | lab-broonie   | gcc-10   | multi_v7_defconfig  | =
1          =

beaglebone-black | arm  | lab-cip       | gcc-10   | multi_v7_defconfig  | =
1          =

beaglebone-black | arm  | lab-broonie   | gcc-10   | omap2plus_defconfig | =
1          =

beaglebone-black | arm  | lab-cip       | gcc-10   | omap2plus_defconfig | =
1          =

imx6q-sabrelite  | arm  | lab-collabora | gcc-10   | multi_v7_defconfig  | =
1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36-8-gb192df20e8c9/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36-8-gb192df20e8c9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b192df20e8c9dda03e005d4cb4909d846ea437bb =



Test Regressions
---------------- =



platform         | arch | lab           | compiler | defconfig           | =
regressions
-----------------+------+---------------+----------+---------------------+-=
-----------
at91sam9g20ek    | arm  | lab-broonie   | gcc-10   | multi_v5_defconfig  | =
1          =


  Details:     https://kernelci.org/test/plan/id/64a630196639f20f16bb2a9c

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-n=
fs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-n=
fs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64a630196639f20f16bb2ad1
        failing since 173 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T03:07:38.496107  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 700317_1.6.2=
.4.1>
    2023-07-06T03:07:38.615571  #
    2023-07-06T03:07:38.717735  / # #export SHELL=3D/bin/sh
    2023-07-06T03:07:38.718541  =

    2023-07-06T03:07:38.820470  / # export SHELL=3D/bin/sh. /lava-700317/en=
vironment
    2023-07-06T03:07:38.821256  =

    2023-07-06T03:07:38.923256  / # . /lava-700317/environment/lava-700317/=
bin/lava-test-runner /lava-700317/1
    2023-07-06T03:07:38.924634  =

    2023-07-06T03:07:38.931302  / # /lava-700317/bin/lava-test-runner /lava=
-700317/1
    2023-07-06T03:07:39.339302  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform         | arch | lab           | compiler | defconfig           | =
regressions
-----------------+------+---------------+----------+---------------------+-=
-----------
beaglebone-black | arm  | lab-broonie   | gcc-10   | multi_v7_defconfig  | =
1          =


  Details:     https://kernelci.org/test/plan/id/64a63361705cc3bbcebb2a75

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64a63361705cc3bbcebb2aa2
        failing since 173 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T03:21:20.313667  <8>[   52.395255] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 700370_1.6.2.4.1>
    2023-07-06T03:21:20.437990  / # #
    2023-07-06T03:21:20.542346  export SHELL=3D/bin/sh
    2023-07-06T03:21:20.543108  #
    2023-07-06T03:21:20.645629  / # export SHELL=3D/bin/sh. /lava-700370/en=
vironment
    2023-07-06T03:21:20.646575  =

    2023-07-06T03:21:20.749524  / # . /lava-700370/environment/lava-700370/=
bin/lava-test-runner /lava-700370/1
    2023-07-06T03:21:20.750359  =

    2023-07-06T03:21:20.754120  / # /lava-700370/bin/lava-test-runner /lava=
-700370/1
    2023-07-06T03:21:20.967637  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform         | arch | lab           | compiler | defconfig           | =
regressions
-----------------+------+---------------+----------+---------------------+-=
-----------
beaglebone-black | arm  | lab-cip       | gcc-10   | multi_v7_defconfig  | =
1          =


  Details:     https://kernelci.org/test/plan/id/64a6393dbbe7988f95bb2a92

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64a6393dbbe7988f95bb2a95
        failing since 173 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T03:46:35.313064  + set +x
    2023-07-06T03:46:35.314861  [   47.573311] <LAVA_SIGNAL_ENDRUN 0_dmesg =
982561_1.6.2.4.1>
    2023-07-06T03:46:35.430603  #
    2023-07-06T03:46:35.532781  / # #export SHELL=3D/bin/sh
    2023-07-06T03:46:35.533229  =

    2023-07-06T03:46:35.634613  / # export SHELL=3D/bin/sh. /lava-982561/en=
vironment
    2023-07-06T03:46:35.635063  =

    2023-07-06T03:46:35.736473  / # . /lava-982561/environment/lava-982561/=
bin/lava-test-runner /lava-982561/1
    2023-07-06T03:46:35.737247  =

    2023-07-06T03:46:35.739203  / # /lava-982561/bin/lava-test-runner /lava=
-982561/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab           | compiler | defconfig           | =
regressions
-----------------+------+---------------+----------+---------------------+-=
-----------
beaglebone-black | arm  | lab-broonie   | gcc-10   | omap2plus_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/64a62a9c2dd78ba774bb2af5

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64a62a9c2dd78ba774bb2b1f
        failing since 172 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T02:44:29.684505  [   45.925671] <LAVA_SIGNAL_ENDRUN 0_dmesg =
700260_1.6.2.4.1>
    2023-07-06T02:44:29.802430  / # #
    2023-07-06T02:44:29.905278  export SHELL=3D/bin/sh
    2023-07-06T02:44:29.905954  #
    2023-07-06T02:44:30.007862  / # export SHELL=3D/bin/sh. /lava-700260/en=
vironment
    2023-07-06T02:44:30.008439  =

    2023-07-06T02:44:30.110029  / # . /lava-700260/environment/lava-700260/=
bin/lava-test-runner /lava-700260/1
    2023-07-06T02:44:30.111151  =

    2023-07-06T02:44:30.118021  / # /lava-700260/bin/lava-test-runner /lava=
-700260/1
    2023-07-06T02:44:30.359399  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform         | arch | lab           | compiler | defconfig           | =
regressions
-----------------+------+---------------+----------+---------------------+-=
-----------
beaglebone-black | arm  | lab-cip       | gcc-10   | omap2plus_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/64a62abd19eb8d000bbb2a77

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64a62abd19eb8d000bbb2a7a
        failing since 172 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T02:44:51.858696  + set +x
    2023-07-06T02:44:51.862956  <8>[   43.895439] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 982539_1.6.2.4.1>
    2023-07-06T02:44:52.050615  #
    2023-07-06T02:44:52.152937  / # #export SHELL=3D/bin/sh
    2023-07-06T02:44:52.153532  =

    2023-07-06T02:44:52.255132  / # export SHELL=3D/bin/sh. /lava-982539/en=
vironment
    2023-07-06T02:44:52.255788  =

    2023-07-06T02:44:52.357557  / # . /lava-982539/environment/lava-982539/=
bin/lava-test-runner /lava-982539/1
    2023-07-06T02:44:52.358670  =

    2023-07-06T02:44:52.368699  / # /lava-982539/bin/lava-test-runner /lava=
-982539/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab           | compiler | defconfig           | =
regressions
-----------------+------+---------------+----------+---------------------+-=
-----------
imx6q-sabrelite  | arm  | lab-collabora | gcc-10   | multi_v7_defconfig  | =
1          =


  Details:     https://kernelci.org/test/plan/id/64a633157d0f2760c5bb2b06

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-8-gb192df20e8c9/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64a633157d0f2760c5bb2b0b
        failing since 173 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-06T03:20:48.579827  / # #

    2023-07-06T03:20:48.682330  export SHELL=3D/bin/sh

    2023-07-06T03:20:48.683057  #

    2023-07-06T03:20:48.785004  / # export SHELL=3D/bin/sh. /lava-11025642/=
environment

    2023-07-06T03:20:48.785740  =


    2023-07-06T03:20:48.887540  / # . /lava-11025642/environment/lava-11025=
642/bin/lava-test-runner /lava-11025642/1

    2023-07-06T03:20:48.888769  =


    2023-07-06T03:20:48.893025  / # /lava-11025642/bin/lava-test-runner /la=
va-11025642/1

    2023-07-06T03:20:49.041288  + export TESTRUN_ID=3D1_bootrr

    2023-07-06T03:20:49.041502  + cd /lava-11025642/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =20

