Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6F6E70718
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 10:58:54 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.13563.1695293926983694628
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Sep 2023 03:58:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=VRxsIijq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so6425265ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Sep 2023 03:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695293926; x=1695898726; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EhnogUSdx7f/j/rz4Mfj+CuWc8Xk7dCh26OtSkZqRv4=;
        b=VRxsIijq/q0QHX8efYzxFst30aS+8fnZrOtdaZsE80qcnRr85Bg2R8ndIJHpN6MQzh
         w1cU3xXF+IS6+HptZxbNvPT0UMMNuyxrTh4jPCgf6KHrf+NXtdrFxRyC086iKzcKxGVo
         EJKNmmToSzqx/HfpPUxDdGoj4Kz8cmFOriV5mCaEFuqW4pxYeCdg9HWyjIIk7PViJ1Fr
         thqvUfSPShq3jJ2oYWrLrDsomQaCDKGGRvsda3h4L71XHNADKFetT/3+aGMWO8FtvDVR
         TPGvhh7zYdTbxMc6o+KLbxJbivr6GC8K/UV7h0C3aGchP+4dY8kF1S7lA6Fq5nXsKVwV
         GMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695293926; x=1695898726;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhnogUSdx7f/j/rz4Mfj+CuWc8Xk7dCh26OtSkZqRv4=;
        b=SI2hS2xq7Vr5YenPpEA5RKDyuDnP6kRrKmN6vV3VOC2ct8DnCuFTMb1QPeH8cV/IUK
         sPtUmMyCIZfQKRJOYsw089DLoyKOhbLvML/iUz1td/CcwrlfVh7a94y7s1/OfBmmbsiQ
         9dhFiqQeKfcJ9lEVqwiQH9YAndZB67BAYt03/YabVaWcEzG4aZSfKD4NeTcU7LnWSDVo
         6CEO40OoM3lz9Ox/jYtm8D6cl0JwH7MaWrnAXeJDL2NeIZzhBmgH8pIbEBTZ1H2sghqo
         ft5t4ZE0hfJr2IxUUfv5lSdU0s0sD5j1Eey6zj8V3VUYlIl7w3rU6IJZNZ+JlRoERBV0
         eoKA==
X-Gm-Message-State: AOJu0YxDQ5Uk6wHl2J+shv6NL0jUIxDTJARZz7ZheL3G+HrWDrCLxBW7
	//scf78hooaxkMsLmHmD4hH86eTbdXokuu053d97qw==
X-Google-Smtp-Source: AGHT+IGWuH+D/8p1ihK76w4Xd1BjtwQLhq3TdIPF2zsowUqDIXd7LA7qpBTOPloLfmRsGen4l07YGQ==
X-Received: by 2002:a17:902:dac2:b0:1c3:d9ed:a410 with SMTP id q2-20020a170902dac200b001c3d9eda410mr5748369plx.59.1695293925139;
        Thu, 21 Sep 2023 03:58:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jh13-20020a170903328d00b001bc2831e1a8sm1155246plb.80.2023.09.21.03.58.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 03:58:44 -0700 (PDT)
Message-ID: <650c21e4.170a0220.5a53b.2ba9@mx.google.com>
Date: Thu, 21 Sep 2023 03:58:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.194-cip39-407-g664623343843d
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 169 runs,
 29 regressions (v5.10.194-cip39-407-g664623343843d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 10:58:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13199

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 169 runs, 29 regressio=
ns (v5.10.194-cip39-407-g664623343843d)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.194-cip39-407-g664623343843d/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.194-cip39-407-g664623343843d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      664623343843d7956ac33fe2f98d9903fdd5ebec =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/650c13fe4d2ecc40098a0a6f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c13fe4d2ecc40098a0a78
        failing since 55 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-21T10:03:23.468965  / # #

    2023-09-21T10:03:23.571085  export SHELL=3D/bin/sh

    2023-09-21T10:03:23.571828  #

    2023-09-21T10:03:23.673248  / # export SHELL=3D/bin/sh. /lava-11587191/=
environment

    2023-09-21T10:03:23.673956  =


    2023-09-21T10:03:23.775401  / # . /lava-11587191/environment/lava-11587=
191/bin/lava-test-runner /lava-11587191/1

    2023-09-21T10:03:23.776539  =


    2023-09-21T10:03:23.820334  / # /lava-11587191/bin/lava-test-runner /la=
va-11587191/1

    2023-09-21T10:03:23.901587  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-21T10:03:23.902099  + cd /lava-11587191/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c19504099ea8f658a0a48

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c19504099ea8f658a0a7f
        failing since 259 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-09-21T10:21:50.222334  <8>[   16.659605] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 122373_1.5.2.4.1>
    2023-09-21T10:21:50.334182  / # #
    2023-09-21T10:21:50.437509  export SHELL=3D/bin/sh
    2023-09-21T10:21:50.438451  #
    2023-09-21T10:21:50.540557  / # export SHELL=3D/bin/sh. /lava-122373/en=
vironment
    2023-09-21T10:21:50.541544  =

    2023-09-21T10:21:50.643694  / # . /lava-122373/environment/lava-122373/=
bin/lava-test-runner /lava-122373/1
    2023-09-21T10:21:50.645230  =

    2023-09-21T10:21:50.649609  / # /lava-122373/bin/lava-test-runner /lava=
-122373/1
    2023-09-21T10:21:50.751865  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c19554099ea8f658a0a87

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c19554099ea8f658a0a8e
        failing since 259 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-09-21T10:21:49.317060  <8>[   12.990483] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1011343_1.5.2.4.1>
    2023-09-21T10:21:49.425956  / # #
    2023-09-21T10:21:49.528378  export SHELL=3D/bin/sh
    2023-09-21T10:21:49.529111  #
    2023-09-21T10:21:49.630960  / # export SHELL=3D/bin/sh. /lava-1011343/e=
nvironment
    2023-09-21T10:21:49.631665  =

    2023-09-21T10:21:49.733499  / # . /lava-1011343/environment/lava-101134=
3/bin/lava-test-runner /lava-1011343/1
    2023-09-21T10:21:49.734652  =

    2023-09-21T10:21:49.740816  / # /lava-1011343/bin/lava-test-runner /lav=
a-1011343/1
    2023-09-21T10:21:49.837180  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1ce9737318a8148a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c1ce9737318a8148a0=
a43
        failing since 1 day (last pass: v5.10.186-cip37-982-g80a0585c0aa62,=
 first fail: v5.10.191-cip38-661-g112a3073ff26) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1685d5be8d54c68a0a4d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopu=
s.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c1685d5be8d54c68a0a56
        failing since 153 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-21T10:10:14.715416  + <8>[   12.256655] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11587294_1.4.2.3.1>

    2023-09-21T10:10:14.715900  set +x

    2023-09-21T10:10:14.820990  #

    2023-09-21T10:10:14.923277  / # #export SHELL=3D/bin/sh

    2023-09-21T10:10:14.923535  =


    2023-09-21T10:10:15.024200  / # export SHELL=3D/bin/sh. /lava-11587294/=
environment

    2023-09-21T10:10:15.024819  =


    2023-09-21T10:10:15.125960  / # . /lava-11587294/environment/lava-11587=
294/bin/lava-test-runner /lava-11587294/1

    2023-09-21T10:10:15.126427  =


    2023-09-21T10:10:15.131128  / # /lava-11587294/bin/lava-test-runner /la=
va-11587294/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650c17d819877a41c58a0a73

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4=
020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c17d819877a41c58a0a7c
        failing since 153 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-21T10:15:44.367624  + set +x<8>[   15.842448] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11587344_1.4.2.3.1>

    2023-09-21T10:15:44.368131  =


    2023-09-21T10:15:44.476218  / # #

    2023-09-21T10:15:44.578693  export SHELL=3D/bin/sh

    2023-09-21T10:15:44.579485  #

    2023-09-21T10:15:44.681012  / # export SHELL=3D/bin/sh. /lava-11587344/=
environment

    2023-09-21T10:15:44.681774  =


    2023-09-21T10:15:44.783578  / # . /lava-11587344/environment/lava-11587=
344/bin/lava-test-runner /lava-11587344/1

    2023-09-21T10:15:44.785120  =


    2023-09-21T10:15:44.790319  / # /lava-11587344/bin/lava-test-runner /la=
va-11587344/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/650c167fc46ca0925b8a0acb

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c167fc46ca0925b8a0ad4
        failing since 153 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-21T10:11:13.194916  <8>[   12.185627] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11587301_1.4.2.3.1>

    2023-09-21T10:11:13.197935  + set +x

    2023-09-21T10:11:13.303170  / # #

    2023-09-21T10:11:13.403962  export SHELL=3D/bin/sh

    2023-09-21T10:11:13.404193  #

    2023-09-21T10:11:13.504760  / # export SHELL=3D/bin/sh. /lava-11587301/=
environment

    2023-09-21T10:11:13.504976  =


    2023-09-21T10:11:13.605632  / # . /lava-11587301/environment/lava-11587=
301/bin/lava-test-runner /lava-11587301/1

    2023-09-21T10:11:13.605913  =


    2023-09-21T10:11:13.611103  / # /lava-11587301/bin/lava-test-runner /la=
va-11587301/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650c179c89da1631a98a0a5c

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c179c89da1631a98a0a65
        failing since 153 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-21T10:14:46.657283  <8>[   13.217451] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11587368_1.4.2.3.1>

    2023-09-21T10:14:46.660976  + set +x

    2023-09-21T10:14:46.767251  =


    2023-09-21T10:14:46.869151  / # #export SHELL=3D/bin/sh

    2023-09-21T10:14:46.869953  =


    2023-09-21T10:14:46.971826  / # export SHELL=3D/bin/sh. /lava-11587368/=
environment

    2023-09-21T10:14:46.972579  =


    2023-09-21T10:14:47.074228  / # . /lava-11587368/environment/lava-11587=
368/bin/lava-test-runner /lava-11587368/1

    2023-09-21T10:14:47.075557  =


    2023-09-21T10:14:47.081015  / # /lava-11587368/bin/lava-test-runner /la=
va-11587368/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c14812261c2ae1d8a0ad1

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig/gcc-10/lab-=
broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c14812261c2ae1d8a0b0f
        failing since 55 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-21T10:01:18.367357  <8>[   14.538119] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 122297_1.5.2.4.1>
    2023-09-21T10:01:18.475904  / # #
    2023-09-21T10:01:18.578711  export SHELL=3D/bin/sh
    2023-09-21T10:01:18.579507  #
    2023-09-21T10:01:18.681450  / # export SHELL=3D/bin/sh. /lava-122297/en=
vironment
    2023-09-21T10:01:18.682284  =

    2023-09-21T10:01:18.784289  / # . /lava-122297/environment/lava-122297/=
bin/lava-test-runner /lava-122297/1
    2023-09-21T10:01:18.785626  =

    2023-09-21T10:01:18.799477  / # /lava-122297/bin/lava-test-runner /lava=
-122297/1
    2023-09-21T10:01:18.859372  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1beeff59014caf8a0a42

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c1beeff59014caf8a0a80
        new failure (last pass: v5.10.191-cip38-661-g112a3073ff26)

    2023-09-21T10:32:39.901566  <8>[   32.255239] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 122387_1.5.2.4.1>
    2023-09-21T10:32:40.010487  / # #
    2023-09-21T10:32:40.113365  export SHELL=3D/bin/sh
    2023-09-21T10:32:40.114161  #
    2023-09-21T10:32:40.216064  / # export SHELL=3D/bin/sh. /lava-122387/en=
vironment
    2023-09-21T10:32:40.216822  =

    2023-09-21T10:32:40.318734  / # . /lava-122387/environment/lava-122387/=
bin/lava-test-runner /lava-122387/1
    2023-09-21T10:32:40.319988  =

    2023-09-21T10:32:40.333098  / # /lava-122387/bin/lava-test-runner /lava=
-122387/1
    2023-09-21T10:32:40.512732  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1c5b3b6eed77128a0a43

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-kontron/baseline-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c1c5b3b6eed77128a0=
a44
        failing since 1 day (last pass: v5.10.186-cip37-982-g80a0585c0aa62,=
 first fail: v5.10.191-cip38-661-g112a3073ff26) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1c5989b3d2bf578a0a59

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-kontron/baseline-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c1c5989b3d2bf578a0=
a5a
        failing since 1 day (last pass: v5.10.186-cip37-982-g80a0585c0aa62,=
 first fail: v5.10.191-cip38-661-g112a3073ff26) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7            | arm    | lab-cip       | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1653c46ca0925b8a0a44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm/shmobile_defconfig/gcc-=
10/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c1653c46ca0925b8a0=
a45
        failing since 25 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1ad6e1938afccc8a0a48

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c1ad6e1938afccc8a0a4f
        failing since 55 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-21T10:27:59.957008  + set +x
    2023-09-21T10:27:59.957129  <8>[   83.907197] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1011354_1.5.2.4.1>
    2023-09-21T10:28:00.062957  / # #
    2023-09-21T10:28:01.524220  export SHELL=3D/bin/sh
    2023-09-21T10:28:01.544783  #
    2023-09-21T10:28:01.544984  / # export SHELL=3D/bin/sh
    2023-09-21T10:28:03.499623  / # . /lava-1011354/environment
    2023-09-21T10:28:07.095076  /lava-1011354/bin/lava-test-runner /lava-10=
11354/1
    2023-09-21T10:28:07.115627  . /lava-1011354/environment
    2023-09-21T10:28:07.115724  / # /lava-1011354/bin/lava-test-runner /lav=
a-1011354/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1c25ff59014caf8a0a92

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c1c25ff59014caf8a0=
a93
        failing since 1 day (last pass: v5.10.186-cip37-566-g36076316ef049,=
 first fail: v5.10.191-cip38-661-g112a3073ff26) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774b1-hihope-rzg2n-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1b93a7a61ff23f8a0a7a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c1b93a7a61ff23f8a0a81
        failing since 55 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-21T10:30:46.746952  + set +x
    2023-09-21T10:30:46.747074  <8>[   84.194867] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1011348_1.5.2.4.1>
    2023-09-21T10:30:46.853019  / # #
    2023-09-21T10:30:48.314069  export SHELL=3D/bin/sh
    2023-09-21T10:30:48.334635  #
    2023-09-21T10:30:48.334857  / # export SHELL=3D/bin/sh
    2023-09-21T10:30:50.288294  / # . /lava-1011348/environment
    2023-09-21T10:30:53.885138  /lava-1011348/bin/lava-test-runner /lava-10=
11348/1
    2023-09-21T10:30:53.905879  . /lava-1011348/environment
    2023-09-21T10:30:53.905990  / # /lava-1011348/bin/lava-test-runner /lav=
a-1011348/1 =

    ... (15 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c14732261c2ae1d8a0ab2

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig/gcc-10/lab-=
cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c14732261c2ae1d8a0ab9
        failing since 55 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-21T10:01:10.360307  / # #
    2023-09-21T10:01:11.819210  export SHELL=3D/bin/sh
    2023-09-21T10:01:11.839666  #
    2023-09-21T10:01:11.839832  / # export SHELL=3D/bin/sh
    2023-09-21T10:01:13.791794  / # . /lava-1011323/environment
    2023-09-21T10:01:17.383269  /lava-1011323/bin/lava-test-runner /lava-10=
11323/1
    2023-09-21T10:01:17.403901  . /lava-1011323/environment
    2023-09-21T10:01:17.404054  / # /lava-1011323/bin/lava-test-runner /lav=
a-1011323/1
    2023-09-21T10:01:17.480618  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-21T10:01:17.480749  + cd /lava-1011323/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1a69449de8348e8a0a48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c1a69449de8348e8a0=
a49
        failing since 1 day (last pass: v5.10.186-cip37-982-g80a0585c0aa62,=
 first fail: v5.10.191-cip38-661-g112a3073ff26) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1b954dba0aaa648a0a42

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c1b954dba0aaa648a0a49
        failing since 55 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-21T10:31:17.569253  / # #
    2023-09-21T10:31:19.030178  export SHELL=3D/bin/sh
    2023-09-21T10:31:19.050726  #
    2023-09-21T10:31:19.050940  / # export SHELL=3D/bin/sh
    2023-09-21T10:31:21.004576  / # . /lava-1011350/environment
    2023-09-21T10:31:24.598230  /lava-1011350/bin/lava-test-runner /lava-10=
11350/1
    2023-09-21T10:31:24.618928  . /lava-1011350/environment
    2023-09-21T10:31:24.619061  / # /lava-1011350/bin/lava-test-runner /lav=
a-1011350/1
    2023-09-21T10:31:24.698123  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-21T10:31:24.698322  + cd /lava-1011350/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c13d5c7eb1e7ee08a0ac1

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig/gcc-10/lab-=
collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c13d5c7eb1e7ee08a0aca
        failing since 55 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-21T10:02:59.098002  / # #

    2023-09-21T10:02:59.200315  export SHELL=3D/bin/sh

    2023-09-21T10:02:59.201086  #

    2023-09-21T10:02:59.302543  / # export SHELL=3D/bin/sh. /lava-11587199/=
environment

    2023-09-21T10:02:59.303327  =


    2023-09-21T10:02:59.404825  / # . /lava-11587199/environment/lava-11587=
199/bin/lava-test-runner /lava-11587199/1

    2023-09-21T10:02:59.405984  =


    2023-09-21T10:02:59.421181  / # /lava-11587199/bin/lava-test-runner /la=
va-11587199/1

    2023-09-21T10:02:59.472002  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-21T10:02:59.472517  + cd /lav<8>[   16.428971] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11587199_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/650c1922d4198de4f18a0a5f

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/650c1922d4198de4f18a0a69
        failing since 153 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-21T10:22:46.255485  <8>[   41.945987] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-09-21T10:22:47.296055  /lava-11587397/1/../bin/lava-test-case

    2023-09-21T10:22:47.311331  <8>[   43.002323] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/650c1922d4198de4f18a0a6a
        failing since 153 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-21T10:22:46.237248  /lava-11587397/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/650c1a71a6fe13263f8a0a5e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/650c1a71a6fe13263f8a0a68
        failing since 153 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-21T10:26:33.581711  <8>[   32.425796] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-09-21T10:26:34.606375  /lava-11587421/1/../bin/lava-test-case

    2023-09-21T10:26:34.617608  <8>[   33.462991] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/650c1a71a6fe13263f8a0a69
        failing since 153 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-21T10:26:33.569238  /lava-11587421/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c14152e88003f5f8a0a9c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig/gcc-10/lab-=
collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig/gcc-10/lab-=
collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c14152e88003f5f8a0aa5
        failing since 25 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-09-21T09:59:31.416584  / # #

    2023-09-21T09:59:32.677506  export SHELL=3D/bin/sh

    2023-09-21T09:59:32.688445  #

    2023-09-21T09:59:32.688944  / # export SHELL=3D/bin/sh

    2023-09-21T09:59:34.430536  / # . /lava-11587193/environment

    2023-09-21T09:59:37.624866  /lava-11587193/bin/lava-test-runner /lava-1=
1587193/1

    2023-09-21T09:59:37.636324  . /lava-11587193/environment

    2023-09-21T09:59:37.637667  / # /lava-11587193/bin/lava-test-runner /la=
va-11587193/1

    2023-09-21T09:59:37.692710  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-21T09:59:37.693253  + cd /lava-11587193/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1b59a7a61ff23f8a0a69

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c1b59a7a61ff23f8a0a72
        failing since 25 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-09-21T10:32:39.643572  / # #

    2023-09-21T10:32:40.905022  export SHELL=3D/bin/sh

    2023-09-21T10:32:40.916036  #

    2023-09-21T10:32:40.916521  / # export SHELL=3D/bin/sh

    2023-09-21T10:32:42.660464  / # . /lava-11587426/environment

    2023-09-21T10:32:45.866135  /lava-11587426/bin/lava-test-runner /lava-1=
1587426/1

    2023-09-21T10:32:45.877668  . /lava-11587426/environment

    2023-09-21T10:32:45.879343  / # /lava-11587426/bin/lava-test-runner /la=
va-11587426/1

    2023-09-21T10:32:45.964269  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-21T10:32:45.964763  + cd /lava-11587426/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1c2989b3d2bf578a0a44

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c1c2989b3d2bf578a0=
a45
        failing since 1 day (last pass: v5.10.186-cip37-982-g80a0585c0aa62,=
 first fail: v5.10.191-cip38-661-g112a3073ff26) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/650c1c2aff59014caf8a0a98

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/650c1c2aff59014caf8a0=
a99
        failing since 1 day (last pass: v5.10.186-cip37-982-g80a0585c0aa62,=
 first fail: v5.10.191-cip38-661-g112a3073ff26) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/650c13ea5d3043562e8a0b28

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.194-cip39-407-g664623343843d/arm64/defconfig/gcc-10/lab-=
collabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/650c13ea5d3043562e8a0b31
        failing since 55 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-21T10:03:12.840125  / # #

    2023-09-21T10:03:12.942478  export SHELL=3D/bin/sh

    2023-09-21T10:03:12.943172  #

    2023-09-21T10:03:13.044621  / # export SHELL=3D/bin/sh. /lava-11587196/=
environment

    2023-09-21T10:03:13.045435  =


    2023-09-21T10:03:13.146933  / # . /lava-11587196/environment/lava-11587=
196/bin/lava-test-runner /lava-11587196/1

    2023-09-21T10:03:13.148053  =


    2023-09-21T10:03:13.164129  / # /lava-11587196/bin/lava-test-runner /la=
va-11587196/1

    2023-09-21T10:03:13.222260  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-21T10:03:13.222757  + cd /lava-1158719<8>[   18.216230] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11587196_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

