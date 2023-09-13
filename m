Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF6DEE01E0
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 17:10:01 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.2678.1694624995428388743
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 10:09:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ck/pysZA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1c1e780aa95so49565185ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 10:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694624994; x=1695229794; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cND/x7pRFLLXROWJw6lli2hDq8EKE99s5RQlqZqLwIc=;
        b=ck/pysZAUULKw/mud1MBMgBycq/WwLfcr2AkTQrHiTuUbA0FpRykLJ4y+7NdhLIIMr
         V/DQWmoCTy6ANjq0QQ3keFO/lSXPC2JZmosIoPGeBhfTH8snR5c3V2guXm7BdqrMg7pE
         J3PNpLY2ATxXyllahAL7q1rA6/PRHx2qgE/qovV2Q8LSooAJ5fyOtCZZFHYILlWifLNM
         5wvqA3obCVkcGkFVI7ZusX1GU1RND6aIU9avVWCa0NcqxAU3nU6sTDhLriLI7yIq6gil
         fP9Feem98PycZPrnv+e4zpne+Ua4LWufmAKqO1MEVuBBgD0xvbaqkHCRc17OLPtK5BBm
         OguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624994; x=1695229794;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cND/x7pRFLLXROWJw6lli2hDq8EKE99s5RQlqZqLwIc=;
        b=idp3vMh97+pRzVMWm6K1RwVWxQo+XnkK38E+ouO1TJbD8fqBA+BmmnR/JyAX+yzDMb
         uTXHeYmUlK9heiyvH45XfGakVXcQ5YOZb/RqHjI20LLdxCstjCZPedCNcGD80GxTMl6n
         8BcLp1DwkvyArzcisgpvYSERrVgNGO7PbL00RrBkE9NcULjG/3XdyqCfxXeIMg9kEiKS
         dFntnz8HbgSkBPDTT1g359Z7l4+8s6uLQg/WQmAB7m+YTAqtIWiMj7ZuRWkZ0iX5zrg3
         O2+bohnkM7IiI6aZx8lVX4NYnkJfY6hsoN2Fl3HoB3ANd0RBTsL4sGHTvhjqxUMIM+Jm
         9cNA==
X-Gm-Message-State: AOJu0YxNPn5mbPwocFoNR6fn0PPtmOhA2GmOchlDsC/Jfw2cqarF+xe5
	2SaCw0E0sPUoqvkVWKiy7Pk1gW1pPcwfUMDjjAE=
X-Google-Smtp-Source: AGHT+IG6TM9NY6oYyoKnKbzAMXNJwRs/Qvvx9BN8ZFR4IDcYEsVmAZETLYGvjk0uB7GyTCjgFlpj1Q==
X-Received: by 2002:a17:902:ce8a:b0:1c3:f764:8443 with SMTP id f10-20020a170902ce8a00b001c3f7648443mr1162277plg.9.1694624994187;
        Wed, 13 Sep 2023 10:09:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iw7-20020a170903044700b001bdd512df9csm10683267plb.74.2023.09.13.10.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:09:53 -0700 (PDT)
Message-ID: <6501ece1.170a0220.1703b.e6f1@mx.google.com>
Date: Wed, 13 Sep 2023 10:09:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.191-cip38-29-g9e1aa2001db8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 27 runs,
 13 regressions (v5.10.191-cip38-29-g9e1aa2001db8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 17:10:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13113

cip/linux-5.10.y-cip baseline-nfs: 27 runs, 13 regressions (v5.10.191-cip38=
-29-g9e1aa2001db8)

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

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38-29-g9e1aa2001db8/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38-29-g9e1aa2001db8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9e1aa2001db862da32812062860b8756cbc8890a =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e32a79e49354098a0a7d

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501e32b79e49354098a0aad
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:27:46.610828  <8>[   53.649442] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 105399_1.6.2.4.1>
    2023-09-13T16:27:46.730981  / # #
    2023-09-13T16:27:46.834040  export SHELL=3D/bin/sh
    2023-09-13T16:27:46.834924  #
    2023-09-13T16:27:46.936919  / # export SHELL=3D/bin/sh. /lava-105399/en=
vironment
    2023-09-13T16:27:46.937496  =

    2023-09-13T16:27:47.039159  / # . /lava-105399/environment/lava-105399/=
bin/lava-test-runner /lava-105399/1
    2023-09-13T16:27:47.040485  =

    2023-09-13T16:27:47.044848  / # /lava-105399/bin/lava-test-runner /lava=
-105399/1
    2023-09-13T16:27:47.296978  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e33921ad6de7e68a0a42

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501e33921ad6de7e68a0a49
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:27:45.814574  + set +x
    2023-09-13T16:27:45.818810  <8>[   47.755937] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1008513_1.6.2.4.1>
    2023-09-13T16:27:46.014424  #
    2023-09-13T16:27:46.117411  / # #export SHELL=3D/bin/sh
    2023-09-13T16:27:46.118113  =

    2023-09-13T16:27:46.219880  / # export SHELL=3D/bin/sh. /lava-1008513/e=
nvironment
    2023-09-13T16:27:46.220631  =

    2023-09-13T16:27:46.322465  / # . /lava-1008513/environment/lava-100851=
3/bin/lava-test-runner /lava-1008513/1
    2023-09-13T16:27:46.323625  =

    2023-09-13T16:27:46.330555  / # /lava-1008513/bin/lava-test-runner /lav=
a-1008513/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e066c49ff250088a0a6a

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501e066c49ff250088a0aa4
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:16:08.578180  <8>[   46.385148] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 105340_1.6.2.4.1>
    2023-09-13T16:16:08.695848  / # #
    2023-09-13T16:16:08.798744  export SHELL=3D/bin/sh
    2023-09-13T16:16:08.799519  #
    2023-09-13T16:16:08.901789  / # export SHELL=3D/bin/sh. /lava-105340/en=
vironment
    2023-09-13T16:16:08.902464  =

    2023-09-13T16:16:09.004939  / # . /lava-105340/environment/lava-105340/=
bin/lava-test-runner /lava-105340/1
    2023-09-13T16:16:09.006084  =

    2023-09-13T16:16:09.010825  / # /lava-105340/bin/lava-test-runner /lava=
-105340/1
    2023-09-13T16:16:09.260720  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e06901f89e6da38a0a71

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501e06901f89e6da38a0a78
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:16:13.267212  <8>[   44.597741] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1008498_1.6.2.4.1>
    2023-09-13T16:16:13.427943  #
    2023-09-13T16:16:13.530944  / # #export SHELL=3D/bin/sh
    2023-09-13T16:16:13.531652  =

    2023-09-13T16:16:13.633450  / # export SHELL=3D/bin/sh. /lava-1008498/e=
nvironment
    2023-09-13T16:16:13.634149  =

    2023-09-13T16:16:13.735947  / # . /lava-1008498/environment/lava-100849=
8/bin/lava-test-runner /lava-1008498/1
    2023-09-13T16:16:13.737117  =

    2023-09-13T16:16:13.742043  / # /lava-1008498/bin/lava-test-runner /lav=
a-1008498/1
    2023-09-13T16:16:14.099119  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e026220baf7a848a0a45

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501e026220baf7a848a0a4e
        failing since 152 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-09-13T16:15:24.232728  + set +x<8>[   18.461209] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11517372_1.5.2.3.1>

    2023-09-13T16:15:24.232811  =


    2023-09-13T16:15:24.336958  / # #

    2023-09-13T16:15:24.437505  export SHELL=3D/bin/sh

    2023-09-13T16:15:24.437693  #

    2023-09-13T16:15:24.538255  / # export SHELL=3D/bin/sh. /lava-11517372/=
environment

    2023-09-13T16:15:24.538422  =


    2023-09-13T16:15:24.638956  / # . /lava-11517372/environment/lava-11517=
372/bin/lava-test-runner /lava-11517372/1

    2023-09-13T16:15:24.639280  =


    2023-09-13T16:15:24.643434  / # /lava-11517372/bin/lava-test-runner /la=
va-11517372/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e021a983d8a7968a0acf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501e021a983d8a7968a0ad8
        failing since 152 days (last pass: v5.10.176-cip30, first fail: v5.=
10.177-cip31)

    2023-09-13T16:15:19.816250  + set +x

    2023-09-13T16:15:19.822446  <8>[   19.885540] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517412_1.5.2.3.1>

    2023-09-13T16:15:19.927114  / # #

    2023-09-13T16:15:20.027704  export SHELL=3D/bin/sh

    2023-09-13T16:15:20.027896  #

    2023-09-13T16:15:20.128386  / # export SHELL=3D/bin/sh. /lava-11517412/=
environment

    2023-09-13T16:15:20.128579  =


    2023-09-13T16:15:20.229063  / # . /lava-11517412/environment/lava-11517=
412/bin/lava-test-runner /lava-11517412/1

    2023-09-13T16:15:20.229347  =


    2023-09-13T16:15:20.234300  / # /lava-11517412/bin/lava-test-runner /la=
va-11517412/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e2fdd3d04b91428a0b07

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501e2fdd3d04b91428a0b10
        failing since 242 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-09-13T16:29:25.328003  / # #

    2023-09-13T16:29:25.429989  export SHELL=3D/bin/sh

    2023-09-13T16:29:25.430626  #

    2023-09-13T16:29:25.531825  / # export SHELL=3D/bin/sh. /lava-11517453/=
environment

    2023-09-13T16:29:25.532483  =


    2023-09-13T16:29:25.634072  / # . /lava-11517453/environment/lava-11517=
453/bin/lava-test-runner /lava-11517453/1

    2023-09-13T16:29:25.635150  =


    2023-09-13T16:29:25.636854  / # /lava-11517453/bin/lava-test-runner /la=
va-11517453/1

    2023-09-13T16:29:25.776765  + export TESTRUN_ID=3D1_bootrr

    2023-09-13T16:29:25.777206  + cd /lava-11517453/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e1375ece95417c8a0a5a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6501e1375ece95417=
c8a0a5b
        new failure (last pass: v5.10.191-cip38-17-g8dad6b499cfe5) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e0e15037b3f6188a0a76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6501e0e15037b3f61=
88a0a77
        failing since 28 days (last pass: v5.10.186-cip37-13-g260094841fe1a=
, first fail: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e2718ee810d5b08a0a70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6501e2718ee810d5b=
08a0a71
        failing since 49 days (last pass: v5.10.184-cip36-13-g8fae18103387,=
 first fail: v5.10.186-cip37-12-g2710acbceb751) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6501e561c73e737cd38a0a6a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6501e561c73e737cd=
38a0a6b
        failing since 22 days (last pass: v5.10.186-cip37-14-gc9b5a049d8ea,=
 first fail: v5.10.186-cip37-27-gd6d928db0a620) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6501e484ba097e4c168a0a4a

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-29-g9e1aa2001db8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6501e484ba097e4c168a0a54
        failing since 175 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-09-13T16:33:57.893016  /lava-11517473/1/../bin/lava-test-case

    2023-09-13T16:33:57.932948  <8>[   38.962765] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6501e484ba097e4c168a0a55
        failing since 175 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2023-09-13T16:33:55.721902  <8>[   36.749290] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-09-13T16:33:56.796397  /lava-11517473/1/../bin/lava-test-case

    2023-09-13T16:33:56.838716  <8>[   37.868632] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

