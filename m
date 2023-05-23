Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90109C7EE2E
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 01:30:56 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web10.10303.1684805453599175481
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 18:30:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=JwdjGMeY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ae763f9c0bso36595035ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 18:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684805452; x=1687397452;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nsQuvDY4b/nAHpGiDKEX0gSj9Vyi5q4tcQLb254JYLs=;
        b=JwdjGMeYbKXj6yYsZ+Lh3MQUf2OCB2cyblDH6SSwNUEc1VvCxHY9aUfbh834xDHjBP
         UwdbduPpCm4PIl+POCQfopv7CfdzVIvqzaCPNKleCrSJh9rMM1v9H+vjY4ctZyWouSuD
         U1oSlksQxTFZhAnRDobp7thMM7f67RR3FiygsmRRagLF9cpCsIWcEEVb5pJkr7A8o9pD
         +vQNPfmVVZwLcmIBvqUzSynu4K1YoGUNcLXw9Hty9IUIGqJoTm9jryG/elzSEYjZnslo
         xNOd6piOaLhX+klT4hX8VGmC7Jdy4ay0X0PyW9i+aQk8w+2zhlsNu8sjim1Fi5dg1YlU
         +CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684805452; x=1687397452;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsQuvDY4b/nAHpGiDKEX0gSj9Vyi5q4tcQLb254JYLs=;
        b=JX607qVd5MAvFxshNq+u1GBE8jFvet4/jnfNOq42+7LZgBG06E8Zzyx2TCpGY+AaXb
         +LABrZMH2Kl3fqiRoF7uYWfzIN4I/GM2Djy3efBgb1uhZk/0NdlGuWrhybNTu5eIlOAP
         LheRox5+w70K7q/ZgqaJQ2NGU3ySE2CTprpRO7wLg73lj4kjopLGmLjHLeCUsQJQW1Hf
         LlAaHYDUmjsCvav9c4I8pA2rF3MLi+KBYKMhtsPNnLLlq4bL/DwhovkKZK9QByvBdSao
         AUf+GaJCmrSUIdZLnlCk2PezpFj0aZk80HM3atuK1XASZ7zFLVcf5XeBLODpA5m3uHgR
         iDjQ==
X-Gm-Message-State: AC+VfDx/qB8cvFnpcZ/KCcYzFC7LUponjhiX5qTC9OewZjnoAeFCZ1j5
	YB+aP1x7j4bgSB/CWw/7gWQ/ZILuKQHVyInKZ4fM6g==
X-Google-Smtp-Source: ACHHUZ4sddprBAI1vNkEzp0haZi2S4gybIXquJTy8qLEbksJEEjErlIagPozrbubDrq+X/HdgEQ1rA==
X-Received: by 2002:a17:902:bf06:b0:1a6:bd5c:649d with SMTP id bi6-20020a170902bf0600b001a6bd5c649dmr11158879plb.56.1684805451913;
        Mon, 22 May 2023 18:30:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902f68600b001ac706dd98bsm5428822plg.35.2023.05.22.18.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:30:51 -0700 (PDT)
Message-ID: <646c174b.170a0220.617e6.97a3@mx.google.com>
Date: Mon, 22 May 2023 18:30:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-11-gfea7994097935
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 130 runs,
 22 regressions (v5.10.180-cip33-11-gfea7994097935)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 01:30:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11593

cip/linux-5.10.y-cip baseline: 130 runs, 22 regressions (v5.10.180-cip33-11=
-gfea7994097935)

Regressions Summary
-------------------

platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-11-gfea7994097935/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-11-gfea7994097935
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fea799409793527f9b9b2d2c53f0dc4e3ac7ac6a =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0fd692c45bc3362e8677

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0fd692c45bc3362e867c
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:58:40.686318  <8>[   11.682314] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10419734_1.4.2.3.1>

    2023-05-23T00:58:40.689468  + set +x

    2023-05-23T00:58:40.794449  #

    2023-05-23T00:58:40.795594  =


    2023-05-23T00:58:40.897349  / # #export SHELL=3D/bin/sh

    2023-05-23T00:58:40.897976  =


    2023-05-23T00:58:40.999341  / # export SHELL=3D/bin/sh. /lava-10419734/=
environment

    2023-05-23T00:58:41.000039  =


    2023-05-23T00:58:41.101484  / # . /lava-10419734/environment/lava-10419=
734/bin/lava-test-runner /lava-10419734/1

    2023-05-23T00:58:41.102489  =

 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c104f22e9c5758f2e86bc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c104f22e9c5758f2e86c1
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T01:00:49.012026  + set +x

    2023-05-23T01:00:49.020777  <8>[   11.506233] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10419732_1.4.2.3.1>

    2023-05-23T01:00:49.125627  #

    2023-05-23T01:00:49.228503  / # #export SHELL=3D/bin/sh

    2023-05-23T01:00:49.229299  =


    2023-05-23T01:00:49.330901  / # export SHELL=3D/bin/sh. /lava-10419732/=
environment

    2023-05-23T01:00:49.331702  =


    2023-05-23T01:00:49.332161  / # <4>[   11.760386] i2c_designware i2c_de=
signware.5: timeout in disabling adapter

    2023-05-23T01:00:49.433753  . /lava-10419732/environment/lava-10419732/=
bin/lava-test-runner /lava-10419732/1

    2023-05-23T01:00:49.434974  =

 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0ceac15ebdc9042e8600

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline=
-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0ceac15ebdc9042e8634
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:45:58.363264  + set +x
    2023-05-23T00:45:58.368404  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 498802_1.5.2=
.4.1>
    2023-05-23T00:45:58.483375  / # #
    2023-05-23T00:45:58.586435  export SHELL=3D/bin/sh
    2023-05-23T00:45:58.587263  #
    2023-05-23T00:45:58.689244  / # export SHELL=3D/bin/sh. /lava-498802/en=
vironment
    2023-05-23T00:45:58.690062  =

    2023-05-23T00:45:58.792125  / # . /lava-498802/environment/lava-498802/=
bin/lava-test-runner /lava-498802/1
    2023-05-23T00:45:58.793495  =

    2023-05-23T00:45:58.799812  / # /lava-498802/bin/lava-test-runner /lava=
-498802/1 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0ecec31ef496d62e861e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0ecec31ef496d62e864a
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:53:49.107403  <8>[   22.827405] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 498881_1.5.2.4.1>
    2023-05-23T00:53:49.216210  / # #
    2023-05-23T00:53:49.318825  export SHELL=3D/bin/sh
    2023-05-23T00:53:49.319468  #
    2023-05-23T00:53:49.420934  / # export SHELL=3D/bin/sh. /lava-498881/en=
vironment
    2023-05-23T00:53:49.421666  =

    2023-05-23T00:53:49.523188  / # . /lava-498881/environment/lava-498881/=
bin/lava-test-runner /lava-498881/1
    2023-05-23T00:53:49.523894  =

    2023-05-23T00:53:49.528122  / # /lava-498881/bin/lava-test-runner /lava=
-498881/1
    2023-05-23T00:53:49.622114  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0d7e2827b3c8222e8612

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0d7e2827b3c8222e8644
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:48:47.054417  + set +x
    2023-05-23T00:48:47.057815  <8>[   20.293180] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 498829_1.5.2.4.1>
    2023-05-23T00:48:47.166858  / # #
    2023-05-23T00:48:47.269443  export SHELL=3D/bin/sh
    2023-05-23T00:48:47.269934  #
    2023-05-23T00:48:47.371450  / # export SHELL=3D/bin/sh. /lava-498829/en=
vironment
    2023-05-23T00:48:47.372006  =

    2023-05-23T00:48:47.473869  / # . /lava-498829/environment/lava-498829/=
bin/lava-test-runner /lava-498829/1
    2023-05-23T00:48:47.474666  =

    2023-05-23T00:48:47.479048  / # /lava-498829/bin/lava-test-runner /lava=
-498829/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0fbd040cf306e62e85e7

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0fbd040cf306e62e85ea
        failing since 70 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-05-23T00:57:55.067789  [   23.890075] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1226980_1.5.2.4.1>
    2023-05-23T00:57:55.175677  / # #
    2023-05-23T00:57:55.277491  export SHELL=3D/bin/sh
    2023-05-23T00:57:55.277934  #
    2023-05-23T00:57:55.379331  / # export SHELL=3D/bin/sh. /lava-1226980/e=
nvironment
    2023-05-23T00:57:55.379777  =

    2023-05-23T00:57:55.481174  / # . /lava-1226980/environment/lava-122698=
0/bin/lava-test-runner /lava-1226980/1
    2023-05-23T00:57:55.481904  =

    2023-05-23T00:57:55.483901  / # /lava-1226980/bin/lava-test-runner /lav=
a-1226980/1
    2023-05-23T00:57:55.505018  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0fc0040cf306e62e85fd

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088=
a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088=
a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0fc0040cf306e62e8600
        failing since 128 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-05-23T00:57:50.596206  [   15.346960] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1226982_1.5.2.4.1>
    2023-05-23T00:57:50.700358  / # #
    2023-05-23T00:57:50.801603  export SHELL=3D/bin/sh
    2023-05-23T00:57:50.801897  #
    2023-05-23T00:57:50.902919  / # export SHELL=3D/bin/sh. /lava-1226982/e=
nvironment
    2023-05-23T00:57:50.903336  =

    2023-05-23T00:57:51.004443  / # . /lava-1226982/environment/lava-122698=
2/bin/lava-test-runner /lava-1226982/1
    2023-05-23T00:57:51.005040  =

    2023-05-23T00:57:51.006940  / # /lava-1226982/bin/lava-test-runner /lav=
a-1226982/1
    2023-05-23T00:57:51.025032  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0fe9bb4fab9d872e861d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0fe9bb4fab9d872e8622
        failing since 38 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-05-23T00:59:05.543287  + <8>[   10.950390] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10419742_1.4.2.3.1>

    2023-05-23T00:59:05.543373  set +x

    2023-05-23T00:59:05.644744  =


    2023-05-23T00:59:05.745343  / # #export SHELL=3D/bin/sh

    2023-05-23T00:59:05.745582  =


    2023-05-23T00:59:05.846114  / # export SHELL=3D/bin/sh. /lava-10419742/=
environment

    2023-05-23T00:59:05.846352  =


    2023-05-23T00:59:05.946947  / # . /lava-10419742/environment/lava-10419=
742/bin/lava-test-runner /lava-10419742/1

    2023-05-23T00:59:05.947304  =


    2023-05-23T00:59:05.951700  / # /lava-10419742/bin/lava-test-runner /la=
va-10419742/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e9708e16291fa2e8601

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0e9708e16291fa2e8606
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:53:35.874876  / # #

    2023-05-23T00:53:35.977047  export SHELL=3D/bin/sh

    2023-05-23T00:53:35.977738  #

    2023-05-23T00:53:36.079050  / # export SHELL=3D/bin/sh. /lava-10419629/=
environment

    2023-05-23T00:53:36.079796  =


    2023-05-23T00:53:36.181283  / # . /lava-10419629/environment/lava-10419=
629/bin/lava-test-runner /lava-10419629/1

    2023-05-23T00:53:36.182499  =


    2023-05-23T00:53:36.197617  / # /lava-10419629/bin/lava-test-runner /la=
va-10419629/1

    2023-05-23T00:53:36.287471  + export 'TESTRUN_ID=3D1_bootrr'

    2023-05-23T00:53:36.288071  + cd /lava-10419629/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0d16fa805f06762e85fe

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/bas=
eline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0d16fa805f06762e8603
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:46:52.844332  + set +x
    2023-05-23T00:46:52.844502  [   10.199962] <LAVA_SIGNAL_ENDRUN 0_dmesg =
956981_1.5.2.3.1>
    2023-05-23T00:46:52.952624  / # #
    2023-05-23T00:46:53.054438  export SHELL=3D/bin/sh
    2023-05-23T00:46:53.054967  #
    2023-05-23T00:46:53.156226  / # export SHELL=3D/bin/sh. /lava-956981/en=
vironment
    2023-05-23T00:46:53.156722  =

    2023-05-23T00:46:53.257996  / # . /lava-956981/environment/lava-956981/=
bin/lava-test-runner /lava-956981/1
    2023-05-23T00:46:53.258761  =

    2023-05-23T00:46:53.261402  / # /lava-956981/bin/lava-test-runner /lava=
-956981/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0e7f5db99ab7eb2e864b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0e7f5db99ab7eb2e8650
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:52:55.818344  + set[    7.140948] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 956989_1.5.2.3.1>
    2023-05-23T00:52:55.818512   +x
    2023-05-23T00:52:55.924359  / # #
    2023-05-23T00:52:56.025830  export SHELL=3D/bin/sh
    2023-05-23T00:52:56.026246  #
    2023-05-23T00:52:56.127349  / # export SHELL=3D/bin/sh. /lava-956989/en=
vironment
    2023-05-23T00:52:56.127615  =

    2023-05-23T00:52:56.228758  / # . /lava-956989/environment/lava-956989/=
bin/lava-test-runner /lava-956989/1
    2023-05-23T00:52:56.229210  =

    2023-05-23T00:52:56.231745  / # /lava-956989/bin/lava-test-runner /lava=
-956989/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0ed7595dee7a9a2e864b

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0ed7595dee7a9a2e864e
        failing since 128 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-05-23T00:54:13.451727  <8>[   17.083742] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1226973_1.5.2.4.1>
    2023-05-23T00:54:13.557408  / # #
    2023-05-23T00:54:14.717557  export SHELL=3D/bin/sh
    2023-05-23T00:54:14.723230  #
    2023-05-23T00:54:16.270620  / # export SHELL=3D/bin/sh. /lava-1226973/e=
nvironment
    2023-05-23T00:54:16.276313  =

    2023-05-23T00:54:19.098179  / # . /lava-1226973/environment/lava-122697=
3/bin/lava-test-runner /lava-1226973/1
    2023-05-23T00:54:19.104264  =

    2023-05-23T00:54:19.110945  / # /lava-1226973/bin/lava-test-runner /lav=
a-1226973/1
    2023-05-23T00:54:19.203790  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7ulp-evk                  | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0ef596b1e3720f2e85f8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx=
7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0ef596b1e3720f2e85fb
        failing since 70 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.173-cip28)

    2023-05-23T00:54:52.358045  + set +x<8>[   29.005411] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1226974_1.5.2.4.1>
    2023-05-23T00:54:52.358203  =

    2023-05-23T00:54:52.465733  / # #
    2023-05-23T00:54:53.625224  export SHELL=3D/bin/sh
    2023-05-23T00:54:53.630895  #
    2023-05-23T00:54:53.631185  / # export SHELL=3D/bin/sh
    2023-05-23T00:54:55.178419  / # . /lava-1226974/environment
    2023-05-23T00:54:58.005693  /lava-1226974/bin/lava-test-runner /lava-12=
26974/1
    2023-05-23T00:54:58.011777  . /lava-1226974/environment
    2023-05-23T00:54:58.012071  / # /lava-1226974/bin/lava-test-runner /lav=
a-1226974/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0c6de57f7dbd912e85fc

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0c6de57f7dbd912e8618
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:44:22.659906  + set +x

    2023-05-23T00:44:22.665456  <8>[   15.685339] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10419427_1.5.2.3.1>

    2023-05-23T00:44:22.773866  / # #

    2023-05-23T00:44:22.876510  export SHELL=3D/bin/sh

    2023-05-23T00:44:22.877284  #

    2023-05-23T00:44:22.979033  / # export SHELL=3D/bin/sh. /lava-10419427/=
environment

    2023-05-23T00:44:22.979810  =


    2023-05-23T00:44:23.081363  / # . /lava-10419427/environment/lava-10419=
427/bin/lava-test-runner /lava-10419427/1

    2023-05-23T00:44:23.082664  =


    2023-05-23T00:44:23.084998  / # /lava-10419427/bin/lava-test-runner /la=
va-10419427/1
 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0c6ed8044550372e863a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a=
7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/646c0c6ed8044550372e8=
63b
        new failure (last pass: v5.10.180-cip33) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/646c0e80c48824e89d2e863d

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/646c0e80c48824e89d2e866c
        failing since 127 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:53:11.021701  FIRST,<8>[   18.550006] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-05-23T00:53:11.023542   INC default to 1.

    2023-05-23T00:53:11.023593  =


    2023-05-23T00:53:11.027189  	-w	Pad to last with leading zeros

    2023-05-23T00:53:11.029765  	-s SEP	String separator

    2023-05-23T00:53:11.033716  /lava-10419628/1/../bin/lava-test-case

    2023-05-23T00:53:11.039940  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC) m=
ulti-call binary.

    2023-05-23T00:53:11.040157  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/646c0e80c48824e89d2e866d
        failing since 127 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:53:11.001331   multi-call binary.

    2023-05-23T00:53:11.001551  =


    2023-05-23T00:53:11.005911  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-05-23T00:53:11.005964  =


    2023-05-23T00:53:11.011183  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/646c0e80c48824e89d2e866e
        failing since 127 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:53:10.980531  /lava-10419628/1/../bin/lava-test-case<8>[ =
  18.513004] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RE=
SULT=3Dpass>

    2023-05-23T00:53:10.980580  =


    2023-05-23T00:53:10.999194  BusyBox v1.31.1 (2023-05-12 17:02:46 UTC)<8=
>[   18.530642] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0e80c48824e89d2e8682
        failing since 127 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:52:58.924072  <8>[    6.456430] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-05-23T00:52:58.933211  + <8>[    6.468923] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10419628_1.5.2.3.1>

    2023-05-23T00:52:58.934144  set +x

    2023-05-23T00:52:59.039575  / #

    2023-05-23T00:52:59.140258  # #export SHELL=3D/bin/sh

    2023-05-23T00:52:59.140430  =


    2023-05-23T00:52:59.240926  / # export SHELL=3D/bin/sh. /lava-10419628/=
environment

    2023-05-23T00:52:59.241065  =


    2023-05-23T00:52:59.341564  / # . /lava-10419628/environment/lava-10419=
628/bin/lava-test-runner /lava-10419628/1

    2023-05-23T00:52:59.341799  =

 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/646c0ca147c5b1cba12e85fe

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig+arm64-chromebook/gcc-10/lab-collab=
ora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/646c0ca247c5b1cba12e8604
        failing since 61 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-23T00:45:14.523973  /lava-10419451/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/646c0ca247c5b1cba12e8605
        failing since 61 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-05-23T00:45:12.466698  <8>[   60.054140] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-05-23T00:45:13.486574  /lava-10419451/1/../bin/lava-test-case

    2023-05-23T00:45:13.498283  <8>[   61.087226] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0fd692c45bc3362e8645

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i=
-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230512.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/646c0fd692c45bc3362e8671
        failing since 128 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-05-23T00:58:28.507938  + set +x
    2023-05-23T00:58:28.512012  <8>[   17.292797] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 498917_1.5.2.4.1>
    2023-05-23T00:58:28.623528  / # #
    2023-05-23T00:58:28.726077  export SHELL=3D/bin/sh
    2023-05-23T00:58:28.726639  #
    2023-05-23T00:58:28.828460  / # export SHELL=3D/bin/sh. /lava-498917/en=
vironment
    2023-05-23T00:58:28.829106  =

    2023-05-23T00:58:28.930730  / # . /lava-498917/environment/lava-498917/=
bin/lava-test-runner /lava-498917/1
    2023-05-23T00:58:28.931816  =

    2023-05-23T00:58:28.935996  / # /lava-498917/bin/lava-test-runner /lava=
-498917/1 =

    ... (12 line(s) more)  =

 =20

