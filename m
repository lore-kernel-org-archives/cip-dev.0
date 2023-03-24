Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19F1C76196
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 09:53:45 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.96904.1679651618768070525
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Mar 2023 02:53:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cDBWb/RU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso1077030pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Mar 2023 02:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679651618;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I/VK7gAIgdIF+FQB2/PV/hD64e8kTP9XV+IBUZlulLY=;
        b=cDBWb/RUy8rVxdgJ/HTikdSKrq9KlhGu1NH2rPFjyGee0Dq4RjroZI6Qc7MSFWg2YB
         CCo/VeMdt5aP4Ib69mCx+zmuWY03xyFWqVgRH7bp+iijpazOoU0SFo6vObHktFXoP/3+
         v+tTAHeT6S8wP/P/SMJtRcYhAmyHOdc0XBNR+adanCJXKfxkztmwBdVvOFX32flehJoS
         9/aKhDJoklnOLgeIVunJQpvDNiJCP+iNbcG3Mz2TY7Tp7dDkh65kkQJ8mS0pEs3nM61J
         Wsc8uoJiNhX7vb9gMxjb9vHP1YGevi+aP1Bkq9r+O1mIHYY/DJTM23xDYbjtkLToNpbp
         /vKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679651618;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/VK7gAIgdIF+FQB2/PV/hD64e8kTP9XV+IBUZlulLY=;
        b=LvluVLcTdvKx290uX3r2ek7Be12V6uO33bHxgeABO5ALlYWvZys+tk59lc58lxG1Sn
         FNGoOWEwrqpnBeRnpG7K/aNJJEqFyqnIWJcO3EdPI7QsL6SdhU2w+4StygpLXl+6tUn2
         wzm0dYgJZUoEOAor1/UoPpOyWyKIxbgZGmFWCVuvJyFEF8PDNXqCxeHSATOhSQnHQ6XX
         4R4PnedYfeZLRBUO9ZM0TGuJZ2FcLRjh6DlteKX4eLY8I1kYcuSItsqKZH/KTz0TKwp5
         YkRG0luQCTflZHKYKaE6Bq7JKJkyrof6IRhl7XZoBtdXXXOmI53cNBaTkuwhQ3EsR4D3
         ehwQ==
X-Gm-Message-State: AAQBX9fnS3eWPBjt1mS1hRd6GT/Zvr9d/OkScriRz2sEay+jw0E/owDf
	+jcI1kxuxpO2y2GciMGNLOlsIRGbiRMmufFZtlkq7g==
X-Google-Smtp-Source: AKy350ZTqe0LqDooXGqkp5DxucCpoF1s9QvYA/I+OPAh0CwK0WgyegavzYgJsQ71W0Y0CWCOySxT3Q==
X-Received: by 2002:a17:902:7c11:b0:1a0:566c:aaf8 with SMTP id x17-20020a1709027c1100b001a0566caaf8mr1774603pll.27.1679651617752;
        Fri, 24 Mar 2023 02:53:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902934900b0019f1205bdcbsm13753464plp.147.2023.03.24.02.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 02:53:37 -0700 (PDT)
Message-ID: <641d7321.170a0220.f144e.938c@mx.google.com>
Date: Fri, 24 Mar 2023 02:53:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.176-cip30
Subject: cip/linux-5.10.y-cip baseline-nfs: 45 runs,
 11 regressions (v5.10.176-cip30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 09:53:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11110

cip/linux-5.10.y-cip baseline-nfs: 45 runs, 11 regressions (v5.10.176-cip30)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.176-cip30/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.176-cip30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      530cf8a4dace471f6e04e5887f4993ba1fcd3109 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641d67d0c63aa93cf59c9505

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641d67d0c63aa93cf59c950e
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:05:12.058892  <8>[   18.856711] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9759623_1.5.2.3.1>

    2023-03-24T09:05:12.062198  + set +x

    2023-03-24T09:05:12.167639  / # #

    2023-03-24T09:05:12.268676  export SHELL=3D/bin/sh

    2023-03-24T09:05:12.268873  #

    2023-03-24T09:05:12.369864  / # export SHELL=3D/bin/sh. /lava-9759623/e=
nvironment

    2023-03-24T09:05:12.370063  =


    2023-03-24T09:05:12.471011  / # . /lava-9759623/environment/lava-975962=
3/bin/lava-test-runner /lava-9759623/1

    2023-03-24T09:05:12.471318  =


    2023-03-24T09:05:12.476979  / # /lava-9759623/bin/lava-test-runner /lav=
a-9759623/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641d67fa1cbd2c116e9c952c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/baseline=
-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641d67fa1cbd2c116e9c9535
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:05:41.267077  + set +x

    2023-03-24T09:05:41.272920  <8>[   20.447346] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 9759637_1.5.2.3.1>

    2023-03-24T09:05:41.385128  =


    2023-03-24T09:05:41.487632  / # #export SHELL=3D/bin/sh

    2023-03-24T09:05:41.488545  =


    2023-03-24T09:05:41.590632  / # export SHELL=3D/bin/sh. /lava-9759637/e=
nvironment

    2023-03-24T09:05:41.591562  =


    2023-03-24T09:05:41.693656  / # . /lava-9759637/environment/lava-975963=
7/bin/lava-test-runner /lava-9759637/1

    2023-03-24T09:05:41.695103  =


    2023-03-24T09:05:41.697147  / # /lava-9759637/bin/lava-test-runner /lav=
a-9759637/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6ba39c5b0060939c952c

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20ek=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641d6ba39c5b0060939c9561
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:21:04.789425  + set +x
    2023-03-24T09:21:04.909758  #
    2023-03-24T09:21:05.012702  / # #export SHELL=3D/bin/sh
    2023-03-24T09:21:05.013541  =

    2023-03-24T09:21:05.115476  / # export SHELL=3D/bin/sh. /lava-221043/en=
vironment
    2023-03-24T09:21:05.116262  =

    2023-03-24T09:21:05.218394  / # . /lava-221043/environment/lava-221043/=
bin/lava-test-runner /lava-221043/1
    2023-03-24T09:21:05.219743  =

    2023-03-24T09:21:05.226570  / # /lava-221043/bin/lava-test-runner /lava=
-221043/1
    2023-03-24T09:21:05.640616  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6a2b6af705aec79c957e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-bl=
ack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641d6a2b6af705aec79c95af
        failing since 69 days (last pass: v5.10.158-cip22, first fail: v5.1=
0.162-cip24)

    2023-03-24T09:14:24.927272  [   57.221861] <LAVA_SIGNAL_ENDRUN 0_dmesg =
221131_1.6.2.4.1>
    2023-03-24T09:14:25.051738  / # #
    2023-03-24T09:14:25.154722  export SHELL=3D/bin/sh
    2023-03-24T09:14:25.155447  #
    2023-03-24T09:14:25.257655  / # export SHELL=3D/bin/sh. /lava-221131/en=
vironment
    2023-03-24T09:14:25.258355  =

    2023-03-24T09:14:25.360917  / # . /lava-221131/environment/lava-221131/=
bin/lava-test-runner /lava-221131/1
    2023-03-24T09:14:25.362122  =

    2023-03-24T09:14:25.366599  / # /lava-221131/bin/lava-test-runner /lava=
-221131/1
    2023-03-24T09:14:25.591489  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6a68b125ed01a09c9544

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beaglebone-b=
lack.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641d6a68b125ed01a09c957d
        failing since 51 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.165-cip25)

    2023-03-24T09:15:50.230436  + set +x
    2023-03-24T09:15:50.234171  <8>[   46.015000] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 221165_1.6.2.4.1>
    2023-03-24T09:15:50.359733  / # #
    2023-03-24T09:15:50.462752  export SHELL=3D/bin/sh
    2023-03-24T09:15:50.463474  #
    2023-03-24T09:15:50.565647  / # export SHELL=3D/bin/sh. /lava-221165/en=
vironment
    2023-03-24T09:15:50.566924  =

    2023-03-24T09:15:50.669836  / # . /lava-221165/environment/lava-221165/=
bin/lava-test-runner /lava-221165/1
    2023-03-24T09:15:50.670987  =

    2023-03-24T09:15:50.675621  / # /lava-221165/bin/lava-test-runner /lava=
-221165/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641d69897201396b699c9557

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-nfs-imx6q-sabre=
lite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641d69897201396b699c9560
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:12:23.183983  / # #

    2023-03-24T09:12:23.286660  export SHELL=3D/bin/sh

    2023-03-24T09:12:23.287521  #

    2023-03-24T09:12:23.389420  / # export SHELL=3D/bin/sh. /lava-9759714/e=
nvironment

    2023-03-24T09:12:23.389699  =


    2023-03-24T09:12:23.490803  / # . /lava-9759714/environment/lava-975971=
4/bin/lava-test-runner /lava-9759714/1

    2023-03-24T09:12:23.492083  =


    2023-03-24T09:12:23.496802  / # /lava-9759714/bin/lava-test-runner /lav=
a-9759714/1

    2023-03-24T09:12:23.624522  + export TESTRUN_ID=3D1_bootrr

    2023-03-24T09:12:23.671184  + cd /lava-9759714/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6c5d5ac88eb00d9c950c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libr=
etech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libr=
etech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641d6c5d5ac88eb00=
d9c950d
        new failure (last pass: v5.10.175-cip29) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6e3e80960a17869c951b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/641d6e3e80960a178=
69c951c
        failing since 10 days (last pass: v5.10.168-cip27, first fail: v5.1=
0.173-cip28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/641d6ca442154f828b9c965d

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/641d6ca442154f828b9c9667
        failing since 2 days (last pass: v5.10.173-cip28, first fail: v5.10=
.175-cip29)

    2023-03-24T09:25:35.552081  [   38.094051] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-03-24T09:25:36.616187  /lava-9759765/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/641d6ca442154f828b9c9668
        failing since 2 days (last pass: v5.10.173-cip28, first fail: v5.10=
.175-cip29)

    2023-03-24T09:25:34.435564  [   36.976760] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-03-24T09:25:35.510580  /lava-9759765/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641d6dca18412896769c9514

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.176=
-cip30/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun50i-a64-pine64-pl=
us.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/641d6dca18412896769c9544
        failing since 69 days (last pass: v5.10.158-cip22-7-g92462fd9830b, =
first fail: v5.10.162-cip24)

    2023-03-24T09:30:24.290734  <8>[   56.105359] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 221203_1.6.2.4.1>
    2023-03-24T09:30:24.457919  / # #
    2023-03-24T09:30:24.560144  export SHELL=3D/bin/sh
    2023-03-24T09:30:24.560833  #
    2023-03-24T09:30:24.662362  / # export SHELL=3D/bin/sh. /lava-221203/en=
vironment
    2023-03-24T09:30:24.662801  =

    2023-03-24T09:30:24.764180  / # . /lava-221203/environment/lava-221203/=
bin/lava-test-runner /lava-221203/1
    2023-03-24T09:30:24.765122  =

    2023-03-24T09:30:24.769223  / # /lava-221203/bin/lava-test-runner /lava=
-221203/1
    2023-03-24T09:30:25.045171  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

