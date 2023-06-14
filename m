Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA10BEB64DB
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 12:52:45 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.10844.1686747160518775619
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 05:52:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=kZmSvQRz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b01d3bb571so36881785ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686747159; x=1689339159;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KA22VmDYqXhs3AasNRR46gT5XnKKbnkJ3tsh5t8gnhY=;
        b=kZmSvQRz1SnxtIZ1AnwqIrz1jfCVf91kfb7Y8EpM98fFiF1N8f/nuUKPgpenDN+SSY
         tdl56Dyh6lp154Kpw8BDN3QGfbMF3ElHGVLCRK0UzO+Vwz6SvCM4V0kFmd2ATqY2ynaH
         p/CYgjQpyZYp86SH4CDHLfX/BJSRDKs/tvCsMHfKGjqNUp+XtfXhZO+WMqF4wAHY9Yv1
         w7XS2o2CB2jLZwdIcpxU9r/7jvnjRZNEnPy46LSS4tHyoLnM4CMQ1FjZ5CJzkTclQcTB
         pzMB/W4z1cf/rNYOKQTC+iaOB4SlmYkC0CynDkzzXC9RaG/Zasvfo7COVWzvz+S3AG30
         LBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747159; x=1689339159;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KA22VmDYqXhs3AasNRR46gT5XnKKbnkJ3tsh5t8gnhY=;
        b=XEjn+3h8w6Tg2nUfZXwO+74DytYN8MEL4sVnoh7XmRwqLyYlgfTJX2ptrINJrp2wbI
         8Am72ahO8/sW/iXAz5X6OfsXso852Q2LZBYUqs4f5ehlFpnkrhp37Jg3S75KtLR3aaKX
         WDENBaDZLPZlQIRxQTz8qFRu+tP+tnuQjmDn7M9eq8XUge9RcUMR/Y9WkSsUFZOyZmLq
         Bns2romI2c32r0qLJ4YmtprUWlPD1H15j0NZK+QEJB1Uut4NH9WK5kwUZKeRcfb0GoCs
         zI/0XmxlOo9BQvSSU7sv1ySWhXOloG5pFWnhhCzQE3ArkzkiUuX/Eym0hAfzsx8IJddk
         rFxA==
X-Gm-Message-State: AC+VfDzgqJlc40J++ntgqw/YG9Ymj3glbtwrMaWtXL2k6kRpBKxOkxwk
	pBcRzaLsDaICWqJczZe8JQbWSr27Lk05azgu3k2y5g==
X-Google-Smtp-Source: ACHHUZ4xyCsL+Sc5TxEiesDta7LlO1y03tmULha4u1Zl1ObAafrBBu//CLutHkIIxNUcV5AhZLV1oA==
X-Received: by 2002:a17:902:e842:b0:1b2:436b:931c with SMTP id t2-20020a170902e84200b001b2436b931cmr13359680plg.43.1686747159238;
        Wed, 14 Jun 2023 05:52:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902748400b001ab0d815dbbsm12128377pll.23.2023.06.14.05.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:52:38 -0700 (PDT)
Message-ID: <6489b816.170a0220.a4377.7559@mx.google.com>
Date: Wed, 14 Jun 2023 05:52:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-1-g7cde3fba93966
Subject: cip/linux-5.10.y-cip baseline-nfs: 39 runs,
 10 regressions (v5.10.182-cip35-1-g7cde3fba93966)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 12:52:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12016

cip/linux-5.10.y-cip baseline-nfs: 39 runs, 10 regressions (v5.10.182-cip35=
-1-g7cde3fba93966)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
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

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-1-g7cde3fba93966/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-1-g7cde3fba93966
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7cde3fba93966b9614ca285f91928a57a79f7f3f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ad252e6f55230a30616f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489ad252e6f55230a306174
        failing since 151 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:05:50.276269  <8>[   21.448532] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10724113_1.5.2.3.1>

    2023-06-14T12:05:50.279665  + set +x

    2023-06-14T12:05:50.383728  / # #

    2023-06-14T12:05:50.484368  export SHELL=3D/bin/sh

    2023-06-14T12:05:50.484545  #

    2023-06-14T12:05:50.585055  / # export SHELL=3D/bin/sh. /lava-10724113/=
environment

    2023-06-14T12:05:50.585234  =


    2023-06-14T12:05:50.685787  / # . /lava-10724113/environment/lava-10724=
113/bin/lava-test-runner /lava-10724113/1

    2023-06-14T12:05:50.686061  =


    2023-06-14T12:05:50.691297  / # /lava-10724113/bin/lava-test-runner /la=
va-10724113/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b379aacf559ca9306132

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6489b379aacf559ca=
9306133
        new failure (last pass: v5.10.182-cip35) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b1be80c79470fd30615f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489b1bf80c79470fd306195
        failing since 151 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:25:20.574422  + set +x
    2023-06-14T12:25:20.578401  <8>[   45.400479] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 610165_1.6.2.4.1>
    2023-06-14T12:25:20.704719  / # #
    2023-06-14T12:25:20.807658  export SHELL=3D/bin/sh
    2023-06-14T12:25:20.808428  #
    2023-06-14T12:25:20.910433  / # export SHELL=3D/bin/sh. /lava-610165/en=
vironment
    2023-06-14T12:25:20.911186  =

    2023-06-14T12:25:21.013420  / # . /lava-610165/environment/lava-610165/=
bin/lava-test-runner /lava-610165/1
    2023-06-14T12:25:21.014592  =

    2023-06-14T12:25:21.019363  / # /lava-610165/bin/lava-test-runner /lava=
-610165/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b1be72aacee78d306143

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489b1be72aacee78d306146
        failing since 151 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:25:04.268336  + set +x
    2023-06-14T12:25:04.272654  [   42.622440] <LAVA_SIGNAL_ENDRUN 0_dmesg =
962906_1.6.2.4.1>
    2023-06-14T12:25:04.520632  / # #
    2023-06-14T12:25:04.621911  export SHELL=3D/bin/sh
    2023-06-14T12:25:04.622180  #
    2023-06-14T12:25:04.723227  / # export SHELL=3D/bin/sh. /lava-962906/en=
vironment
    2023-06-14T12:25:04.723495  =

    2023-06-14T12:25:04.824580  / # . /lava-962906/environment/lava-962906/=
bin/lava-test-runner /lava-962906/1
    2023-06-14T12:25:04.825022  =

    2023-06-14T12:25:04.831237  / # /lava-962906/bin/lava-test-runner /lava=
-962906/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ad8270098f3568306160

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489ad8270098f3568306165
        failing since 61 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-14T12:07:25.613403  + set +x<8>[   18.641181] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 10724168_1.5.2.3.1>

    2023-06-14T12:07:25.613493  =


    2023-06-14T12:07:25.717927  / # #

    2023-06-14T12:07:25.820120  export SHELL=3D/bin/sh

    2023-06-14T12:07:25.820972  #

    2023-06-14T12:07:25.922423  / # export SHELL=3D/bin/sh. /lava-10724168/=
environment

    2023-06-14T12:07:25.923181  =


    2023-06-14T12:07:26.024673  / # . /lava-10724168/environment/lava-10724=
168/bin/lava-test-runner /lava-10724168/1

    2023-06-14T12:07:26.025799  =


    2023-06-14T12:07:26.031202  / # /lava-10724168/bin/lava-test-runner /la=
va-10724168/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6489ad3a24eb3fd549306169

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489ad3a24eb3fd54930616e
        failing since 61 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-14T12:05:54.722614  + set +x

    2023-06-14T12:05:54.729171  <8>[   20.410100] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10724150_1.5.2.3.1>

    2023-06-14T12:05:54.836297  / # #

    2023-06-14T12:05:54.938371  export SHELL=3D/bin/sh

    2023-06-14T12:05:54.939029  #

    2023-06-14T12:05:55.040308  / # export SHELL=3D/bin/sh. /lava-10724150/=
environment

    2023-06-14T12:05:55.041017  =


    2023-06-14T12:05:55.142396  / # . /lava-10724150/environment/lava-10724=
150/bin/lava-test-runner /lava-10724150/1

    2023-06-14T12:05:55.143440  =


    2023-06-14T12:05:55.148308  / # /lava-10724150/bin/lava-test-runner /la=
va-10724150/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6489af069b506f59fc30615c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6489af069b506f59fc306161
        failing since 151 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-14T12:13:39.199724  / # #

    2023-06-14T12:13:39.302046  export SHELL=3D/bin/sh

    2023-06-14T12:13:39.302702  #

    2023-06-14T12:13:39.404315  / # export SHELL=3D/bin/sh. /lava-10724298/=
environment

    2023-06-14T12:13:39.404531  =


    2023-06-14T12:13:39.505425  / # . /lava-10724298/environment/lava-10724=
298/bin/lava-test-runner /lava-10724298/1

    2023-06-14T12:13:39.506582  =


    2023-06-14T12:13:39.523152  / # /lava-10724298/bin/lava-test-runner /la=
va-10724298/1

    2023-06-14T12:13:39.666877  + export TESTRUN_ID=3D1_bootrr

    2023-06-14T12:13:39.667325  + cd /lava-10724298/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6489b2c33002ec113430613b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6489b2c33002ec113=
430613c
        new failure (last pass: v5.10.182-cip35) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6489acced05ccde83a3061c8

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6489acced05ccde83a30620a
        failing since 84 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-14T12:04:29.145762  /lava-10724063/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6489acced05ccde83a30620b
        failing since 84 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-14T12:04:28.043026  /lava-10724063/1/../bin/lava-test-case

    2023-06-14T12:04:28.084880  <8>[   37.723544] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

