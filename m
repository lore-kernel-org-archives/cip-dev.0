Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E150CEE01F1
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 17:10:01 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.2679.1694624996749341245
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 10:09:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=h5iS4vW0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-68fb46f38f9so4598b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694624996; x=1695229796; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P9yM7VabzRTj+e/DWBA8yCNISkHzJly03syG8VWYR24=;
        b=h5iS4vW06eCt8M5YbR8mZ8sUM0SvVj+Ym7MNaZv+mlvAupP8L0HVCfmrnmFqlyuP0S
         EdxktdyxH9S5cSsObJ9yoAYSYfdRGK5rL+MDhMqxtpWtcF08fMlTXwa85iaFdFdOMasn
         zBo0TrQdOJFYaagb4WipXweSTH359Rx5/31oRaYNSM5NsdYaUszVfbsX1ABgNnUda7IZ
         DQVxYAeanMZplN3VHietm6HsL8oszmkCDB4bgO8qifk9zEh90mnnruy3wvRRibZYS8Wi
         SqUxye+ScSKUTm70TXLt9VrHP7ZpjyjjgAdou9bhmCPuJJ8MnqWOQYI6KZVlS0oCy8Uk
         4T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624996; x=1695229796;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9yM7VabzRTj+e/DWBA8yCNISkHzJly03syG8VWYR24=;
        b=OYxStl/dH3zetIqVXO7Ily9KcPM2dm4Ty2Yshh1LgU6n4MT3nMujghnP919G7mjvRG
         duDkFAmBjL4u8y7dhIgvjqyy1GtiKfKbTYq4P44g9pw1b99X9cNICMn/i05HNeBV3QLZ
         OhqUIREqCcdgzlAuzUMbdolwZ8JYUrGFqowQ7IKaR+Jy4K8zsACADmTEHicfnNR1y6EF
         AeDkhMTGeaESu9TNsd/4xVZ/aKfZp/Tl9Rlx91CCCj0Sq6xy35MXGJNlZAcpBOmJ45C3
         eosgs3iZuGTEkd9LaEf6QAIoPY0R6bld/23MMDtgbcBEa+mdc1DFowcWsHushrmiDmAM
         zBVA==
X-Gm-Message-State: AOJu0YwSLhvSlb1aoj+TZHn0QumLrEw7OAQR+o88S/dR/28v+8+QbHjf
	UlNyb/iJFPW9VDg5uis5HNcpZVVXtWMaRlFf5no=
X-Google-Smtp-Source: AGHT+IGBBd3eZCf2+FbW7gV5/2sMnJS9ysfdQYBP7D1woiwBb5ytlamBGsj7KZLXVJQkn0ssGqh39g==
X-Received: by 2002:a05:6a20:f3b0:b0:14d:382c:f908 with SMTP id qr48-20020a056a20f3b000b0014d382cf908mr2738745pzb.32.1694624994938;
        Wed, 13 Sep 2023 10:09:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a194c00b00267eead2f16sm1815063pjh.36.2023.09.13.10.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:09:54 -0700 (PDT)
Message-ID: <6501ece2.170a0220.b69c1.611d@mx.google.com>
Date: Wed, 13 Sep 2023 10:09:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.191-cip38-29-g9e1aa2001db8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline: 141 runs,
 34 regressions (v5.10.191-cip38-29-g9e1aa2001db8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 17:10:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13114

cip/linux-5.10.y-cip baseline: 141 runs, 34 regressions (v5.10.191-cip38-29=
-g9e1aa2001db8)

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

bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =

beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =

imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =

imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =

imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =

juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =

r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =

rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38-29-g9e1aa2001db8/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38-29-g9e1aa2001db8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9e1aa2001db862da32812062860b8756cbc8890a =



Test Regressions
---------------- =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e0136ebc6e03668a0a9d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e0136ebc6e03668a0aa6
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:14:58.725725  + set +x

    2023-09-13T16:14:58.732205  <8>[   11.664340] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517394_1.4.2.3.1>

    2023-09-13T16:14:58.840117  =


    2023-09-13T16:14:58.940635  / # #export SHELL=3D/bin/sh

    2023-09-13T16:14:58.940827  =


    2023-09-13T16:14:59.041284  / # export SHELL=3D/bin/sh. /lava-11517394/=
environment

    2023-09-13T16:14:59.041467  =


    2023-09-13T16:14:59.141971  / # . /lava-11517394/environment/lava-11517=
394/bin/lava-test-runner /lava-11517394/1

    2023-09-13T16:14:59.142236  =


    2023-09-13T16:14:59.146981  / # /lava-11517394/bin/lava-test-runner /la=
va-11517394/1
 =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e012a94b84b1368a0a4e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e012a94b84b1368a0a57
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:15:02.681003  + set +x

    2023-09-13T16:15:02.686486  <8>[   11.341535] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517389_1.4.2.3.1>

    2023-09-13T16:15:02.794282  #

    2023-09-13T16:15:02.896740  / # #export SHELL=3D/bin/sh

    2023-09-13T16:15:02.897452  =


    2023-09-13T16:15:02.998845  / # export SHELL=3D/bin/sh. /lava-11517389/=
environment

    2023-09-13T16:15:02.999557  =


    2023-09-13T16:15:02.999963  / # <4>[   11.578585] i2c_designware i2c_de=
signware.5: timeout in disabling adapter

    2023-09-13T16:15:03.101317  . /lava-11517389/environment/lava-11517389/=
bin/lava-test-runner /lava-11517389/1

    2023-09-13T16:15:03.102426  =

 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
at91sam9g20ek                | arm    | lab-broonie     | gcc-10   | multi_=
v5_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501dfc114a4e6aada8a0a74

  Results:     47 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-=
at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501dfc114a4e6aada8a0aad
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:13:18.475814  + set +x
    2023-09-13T16:13:18.476299  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 105337_1.5.2=
.4.1>
    2023-09-13T16:13:18.590421  / # #
    2023-09-13T16:13:18.693683  export SHELL=3D/bin/sh
    2023-09-13T16:13:18.694545  #
    2023-09-13T16:13:18.796533  / # export SHELL=3D/bin/sh. /lava-105337/en=
vironment
    2023-09-13T16:13:18.797364  =

    2023-09-13T16:13:18.899403  / # . /lava-105337/environment/lava-105337/=
bin/lava-test-runner /lava-105337/1
    2023-09-13T16:13:18.900930  =

    2023-09-13T16:13:18.904605  / # /lava-105337/bin/lava-test-runner /lava=
-105337/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora   | gcc-10   | bcm283=
5_defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e237b60419c12e8a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline=
-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/bcm2835_defconfig/gcc-10/lab-collabora/baseline=
-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e237b60419c12e8a0a4b
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T16:28:24.686429  / # #

    2023-09-13T16:28:24.786797  export SHELL=3D/bin/sh

    2023-09-13T16:28:24.786913  #

    2023-09-13T16:28:24.887357  / # export SHELL=3D/bin/sh. /lava-11517445/=
environment

    2023-09-13T16:28:24.887452  =


    2023-09-13T16:28:24.987863  / # . /lava-11517445/environment/lava-11517=
445/bin/lava-test-runner /lava-11517445/1

    2023-09-13T16:28:24.988033  =


    2023-09-13T16:28:25.000113  / # /lava-11517445/bin/lava-test-runner /la=
va-11517445/1

    2023-09-13T16:28:25.108644  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T16:28:25.109226  + cd /lava-11517445/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e2dad3d04b91428a0a4e

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e2dbd3d04b91428a0a7f
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:26:32.288790  <8>[   21.622678] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 105401_1.5.2.4.1>
    2023-09-13T16:26:32.398183  / # #
    2023-09-13T16:26:32.501293  export SHELL=3D/bin/sh
    2023-09-13T16:26:32.502217  #
    2023-09-13T16:26:32.604290  / # export SHELL=3D/bin/sh. /lava-105401/en=
vironment
    2023-09-13T16:26:32.605248  =

    2023-09-13T16:26:32.707400  / # . /lava-105401/environment/lava-105401/=
bin/lava-test-runner /lava-105401/1
    2023-09-13T16:26:32.708885  =

    2023-09-13T16:26:32.713215  / # /lava-105401/bin/lava-test-runner /lava=
-105401/1
    2023-09-13T16:26:32.809534  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e2e9d3d04b91428a0a9d

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e2e9d3d04b91428a0aa4
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:26:41.240776  <8>[   15.720377] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1008514_1.5.2.4.1>
    2023-09-13T16:26:41.349924  / # #
    2023-09-13T16:26:41.452757  export SHELL=3D/bin/sh
    2023-09-13T16:26:41.453461  #
    2023-09-13T16:26:41.555316  / # export SHELL=3D/bin/sh. /lava-1008514/e=
nvironment
    2023-09-13T16:26:41.556022  =

    2023-09-13T16:26:41.657867  / # . /lava-1008514/environment/lava-100851=
4/bin/lava-test-runner /lava-1008514/1
    2023-09-13T16:26:41.659021  =

    2023-09-13T16:26:41.665695  / # /lava-1008514/bin/lava-test-runner /lav=
a-1008514/1
    2023-09-13T16:26:41.758732  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-broonie     | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e033a6fb1cf2b88a0a4f

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e034a6fb1cf2b88a0a83
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:15:24.715629  <8>[   25.469169] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 105341_1.5.2.4.1>
    2023-09-13T16:15:24.824358  / # #
    2023-09-13T16:15:24.927366  export SHELL=3D/bin/sh
    2023-09-13T16:15:24.928080  #
    2023-09-13T16:15:25.030197  / # export SHELL=3D/bin/sh. /lava-105341/en=
vironment
    2023-09-13T16:15:25.030886  =

    2023-09-13T16:15:25.133010  / # . /lava-105341/environment/lava-105341/=
bin/lava-test-runner /lava-105341/1
    2023-09-13T16:15:25.134190  =

    2023-09-13T16:15:25.139041  / # /lava-105341/bin/lava-test-runner /lava=
-105341/1
    2023-09-13T16:15:25.240212  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
beaglebone-black             | arm    | lab-cip         | gcc-10   | omap2p=
lus_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e055a6fb1cf2b88a0b5d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e055a6fb1cf2b88a0b64
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:15:54.067986  <8>[   13.160371] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1008499_1.5.2.4.1>
    2023-09-13T16:15:54.179193  / # #
    2023-09-13T16:15:54.281891  export SHELL=3D/bin/sh
    2023-09-13T16:15:54.282602  #
    2023-09-13T16:15:54.384497  / # export SHELL=3D/bin/sh. /lava-1008499/e=
nvironment
    2023-09-13T16:15:54.385241  =

    2023-09-13T16:15:54.487102  / # . /lava-1008499/environment/lava-100849=
9/bin/lava-test-runner /lava-1008499/1
    2023-09-13T16:15:54.488283  =

    2023-09-13T16:15:54.494894  / # /lava-1008499/bin/lava-test-runner /lav=
a-1008499/1
    2023-09-13T16:15:54.602564  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e21004cedd40518a0a71

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a=
-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1028a=
-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e21004cedd40518a0a78
        failing since 184 days (last pass: v5.10.155-cip21, first fail: v5.=
10.173-cip28)

    2023-09-13T16:23:31.186115  [   23.991021] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1251205_1.5.2.4.1>
    2023-09-13T16:23:31.291959  =

    2023-09-13T16:23:31.393206  / # #export SHELL=3D/bin/sh
    2023-09-13T16:23:31.393653  =

    2023-09-13T16:23:31.494632  / # export SHELL=3D/bin/sh. /lava-1251205/e=
nvironment
    2023-09-13T16:23:31.495072  =

    2023-09-13T16:23:31.596079  / # . /lava-1251205/environment/lava-125120=
5/bin/lava-test-runner /lava-1251205/1
    2023-09-13T16:23:31.596834  =

    2023-09-13T16:23:31.600918  / # /lava-1251205/bin/lava-test-runner /lav=
a-1251205/1
    2023-09-13T16:23:31.619302  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
fsl-ls1088a-rdb              | arm64  | lab-nxp         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e20e04cedd40518a0a66

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a=
-rdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-nxp/baseline-fsl-ls1088a=
-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e20e04cedd40518a0a6d
        failing since 242 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-09-13T16:23:22.556931  [   10.567334] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1251204_1.5.2.4.1>
    2023-09-13T16:23:22.662856  =

    2023-09-13T16:23:22.764132  / # #export SHELL=3D/bin/sh
    2023-09-13T16:23:22.764579  =

    2023-09-13T16:23:22.865573  / # export SHELL=3D/bin/sh. /lava-1251204/e=
nvironment
    2023-09-13T16:23:22.866023  =

    2023-09-13T16:23:22.967023  / # . /lava-1251204/environment/lava-125120=
4/bin/lava-test-runner /lava-1251204/1
    2023-09-13T16:23:22.967804  =

    2023-09-13T16:23:22.971818  / # /lava-1251204/bin/lava-test-runner /lav=
a-1251204/1
    2023-09-13T16:23:22.987827  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e034220baf7a848a0a61

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e034220baf7a848a0a6a
        failing since 152 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-09-13T16:15:31.411837  + set +x

    2023-09-13T16:15:31.418259  <8>[   10.124819] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517395_1.4.2.3.1>

    2023-09-13T16:15:31.523241  / # #

    2023-09-13T16:15:31.623919  export SHELL=3D/bin/sh

    2023-09-13T16:15:31.624110  #

    2023-09-13T16:15:31.724640  / # export SHELL=3D/bin/sh. /lava-11517395/=
environment

    2023-09-13T16:15:31.724838  =


    2023-09-13T16:15:31.825340  / # . /lava-11517395/environment/lava-11517=
395/bin/lava-test-runner /lava-11517395/1

    2023-09-13T16:15:31.825736  =


    2023-09-13T16:15:31.830116  / # /lava-11517395/bin/lava-test-runner /la=
va-11517395/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora   | gcc-10   | x86_64=
_defcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e01aa983d8a7968a0a64

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e01aa983d8a7968a0a6d
        failing since 152 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-09-13T16:15:08.895015  <8>[   13.254670] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517392_1.4.2.3.1>

    2023-09-13T16:15:08.898674  + set +x

    2023-09-13T16:15:09.006028  / # #

    2023-09-13T16:15:09.108398  export SHELL=3D/bin/sh

    2023-09-13T16:15:09.109091  #

    2023-09-13T16:15:09.210310  / # export SHELL=3D/bin/sh. /lava-11517392/=
environment

    2023-09-13T16:15:09.210501  =


    2023-09-13T16:15:09.311233  / # . /lava-11517392/environment/lava-11517=
392/bin/lava-test-runner /lava-11517392/1

    2023-09-13T16:15:09.312475  =


    2023-09-13T16:15:09.317144  / # /lava-11517392/bin/lava-test-runner /la=
va-11517392/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6q-sabrelite              | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e2bf70c2cdf7418a0a4a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e2bf70c2cdf7418a0a53
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:26:39.022812  / # #

    2023-09-13T16:26:39.124887  export SHELL=3D/bin/sh

    2023-09-13T16:26:39.125538  #

    2023-09-13T16:26:39.226904  / # export SHELL=3D/bin/sh. /lava-11517462/=
environment

    2023-09-13T16:26:39.227597  =


    2023-09-13T16:26:39.329029  / # . /lava-11517462/environment/lava-11517=
462/bin/lava-test-runner /lava-11517462/1

    2023-09-13T16:26:39.330080  =


    2023-09-13T16:26:39.371981  / # /lava-11517462/bin/lava-test-runner /la=
va-11517462/1

    2023-09-13T16:26:39.395163  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T16:26:39.437062  + cd /lava-11517462/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | imx_v6=
_v7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e2d670c2cdf7418a0a66

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/imx_v6_v7_defconfig/gcc-10/lab-pengutronix/base=
line-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e2d670c2cdf7418a0a6f
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:26:56.601969  + set +x
    2023-09-13T16:26:56.602150  [   10.260086] <LAVA_SIGNAL_ENDRUN 0_dmesg =
1000379_1.5.2.3.1>
    2023-09-13T16:26:56.710391  / # #
    2023-09-13T16:26:56.811966  export SHELL=3D/bin/sh
    2023-09-13T16:26:56.812479  #
    2023-09-13T16:26:56.913863  / # export SHELL=3D/bin/sh. /lava-1000379/e=
nvironment
    2023-09-13T16:26:56.914375  =

    2023-09-13T16:26:57.015697  / # . /lava-1000379/environment/lava-100037=
9/bin/lava-test-runner /lava-1000379/1
    2023-09-13T16:26:57.016459  =

    2023-09-13T16:26:57.019220  / # /lava-1000379/bin/lava-test-runner /lav=
a-1000379/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6qp-wandboard-revd1       | arm    | lab-pengutronix | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e29a3228148eba8a0a78

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-pengutronix/basel=
ine-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e29a3228148eba8a0a81
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:25:42.483550  + set[    7.281954] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 1000378_1.5.2.3.1>
    2023-09-13T16:25:42.483733   +x
    2023-09-13T16:25:42.589798  / # #
    2023-09-13T16:25:42.691565  export SHELL=3D/bin/sh
    2023-09-13T16:25:42.692050  #
    2023-09-13T16:25:42.793240  / # export SHELL=3D/bin/sh. /lava-1000378/e=
nvironment
    2023-09-13T16:25:42.793724  =

    2023-09-13T16:25:42.895055  / # . /lava-1000378/environment/lava-100037=
8/bin/lava-test-runner /lava-1000378/1
    2023-09-13T16:25:42.895629  =

    2023-09-13T16:25:42.898105  / # /lava-1000378/bin/lava-test-runner /lav=
a-1000378/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx6ul-14x14-evk             | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e2ead3d04b91428a0ad0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6=
ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx6=
ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e2ead3d04b91428a0ad7
        failing since 175 days (last pass: v5.10.145-cip17, first fail: v5.=
10.175-cip29)

    2023-09-13T16:26:59.274089  + set +x
    2023-09-13T16:26:59.277262  <8>[   29.280932] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1251208_1.5.2.4.1>
    2023-09-13T16:26:59.385689  / # #
    2023-09-13T16:27:00.541878  export SHELL=3D/bin/sh
    2023-09-13T16:27:00.547427  #
    2023-09-13T16:27:02.089049  / # export SHELL=3D/bin/sh. /lava-1251208/e=
nvironment
    2023-09-13T16:27:02.094678  =

    2023-09-13T16:27:04.907148  / # . /lava-1251208/environment/lava-125120=
8/bin/lava-test-runner /lava-1251208/1
    2023-09-13T16:27:04.913111  =

    2023-09-13T16:27:04.914893  / # /lava-1251208/bin/lava-test-runner /lav=
a-1251208/1 =

    ... (18 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
imx7d-sdb                    | arm    | lab-nxp         | gcc-10   | multi_=
v7_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e2d570c2cdf7418a0a58

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7=
d-sdb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseline-imx7=
d-sdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e2d570c2cdf7418a0a5f
        failing since 242 days (last pass: v5.10.155-cip21, first fail: v5.=
10.162-cip24)

    2023-09-13T16:26:46.771848  / # #
    2023-09-13T16:26:47.927934  export SHELL=3D/bin/sh
    2023-09-13T16:26:47.933566  #
    2023-09-13T16:26:49.475637  / # export SHELL=3D/bin/sh. /lava-1251207/e=
nvironment
    2023-09-13T16:26:49.481272  =

    2023-09-13T16:26:49.481603  / # . /lava-1251207/environment
    2023-09-13T16:26:52.293824  / # /lava-1251207/bin/lava-test-runner /lav=
a-1251207/1
    2023-09-13T16:26:52.310979  /lava-1251207/bin/lava-test-runner /lava-12=
51207/1
    2023-09-13T16:26:52.399677  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-13T16:26:52.400045  + cd /lava-1251207/1/tests/1_bootrr =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | cip://=
5.10.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e6cbf30aa150528a0a44

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e6cbf30aa150528a0a82
        failing since 16 days (last pass: v5.10.186-cip37-27-gd6d928db0a620=
, first fail: v5.10.191-cip38)

    2023-09-13T16:43:16.813210  / # #
    2023-09-13T16:43:16.916084  export SHELL=3D/bin/sh
    2023-09-13T16:43:16.916924  #
    2023-09-13T16:43:17.018945  / # export SHELL=3D/bin/sh. /lava-105442/en=
vironment
    2023-09-13T16:43:17.019709  =

    2023-09-13T16:43:17.121734  / # . /lava-105442/environment/lava-105442/=
bin/lava-test-runner /lava-105442/1
    2023-09-13T16:43:17.123047  =

    2023-09-13T16:43:17.137393  / # /lava-105442/bin/lava-test-runner /lava=
-105442/1
    2023-09-13T16:43:17.193279  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-13T16:43:17.193792  + cd /lava-105442/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e0dae99d32943a8a0a7d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e0dae99d32943a8a0abb
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T16:18:07.616502  <8>[   19.427141] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 105356_1.5.2.4.1>
    2023-09-13T16:18:07.725478  / # #
    2023-09-13T16:18:07.828556  export SHELL=3D/bin/sh
    2023-09-13T16:18:07.829366  #
    2023-09-13T16:18:07.931306  / # export SHELL=3D/bin/sh. /lava-105356/en=
vironment
    2023-09-13T16:18:07.932083  =

    2023-09-13T16:18:08.034120  / # . /lava-105356/environment/lava-105356/=
bin/lava-test-runner /lava-105356/1
    2023-09-13T16:18:08.035537  =

    2023-09-13T16:18:08.048511  / # /lava-105356/bin/lava-test-runner /lava=
-105356/1
    2023-09-13T16:18:08.227309  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (13 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
juno-uboot                   | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e26a89c5b061508a0aba

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-ub=
oot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-broonie/baseline-juno-ub=
oot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e26a89c5b061508a0af9
        new failure (last pass: v5.10.191-cip38-2-g09e5ecd8645b)

    2023-09-13T16:24:54.156722  / # #
    2023-09-13T16:24:54.259878  export SHELL=3D/bin/sh
    2023-09-13T16:24:54.260730  #
    2023-09-13T16:24:54.362712  / # export SHELL=3D/bin/sh. /lava-105383/en=
vironment
    2023-09-13T16:24:54.363532  =

    2023-09-13T16:24:54.465505  / # . /lava-105383/environment/lava-105383/=
bin/lava-test-runner /lava-105383/1
    2023-09-13T16:24:54.466920  =

    2023-09-13T16:24:54.480951  / # /lava-105383/bin/lava-test-runner /lava=
-105383/1
    2023-09-13T16:24:54.538839  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-13T16:24:54.539350  + cd /lava-105383/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
mt8173-elm-hana              | arm64  | lab-collabora   | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e45a47650613608a0ada

  Results:     28 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e45a47650613608a0afa
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:34:35.747793  + set +x

    2023-09-13T16:34:35.753174  <8>[   15.594922] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517485_1.5.2.3.1>

    2023-09-13T16:34:35.861501  / # #

    2023-09-13T16:34:35.963868  export SHELL=3D/bin/sh

    2023-09-13T16:34:35.964769  #

    2023-09-13T16:34:36.066132  / # export SHELL=3D/bin/sh. /lava-11517485/=
environment

    2023-09-13T16:34:36.066827  =


    2023-09-13T16:34:36.168184  / # . /lava-11517485/environment/lava-11517=
485/bin/lava-test-runner /lava-11517485/1

    2023-09-13T16:34:36.169369  =


    2023-09-13T16:34:36.171757  / # /lava-11517485/bin/lava-test-runner /la=
va-11517485/1
 =

    ... (21 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip         | gcc-10   | shmobi=
le_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e27e7ca8e169968a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a7=
743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6501e27e7ca8e169968a0=
a43
        failing since 0 day (last pass: v5.10.191-cip38-2-g09e5ecd8645b, fi=
rst fail: v5.10.191-cip38-17-g8dad6b499cfe5) =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e4b5ba097e4c168a0ad0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e4b5ba097e4c168a0ad7
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T16:34:42.995118  + set +x
    2023-09-13T16:34:42.998338  <8>[   83.962651] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1008526_1.5.2.4.1>
    2023-09-13T16:34:43.105413  / # #
    2023-09-13T16:34:44.569720  export SHELL=3D/bin/sh
    2023-09-13T16:34:44.590663  #
    2023-09-13T16:34:44.591121  / # export SHELL=3D/bin/sh
    2023-09-13T16:34:46.548706  / # . /lava-1008526/environment
    2023-09-13T16:34:50.150624  /lava-1008526/bin/lava-test-runner /lava-10=
08526/1
    2023-09-13T16:34:50.172061  . /lava-1008526/environment
    2023-09-13T16:34:50.172499  / # /lava-1008526/bin/lava-test-runner /lav=
a-1008526/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e0d922fc43a3898a0a83

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r=
8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-r=
8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e0d922fc43a3898a0a8a
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T16:18:16.881654  / # #
    2023-09-13T16:18:18.344447  export SHELL=3D/bin/sh
    2023-09-13T16:18:18.365025  #
    2023-09-13T16:18:18.365233  / # export SHELL=3D/bin/sh
    2023-09-13T16:18:20.322120  / # . /lava-1008503/environment
    2023-09-13T16:18:23.925763  /lava-1008503/bin/lava-test-runner /lava-10=
08503/1
    2023-09-13T16:18:23.946672  . /lava-1008503/environment
    2023-09-13T16:18:23.946783  / # /lava-1008503/bin/lava-test-runner /lav=
a-1008503/1
    2023-09-13T16:18:24.131796  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-13T16:18:24.132130  + cd /lava-1008503/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e26989c5b061508a0aaf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-cip/baseline-r8a774c0-ek=
874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e26a89c5b061508a0ab6
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T16:24:51.550531  / # #
    2023-09-13T16:24:53.012985  export SHELL=3D/bin/sh
    2023-09-13T16:24:53.033562  #
    2023-09-13T16:24:53.033771  / # export SHELL=3D/bin/sh
    2023-09-13T16:24:54.989678  / # . /lava-1008509/environment
    2023-09-13T16:24:58.588973  /lava-1008509/bin/lava-test-runner /lava-10=
08509/1
    2023-09-13T16:24:58.609763  . /lava-1008509/environment
    2023-09-13T16:24:58.609876  / # /lava-1008509/bin/lava-test-runner /lav=
a-1008509/1
    2023-09-13T16:24:58.688720  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-13T16:24:58.689025  + cd /lava-1008509/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a774c0-ek874               | arm64  | lab-cip         | gcc-10   | defcon=
fig+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e539c73e737cd38a0a44

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e539c73e737cd38a0a4b
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T16:36:50.355670  / # #
    2023-09-13T16:36:51.818766  export SHELL=3D/bin/sh
    2023-09-13T16:36:51.839342  #
    2023-09-13T16:36:51.839549  / # export SHELL=3D/bin/sh
    2023-09-13T16:36:53.795696  / # . /lava-1008525/environment
    2023-09-13T16:36:57.396295  /lava-1008525/bin/lava-test-runner /lava-10=
08525/1
    2023-09-13T16:36:57.417135  . /lava-1008525/environment
    2023-09-13T16:36:57.417245  / # /lava-1008525/bin/lava-test-runner /lav=
a-1008525/1
    2023-09-13T16:36:57.495915  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-13T16:36:57.496131  + cd /lava-1008525/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e36321ad6de7e68a0aa2

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e36321ad6de7e68a0aab
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T16:33:31.510236  / # #

    2023-09-13T16:33:31.612451  export SHELL=3D/bin/sh

    2023-09-13T16:33:31.613134  #

    2023-09-13T16:33:31.714459  / # export SHELL=3D/bin/sh. /lava-11517418/=
environment

    2023-09-13T16:33:31.715125  =


    2023-09-13T16:33:31.816589  / # . /lava-11517418/environment/lava-11517=
418/bin/lava-test-runner /lava-11517418/1

    2023-09-13T16:33:31.817784  =


    2023-09-13T16:33:31.834682  / # /lava-11517418/bin/lava-test-runner /la=
va-11517418/1

    2023-09-13T16:33:31.934367  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T16:33:31.934876  + cd /lava-11517418/1/tests/1_bootrr
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e3b32ecff2d0e08a0a4f

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77=
960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-collabora/baseline-r8a77=
960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e3b32ecff2d0e08a0a58
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T16:34:44.060873  / # #

    2023-09-13T16:34:44.163074  export SHELL=3D/bin/sh

    2023-09-13T16:34:44.163827  #

    2023-09-13T16:34:44.265252  / # export SHELL=3D/bin/sh. /lava-11517441/=
environment

    2023-09-13T16:34:44.265493  =


    2023-09-13T16:34:44.366287  / # . /lava-11517441/environment/lava-11517=
441/bin/lava-test-runner /lava-11517441/1

    2023-09-13T16:34:44.367392  =


    2023-09-13T16:34:44.369096  / # /lava-11517441/bin/lava-test-runner /la=
va-11517441/1

    2023-09-13T16:34:44.433441  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T16:34:44.433942  + cd /lav<8>[   16.422345] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11517441_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
rk3288-veyron-jaq            | arm    | lab-collabora   | gcc-10   | multi_=
v7_defconfig           | 4          =


  Details:     https://kernelci.org/test/plan/id/6501e2b2340b6f5dbe8a0a66

  Results:     63 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-i2c-present: https://kernelci.or=
g/test/case/id/6501e2b2340b6f5dbe8a0a99
        failing since 240 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:30:33.460666  FIRST,<8>[   18.694334] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-cec-present RESULT=3Dfail>

    2023-09-13T16:30:33.462542   INC default to 1.

    2023-09-13T16:30:33.462793  =


    2023-09-13T16:30:33.466103  	-w	Pad to last with leading zeros

    2023-09-13T16:30:33.468594  	-s SEP	String separator

    2023-09-13T16:30:33.472503  /lava-11517463/1/../bin/lava-test-case

    2023-09-13T16:30:33.478523  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-09-13T16:30:33.478781  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/6501e2b2340b6f5dbe8a0a9a
        failing since 240 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:30:33.438285  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   18.675357] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-09-13T16:30:33.440141   multi-call binary.

    2023-09-13T16:30:33.440358  =


    2023-09-13T16:30:33.444963  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-09-13T16:30:33.445016  =


    2023-09-13T16:30:33.449928  Print numbers from FIRST to LAST, in steps =
of INC.
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/6501e2b2340b6f5dbe8a0a9b
        failing since 240 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:30:33.419200  <8>[   18.657436] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dpass>
   =


  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e2b2340b6f5dbe8a0aaf
        failing since 240 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:30:21.357037  <8>[    6.595097] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-09-13T16:30:21.366322  + <8>[    6.607520] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11517463_1.5.2.3.1>

    2023-09-13T16:30:21.367092  set +x

    2023-09-13T16:30:21.473274  =


    2023-09-13T16:30:21.574809  / # #export SHELL=3D/bin/sh

    2023-09-13T16:30:21.575502  =


    2023-09-13T16:30:21.676722  / # export SHELL=3D/bin/sh. /lava-11517463/=
environment

    2023-09-13T16:30:21.676988  =


    2023-09-13T16:30:21.777743  / # . /lava-11517463/environment/lava-11517=
463/bin/lava-test-runner /lava-11517463/1

    2023-09-13T16:30:21.778820  =

 =

    ... (19 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie     | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e1f64d3e175a378a0a42

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-broonie/baseline-sun50i-=
a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e1f64d3e175a378a0a72
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:23:02.261489  + set +x
    2023-09-13T16:23:02.264741  <8>[   17.166949] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 105369_1.5.2.4.1>
    2023-09-13T16:23:02.375511  / # #
    2023-09-13T16:23:02.477813  export SHELL=3D/bin/sh
    2023-09-13T16:23:02.478418  #
    2023-09-13T16:23:02.580731  / # export SHELL=3D/bin/sh. /lava-105369/en=
vironment
    2023-09-13T16:23:02.581326  =

    2023-09-13T16:23:02.683243  / # . /lava-105369/environment/lava-105369/=
bin/lava-test-runner /lava-105369/1
    2023-09-13T16:23:02.684424  =

    2023-09-13T16:23:02.689206  / # /lava-105369/bin/lava-test-runner /lava=
-105369/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab             | compiler | defcon=
fig                    | regressions
-----------------------------+--------+-----------------+----------+-------=
-----------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora   | gcc-10   | defcon=
fig                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e1e732b87be5fb8a0a54

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50=
i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-collabora/baseline-sun50=
i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6501e1e732b87be5fb8a0a5d
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751)

    2023-09-13T16:27:11.907500  / # #

    2023-09-13T16:27:12.009669  export SHELL=3D/bin/sh

    2023-09-13T16:27:12.010376  #

    2023-09-13T16:27:12.111810  / # export SHELL=3D/bin/sh. /lava-11517432/=
environment

    2023-09-13T16:27:12.112517  =


    2023-09-13T16:27:12.213929  / # . /lava-11517432/environment/lava-11517=
432/bin/lava-test-runner /lava-11517432/1

    2023-09-13T16:27:12.215004  =


    2023-09-13T16:27:12.232068  / # /lava-11517432/bin/lava-test-runner /la=
va-11517432/1

    2023-09-13T16:27:12.272279  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-13T16:27:12.290932  + cd /lava-1151743<8>[   18.309489] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11517432_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

