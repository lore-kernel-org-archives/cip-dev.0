Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96773C41513
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 11:00:18 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.157843.1692183612324365618
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 04:00:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=PtKMFz6f;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bc7e65ea44so43497325ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692183611; x=1692788411;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gO8xHGYmRDqyMZlp5/ZxigmA4IGsTTiQnikb9gEyjFA=;
        b=PtKMFz6f3q3NqBnIv3fxkBY+SYjO2OqiT2RY6EftvfhL8WVP5eD1RXp32paIKg0Mcn
         KI/P56QWagzHmsqLLJ2xPRoBPSsux2U12GxxJHqq8r90BKhdbJDUBHU4QUwIKp+Pgbvy
         m0dL9N2cOlPnbdwuKv/DXxZQpWaZWH3fVW2jeaiJIGi3v00vrrqZQWBIEaSnP/uKzrIa
         SlQpP3ESYBCp+XG9V2pSbu9c4vTw8wYzgxoxa8l1tkMmyMJ7lZT5+2oqyk/RjR9j+fmM
         XvWu4mCH4HpPaxq+S4652PfdsCj6pVe4G+O1pX1PnzSG7aSa8M922YlMR6knllRYUpy9
         XzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692183611; x=1692788411;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gO8xHGYmRDqyMZlp5/ZxigmA4IGsTTiQnikb9gEyjFA=;
        b=W3GlWCVAWMepUXOzGwoQAKKWz0mFlmNOsz7+fZtt2zGU9olKMDRjC0Lp1ncX9LPAx+
         Aq/98kBwm7UuJ5r5FuEbkBClzU+Pv+noUWeOOnHt0bAS2eIMm1UD7Zzx7g+4+ycLZIHY
         qke/twBARIT5oz5F95AeTHMQl69H8qFg4eVJlbdbOngeoEnA58QKGhaghKhuE9wc7GZa
         IgVv1Fiql3rC0OmakKYUkYuxCiRMKynZeLL5D8QoYgh690aRedOhoCKUlVFwCbawanDO
         WAv2QbR77kKGGYV/ql8BYVqTQxySkJJOnfVIDhLuduxsGdv1KZ/qMf8GfBtZsn0hwY/P
         O6ug==
X-Gm-Message-State: AOJu0YwgIICI8ex3J8sgJOLxjyQ5lP3LrT3RG4JHlpY6WeXv1rMtwMqz
	A0RCVzGozrMtrgucW+PMPDvRxMTm6mfk5NAwxdi4Jw==
X-Google-Smtp-Source: AGHT+IGqV6oY59lsdLIZVZ4SsppTfz/Fam+QY6heGWLjcu0YQmt7dssm8dGOMPscjY33+g8DXqXo6w==
X-Received: by 2002:a17:903:11c6:b0:1b5:674d:2aa5 with SMTP id q6-20020a17090311c600b001b5674d2aa5mr2271482plh.13.1692183610637;
        Wed, 16 Aug 2023 04:00:10 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b001bbdf32f011sm12826136plg.269.2023.08.16.04.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:00:10 -0700 (PDT)
Message-ID: <64dcac3a.170a0220.d0f40.8140@mx.google.com>
Date: Wed, 16 Aug 2023 04:00:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-14-gc9b5a049d8ea
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip baseline: 114 runs,
 28 regressions (v5.10.186-cip37-14-gc9b5a049d8ea)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 11:00:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12666

cip/linux-5.10.y-cip baseline: 114 runs, 28 regressions (v5.10.186-cip37-14=
-gc9b5a049d8ea)

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

bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

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

imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =

imx7ulp-evk                  | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | cip://5.=
10.y-...64_defconfig | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 4          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-14-gc9b5a049d8ea/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-14-gc9b5a049d8ea
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c9b5a049d8ead0f771ee3424c42b20632ebc5b3b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca01d03e3a1bb4235b1e4

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dca01d03e3a1bb4235b1e9
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:08:07.859025  + set +x

    2023-08-16T10:08:07.865702  <8>[   11.438484] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11298085_1.4.2.3.1>

    2023-08-16T10:08:07.970620  / # #

    2023-08-16T10:08:08.071187  export SHELL=3D/bin/sh

    2023-08-16T10:08:08.071395  #

    2023-08-16T10:08:08.171874  / # export SHELL=3D/bin/sh. /lava-11298085/=
environment

    2023-08-16T10:08:08.172090  =


    2023-08-16T10:08:08.272622  / # . /lava-11298085/environment/lava-11298=
085/bin/lava-test-runner /lava-11298085/1

    2023-08-16T10:08:08.272908  =


    2023-08-16T10:08:08.278153  / # /lava-11298085/bin/lava-test-runner /la=
va-11298085/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca024a65a921c2635b215

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dca024a65a921c2635b21a
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:08:19.124175  + set<8>[   11.558538] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11298111_1.4.2.3.1>

    2023-08-16T10:08:19.124261   +x

    2023-08-16T10:08:19.228082  #

    2023-08-16T10:08:19.328932  / # #export SHELL=3D/bin/sh

    2023-08-16T10:08:19.329124  =


    2023-08-16T10:08:19.429711  / # export SHELL=3D/bin/sh. /lava-11298111/=
environment

    2023-08-16T10:08:19.429971  =


    2023-08-16T10:08:19.530569  / # . /lava-11298111/environment/lava-11298=
111/bin/lava-test-runner /lava-11298111/1

    2023-08-16T10:08:19.530870  =


    2023-08-16T10:08:19.532918  / # /lava-11298111/bin/lava-test-runner /la=
va-11298111/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9f4500a4e1317435b1d9

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dc9f4600a4e1317435b20b
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:04:19.002606  + set +x
    2023-08-16T10:04:19.007648  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 56520_1.5.2.=
4.1>
    2023-08-16T10:04:19.121151  / # #
    2023-08-16T10:04:19.223931  export SHELL=3D/bin/sh
    2023-08-16T10:04:19.224701  #
    2023-08-16T10:04:19.326557  / # export SHELL=3D/bin/sh. /lava-56520/env=
ironment
    2023-08-16T10:04:19.327370  =

    2023-08-16T10:04:19.429339  / # . /lava-56520/environment/lava-56520/bi=
n/lava-test-runner /lava-56520/1
    2023-08-16T10:04:19.430656  =

    2023-08-16T10:04:19.437172  / # /lava-56520/bin/lava-test-runner /lava-=
56520/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9ebea0157ae16735b1f4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline=
-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline=
-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dc9ebea0157ae16735b1f9
        failing since 21 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-16T10:04:11.357515  / # #

    2023-08-16T10:04:11.459621  export SHELL=3D/bin/sh

    2023-08-16T10:04:11.460363  #

    2023-08-16T10:04:11.561775  / # export SHELL=3D/bin/sh. /lava-11297989/=
environment

    2023-08-16T10:04:11.562490  =


    2023-08-16T10:04:11.663934  / # . /lava-11297989/environment/lava-11297=
989/bin/lava-test-runner /lava-11297989/1

    2023-08-16T10:04:11.665077  =


    2023-08-16T10:04:11.666364  / # /lava-11297989/bin/lava-test-runner /la=
va-11297989/1

    2023-08-16T10:04:11.746546  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T10:04:11.784468  + cd /lava-11297989/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9f79bf5477798735b287

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dc9f7abf5477798735b2b0
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:05:12.182266  <8>[   22.281283] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 56524_1.5.2.4.1>
    2023-08-16T10:05:12.290786  / # #
    2023-08-16T10:05:12.393572  export SHELL=3D/bin/sh
    2023-08-16T10:05:12.394394  #
    2023-08-16T10:05:12.496750  / # export SHELL=3D/bin/sh. /lava-56524/env=
ironment
    2023-08-16T10:05:12.497488  =

    2023-08-16T10:05:12.599852  / # . /lava-56524/environment/lava-56524/bi=
n/lava-test-runner /lava-56524/1
    2023-08-16T10:05:12.601051  =

    2023-08-16T10:05:12.604901  / # /lava-56524/bin/lava-test-runner /lava-=
56524/1
    2023-08-16T10:05:12.700342  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9f83c78af4c31035b253

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dc9f83c78af4c31035b256
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:05:14.149469  / # #
    2023-08-16T10:05:14.253471  export SHELL=3D/bin/sh
    2023-08-16T10:05:14.254447  #
    2023-08-16T10:05:14.356565  / # export SHELL=3D/bin/sh. /lava-997815/en=
vironment
    2023-08-16T10:05:14.357634  =

    2023-08-16T10:05:14.459888  / # . /lava-997815/environment/lava-997815/=
bin/lava-test-runner /lava-997815/1
    2023-08-16T10:05:14.461447  =

    2023-08-16T10:05:14.473551  / # /lava-997815/bin/lava-test-runner /lava=
-997815/1
    2023-08-16T10:05:14.597477  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-16T10:05:14.598032  + cd /lava-997815/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca33ac3d0c2be7035b239

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dca33ac3d0c2be7035b269
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:21:29.952817  <8>[   19.903272] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 56573_1.5.2.4.1>
    2023-08-16T10:21:30.063252  / # #
    2023-08-16T10:21:30.166325  export SHELL=3D/bin/sh
    2023-08-16T10:21:30.167116  #
    2023-08-16T10:21:30.269497  / # export SHELL=3D/bin/sh. /lava-56573/env=
ironment
    2023-08-16T10:21:30.270248  =

    2023-08-16T10:21:30.372693  / # . /lava-56573/environment/lava-56573/bi=
n/lava-test-runner /lava-56573/1
    2023-08-16T10:21:30.373880  =

    2023-08-16T10:21:30.378342  / # /lava-56573/bin/lava-test-runner /lava-=
56573/1
    2023-08-16T10:21:30.483096  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca31ac3d0c2be7035b1de

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dca31ac3d0c2be7035b1e1
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:21:01.571130  + set +x
    2023-08-16T10:21:01.573167  <8>[   13.950371] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997840_1.5.2.4.1>
    2023-08-16T10:21:01.681822  / # #
    2023-08-16T10:21:01.783807  export SHELL=3D/bin/sh
    2023-08-16T10:21:01.784471  #
    2023-08-16T10:21:01.885894  / # export SHELL=3D/bin/sh. /lava-997840/en=
vironment
    2023-08-16T10:21:01.886392  =

    2023-08-16T10:21:01.987795  / # . /lava-997840/environment/lava-997840/=
bin/lava-test-runner /lava-997840/1
    2023-08-16T10:21:01.988582  =

    2023-08-16T10:21:01.990702  / # /lava-997840/bin/lava-test-runner /lava=
-997840/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca01fa65a921c2635b1d9

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dca01fa65a921c2635b1de
        failing since 124 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-16T10:08:15.641720  + set +x

    2023-08-16T10:08:15.648100  <8>[   14.870080] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11298107_1.4.2.3.1>

    2023-08-16T10:08:15.753653  / # #

    2023-08-16T10:08:15.854674  export SHELL=3D/bin/sh

    2023-08-16T10:08:15.854910  #

    2023-08-16T10:08:15.955403  / # export SHELL=3D/bin/sh. /lava-11298107/=
environment

    2023-08-16T10:08:15.955614  =


    2023-08-16T10:08:16.056112  / # . /lava-11298107/environment/lava-11298=
107/bin/lava-test-runner /lava-11298107/1

    2023-08-16T10:08:16.056411  =


    2023-08-16T10:08:16.061014  / # /lava-11298107/bin/lava-test-runner /la=
va-11298107/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca02503e3a1bb4235b218

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dca02503e3a1bb4235b21d
        failing since 124 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-08-16T10:08:14.661403  <8>[   11.659152] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11298121_1.4.2.3.1>

    2023-08-16T10:08:14.664359  + set +x

    2023-08-16T10:08:14.765848  #

    2023-08-16T10:08:14.766180  =


    2023-08-16T10:08:14.866904  / # #export SHELL=3D/bin/sh

    2023-08-16T10:08:14.867092  =


    2023-08-16T10:08:14.967639  / # export SHELL=3D/bin/sh. /lava-11298121/=
environment

    2023-08-16T10:08:14.967844  =


    2023-08-16T10:08:15.068372  / # . /lava-11298121/environment/lava-11298=
121/bin/lava-test-runner /lava-11298121/1

    2023-08-16T10:08:15.068632  =

 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9f38ab6e533d8535b26f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dc9f38ab6e533d8535b274
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:04:36.713813  / # #

    2023-08-16T10:04:36.814522  export SHELL=3D/bin/sh

    2023-08-16T10:04:36.814736  #

    2023-08-16T10:04:36.915294  / # export SHELL=3D/bin/sh. /lava-11298037/=
environment

    2023-08-16T10:04:36.915525  =


    2023-08-16T10:04:37.016136  / # . /lava-11298037/environment/lava-11298=
037/bin/lava-test-runner /lava-11298037/1

    2023-08-16T10:04:37.016474  =


    2023-08-16T10:04:37.027221  / # /lava-11298037/bin/lava-test-runner /la=
va-11298037/1

    2023-08-16T10:04:37.131236  + export 'TESTRUN_ID=3D1_bootrr'

    2023-08-16T10:04:37.131376  + cd /lava-11298037/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9f8bd7e20cbbd235b1e2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6=
ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6=
ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dc9f8cd7e20cbbd235b1e7
        failing since 147 days (last pass: v5.10.145-cip17, first fail: v5.=
10.175-cip29)

    2023-08-16T10:05:48.436154  + set +x
    2023-08-16T10:05:48.439333  <8>[   29.138846] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1244005_1.5.2.4.1>
    2023-08-16T10:05:48.550495  / # #
    2023-08-16T10:05:49.706288  export SHELL=3D/bin/sh
    2023-08-16T10:05:49.711949  #
    2023-08-16T10:05:51.253781  / # export SHELL=3D/bin/sh. /lava-1244005/e=
nvironment
    2023-08-16T10:05:51.259412  =

    2023-08-16T10:05:54.070158  / # . /lava-1244005/environment/lava-124400=
5/bin/lava-test-runner /lava-1244005/1
    2023-08-16T10:05:54.075844  =

    2023-08-16T10:05:54.077668  / # /lava-1244005/bin/lava-test-runner /lav=
a-1244005/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7d-sdb                    | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9f9fd7e20cbbd235b1fb

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7=
d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7=
d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dc9f9fd7e20cbbd235b200
        failing since 214 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-08-16T10:05:55.489622  / # #
    2023-08-16T10:05:56.644781  export SHELL=3D/bin/sh
    2023-08-16T10:05:56.650393  #
    2023-08-16T10:05:58.192264  / # export SHELL=3D/bin/sh. /lava-1244003/e=
nvironment
    2023-08-16T10:05:58.197948  =

    2023-08-16T10:06:01.009749  / # . /lava-1244003/environment/lava-124400=
3/bin/lava-test-runner /lava-1244003/1
    2023-08-16T10:06:01.015685  =

    2023-08-16T10:06:01.029765  / # /lava-1244003/bin/lava-test-runner /lav=
a-1244003/1
    2023-08-16T10:06:01.113620  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-16T10:06:01.113881  + cd /lava-1244003/1/tests/1_bootrr =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx7ulp-evk                  | arm    | lab-nxp       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9fc7af6979ce7c35b21f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7=
ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7=
ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dc9fc7af6979ce7c35b224
        failing since 155 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-08-16T10:06:31.561943  + set +x
    2023-08-16T10:06:31.564104  <8>[   29.011699] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1244006_1.5.2.4.1>
    2023-08-16T10:06:31.674025  / # #
    2023-08-16T10:06:32.829820  export SHELL=3D/bin/sh
    2023-08-16T10:06:32.835453  #
    2023-08-16T10:06:32.835794  / # export SHELL=3D/bin/sh
    2023-08-16T10:06:34.377684  / # . /lava-1244006/environment
    2023-08-16T10:06:37.198644  /lava-1244006/bin/lava-test-runner /lava-12=
44006/1
    2023-08-16T10:06:37.204575  . /lava-1244006/environment
    2023-08-16T10:06:37.204816  / # /lava-1244006/bin/lava-test-runner /lav=
a-1244006/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | cip://5.=
10.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca2a24ee28d79f335b1d9

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dca2a24ee28d79f335b214
        failing since 21 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-16T10:18:37.472841  / # #
    2023-08-16T10:18:37.575616  export SHELL=3D/bin/sh
    2023-08-16T10:18:37.576403  #
    2023-08-16T10:18:37.678265  / # export SHELL=3D/bin/sh. /lava-56565/env=
ironment
    2023-08-16T10:18:37.679053  =

    2023-08-16T10:18:37.781051  / # . /lava-56565/environment/lava-56565/bi=
n/lava-test-runner /lava-56565/1
    2023-08-16T10:18:37.782331  =

    2023-08-16T10:18:37.797057  / # /lava-56565/bin/lava-test-runner /lava-=
56565/1
    2023-08-16T10:18:37.852915  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-16T10:18:37.853441  + cd /lava-56565/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9ff9111acf38f735b217

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dc9ff9111acf38f735b253
        failing since 21 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-16T10:07:24.512970  <8>[   19.537511] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 56531_1.5.2.4.1>
    2023-08-16T10:07:24.620841  / # #
    2023-08-16T10:07:24.723568  export SHELL=3D/bin/sh
    2023-08-16T10:07:24.724299  #
    2023-08-16T10:07:24.826204  / # export SHELL=3D/bin/sh. /lava-56531/env=
ironment
    2023-08-16T10:07:24.826977  =

    2023-08-16T10:07:24.928986  / # . /lava-56531/environment/lava-56531/bi=
n/lava-test-runner /lava-56531/1
    2023-08-16T10:07:24.930259  =

    2023-08-16T10:07:24.944335  / # /lava-56531/bin/lava-test-runner /lava-=
56531/1
    2023-08-16T10:07:25.121053  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca056bedcc42d8535b1e6

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dca056bedcc42d8535b202
        failing since 214 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:09:18.583741  <8>[   15.549574] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-16T10:09:18.585766  + set +x

    2023-08-16T10:09:18.592011  <8>[   15.559193] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11298133_1.5.2.3.1>

    2023-08-16T10:09:18.695393  =


    2023-08-16T10:09:18.796023  / # #export SHELL=3D/bin/sh

    2023-08-16T10:09:18.796246  =


    2023-08-16T10:09:18.896842  / # export SHELL=3D/bin/sh. /lava-11298133/=
environment

    2023-08-16T10:09:18.897060  =


    2023-08-16T10:09:18.997634  / # . /lava-11298133/environment/lava-11298=
133/bin/lava-test-runner /lava-11298133/1

    2023-08-16T10:09:18.997930  =

 =

    ... (22 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca19991808fc44535b1da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dca19991808fc44535b=
1db
        failing since 72 days (last pass: v5.10.180-cip34, first fail: v5.1=
0.180-cip34-19-gf0f6960f132cd) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dc9f97d7e20cbbd235b1ee

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r=
8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r=
8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dc9f97d7e20cbbd235b1f1
        failing since 7 days (last pass: v5.10.182-cip35, first fail: v5.10=
.186-cip37-13-g260094841fe1a)

    2023-08-16T10:06:00.703109  + set +x
    2023-08-16T10:06:00.703558  <8>[   87.662325] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997822_1.5.2.4.1>
    2023-08-16T10:06:00.816355  #
    2023-08-16T10:06:02.283781  / # #export SHELL=3D/bin/sh
    2023-08-16T10:06:02.305234  =

    2023-08-16T10:06:02.305885  / # export SHELL=3D/bin/sh
    2023-08-16T10:06:04.201605  / # . /lava-997822/environment
    2023-08-16T10:06:07.678492  /lava-997822/bin/lava-test-runner /lava-997=
822/1
    2023-08-16T10:06:07.700429  . /lava-997822/environment
    2023-08-16T10:06:07.700857  / # /lava-997822/bin/lava-test-runner /lava=
-997822/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca09bba9ce2e01135b1e1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dca09bba9ce2e01135b1e4
        failing since 21 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-16T10:10:15.957770  + set +x
    2023-08-16T10:10:15.958322  <8>[   83.769356] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997824_1.5.2.4.1>
    2023-08-16T10:10:16.066917  / # #
    2023-08-16T10:10:17.539190  export SHELL=3D/bin/sh
    2023-08-16T10:10:17.560468  #
    2023-08-16T10:10:17.561025  / # export SHELL=3D/bin/sh
    2023-08-16T10:10:19.455914  / # . /lava-997824/environment
    2023-08-16T10:10:22.929518  /lava-997824/bin/lava-test-runner /lava-997=
824/1
    2023-08-16T10:10:22.951348  . /lava-997824/environment
    2023-08-16T10:10:22.951783  / # /lava-997824/bin/lava-test-runner /lava=
-997824/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca1fcdb9554072035b248

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dca1fcdb9554072035b24b
        failing since 21 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-16T10:15:59.230202  + set +x
    2023-08-16T10:15:59.230423  <8>[   84.014004] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 997829_1.5.2.4.1>
    2023-08-16T10:15:59.337067  / # #
    2023-08-16T10:16:00.799170  export SHELL=3D/bin/sh
    2023-08-16T10:16:00.819749  #
    2023-08-16T10:16:00.819982  / # export SHELL=3D/bin/sh
    2023-08-16T10:16:02.703358  / # . /lava-997829/environment
    2023-08-16T10:16:06.160908  /lava-997829/bin/lava-test-runner /lava-997=
829/1
    2023-08-16T10:16:06.181708  . /lava-997829/environment
    2023-08-16T10:16:06.181821  / # /lava-997829/bin/lava-test-runner /lava=
-997829/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca0083a6167df2035b200

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r=
8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r=
8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dca0083a6167df2035b203
        failing since 21 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-16T10:07:44.174671  / # #
    2023-08-16T10:07:45.637948  export SHELL=3D/bin/sh
    2023-08-16T10:07:45.658526  #
    2023-08-16T10:07:45.658735  / # export SHELL=3D/bin/sh
    2023-08-16T10:07:47.544880  / # . /lava-997820/environment
    2023-08-16T10:07:51.002387  /lava-997820/bin/lava-test-runner /lava-997=
820/1
    2023-08-16T10:07:51.023601  . /lava-997820/environment
    2023-08-16T10:07:51.023825  / # /lava-997820/bin/lava-test-runner /lava=
-997820/1
    2023-08-16T10:07:51.205580  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-16T10:07:51.205804  + cd /lava-997820/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca10d2867dbea3135b1f6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dca10d2867dbea3135b1f9
        failing since 21 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-08-16T10:12:01.186070  / # #
    2023-08-16T10:12:02.649598  export SHELL=3D/bin/sh
    2023-08-16T10:12:02.670206  #
    2023-08-16T10:12:02.670416  / # export SHELL=3D/bin/sh
    2023-08-16T10:12:04.556328  / # . /lava-997826/environment
    2023-08-16T10:12:08.014898  /lava-997826/bin/lava-test-runner /lava-997=
826/1
    2023-08-16T10:12:08.035695  . /lava-997826/environment
    2023-08-16T10:12:08.035806  / # /lava-997826/bin/lava-test-runner /lava=
-997826/1
    2023-08-16T10:12:08.115073  + export 'TESTRUN_ID=3D1_bootrr'
    2023-08-16T10:12:08.115444  + cd /lava-997826/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/64dc9f36ab6e533d8535b224

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/64dc9f36ab6e533d8535b253
        failing since 212 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:05:51.687515  FIRST,<8>[   19.001308] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-08-16T10:05:51.691137   INC default to 1.

    2023-08-16T10:05:51.691354  =


    2023-08-16T10:05:51.694991  	-w	Pad to last with leading zeros

    2023-08-16T10:05:51.697515  	-s SEP	String separator

    2023-08-16T10:05:51.701317  /lava-11298035/1/../bin/lava-test-case

    2023-08-16T10:05:51.707377  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-08-16T10:05:51.707597  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64dc9f36ab6e533d8535b254
        failing since 212 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:05:51.663568  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.982152] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-08-16T10:05:51.667044   multi-call binary.

    2023-08-16T10:05:51.667269  =


    2023-08-16T10:05:51.671904  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-16T10:05:51.671957  =


    2023-08-16T10:05:51.676981  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64dc9f36ab6e533d8535b255
        failing since 212 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:05:51.644578  =

   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64dc9f37ab6e533d8535b269
        failing since 212 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-08-16T10:05:39.586852  <8>[    6.906496] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-08-16T10:05:39.596546  + <8>[    6.918976] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11298035_1.5.2.3.1>

    2023-08-16T10:05:39.599196  set +x

    2023-08-16T10:05:39.702691  =


    2023-08-16T10:05:39.803262  / # #export SHELL=3D/bin/sh

    2023-08-16T10:05:39.803516  =


    2023-08-16T10:05:39.904104  / # export SHELL=3D/bin/sh. /lava-11298035/=
environment

    2023-08-16T10:05:39.904331  =


    2023-08-16T10:05:40.004907  / # . /lava-11298035/environment/lava-11298=
035/bin/lava-test-runner /lava-11298035/1

    2023-08-16T10:05:40.005255  =

 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/64dca179ac0d1d7e0935b1e5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-14-gc9b5a049d8ea/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dca179ac0d1d7e0935b=
1e6
        new failure (last pass: v5.10.186-cip37-13-g260094841fe1a) =

 =20

