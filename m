Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745FEC001DC
	for <webhook@archiver.kernel.org>; Mon, 17 Jul 2023 14:33:47 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.9795.1689604426766615862
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 17 Jul 2023 07:33:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=uJSWql4A;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6682909acadso2954978b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 17 Jul 2023 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689604425; x=1692196425;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JZgXS2Ar3z0/IwJqqphmgxqEkjhKd1nEQd78SInxiqw=;
        b=uJSWql4AH6yIbPpuhorzq1pDBYRAC3fnHdz1332l3cx+QkqT2ztcCvcwAieJqw0/0x
         8OEoJqNDNweNxffrYGqse/GM1v+GOPl1GbbzAjbgfAE7yJDsBTfk5HvOgvjnEp0iIIWA
         6exx8iMEyZT2lFrD8uV2nupvqQQzfErtkrv5h4UPxaDh2yusYpYwFbQxKkzGbk8gg4w5
         a9XJnJoHFASDIQAlDEiQmOJq+d3EE22dVqljal7kSHyl8yvKH90Spu8/bqBVGVW6nvT4
         5O21CdV1+AwZf8YI9XKCd26Xzeq4cZTx/coWDY60k4lCrWGJPoerWkaTrwBYUuOlRPR4
         fJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689604425; x=1692196425;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZgXS2Ar3z0/IwJqqphmgxqEkjhKd1nEQd78SInxiqw=;
        b=BQ+kpFCV4ZmFLkaQDTbsp7nQIY8GydU/Tg1rUOv5f4jj0NDXFz2wGzyQKlgc6g/0hB
         mvlMYDKn+b7izmEbnSDyVmfy7L90LGZIpkKWG2s39Kubpamr6ewABPnfsmug7n+zNgO3
         YRgm1bJHPw25qbMEX2ZbqeVa1ubCebZ3EtCJVdnTNudGEv3+eOBfsEUsaXxJJL/UNJjQ
         C/HX7cT/eZH2YoHekuEDEn8w+ZeJ4hq/SShzG1x4EIvkyDm6xw43kg3CKgzfRkQsWEYQ
         3r3GQgC3Dl5SjWT/tjlxvN4s24YDRza8MqQISh6w+uQDr/WjqlT6Daco/AevUTbB/YOK
         u//Q==
X-Gm-Message-State: ABy/qLYh6bf6nlKtQ/tQzH4ahdXvjKBAD49hd6A2UzvMHtKak0e7anUN
	m7ydFYl5g4ciRqQDyqZWxo/BrBXNMpWj9iy2l3BZyA==
X-Google-Smtp-Source: APBJJlGIcllQrDLf9g5tgl8tAKWdZGRvKL0jfBiJcB4DlLbGSjWd92gG1sJQPLDSauDIByl+iYpgmg==
X-Received: by 2002:a05:6a00:240d:b0:67f:2ba2:f741 with SMTP id z13-20020a056a00240d00b0067f2ba2f741mr13525931pfh.24.1689604425213;
        Mon, 17 Jul 2023 07:33:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fe21-20020a056a002f1500b0064d681c753csm12095200pfb.40.2023.07.17.07.33.44
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:33:44 -0700 (PDT)
Message-ID: <64b55148.050a0220.2c108.8004@mx.google.com>
Date: Mon, 17 Jul 2023 07:33:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.38-cip1-78-gb24e2a62dde0
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline: 25 runs,
 5 regressions (v6.1.38-cip1-78-gb24e2a62dde0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jul 2023 14:33:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12373

cip-gitlab/ci/pavel/linux-test baseline: 25 runs, 5 regressions (v6.1.38-ci=
p1-78-gb24e2a62dde0)

Regressions Summary
-------------------

platform          | arch | lab             | compiler | defconfig          =
| regressions
------------------+------+-----------------+----------+--------------------=
+------------
bcm2836-rpi-2-b   | arm  | lab-collabora   | gcc-10   | multi_v7_defconfig =
| 1          =

imx53-qsrb        | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig =
| 1          =

imx7ulp-evk       | arm  | lab-nxp         | gcc-10   | multi_v7_defconfig =
| 1          =

rk3288-veyron-jaq | arm  | lab-collabora   | gcc-10   | multi_v7_defconfig =
| 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.38-cip1-78-gb24e2a62dde0/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.38-cip1-78-gb24e2a62dde0
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b24e2a62dde025ade5db3ed51d07425f14a67e49 =



Test Regressions
---------------- =



platform          | arch | lab             | compiler | defconfig          =
| regressions
------------------+------+-----------------+----------+--------------------=
+------------
bcm2836-rpi-2-b   | arm  | lab-collabora   | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/64b1bb2485f3a2e8ca8ace6b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-78-gb24e2a62dde0/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-78-gb24e2a62dde0/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64b1bb2485f3a2e8ca8ac=
e6c
        failing since 30 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70) =

 =



platform          | arch | lab             | compiler | defconfig          =
| regressions
------------------+------+-----------------+----------+--------------------=
+------------
imx53-qsrb        | arm  | lab-pengutronix | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/64b1baca74fc5f27528ace36

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-78-gb24e2a62dde0/arm/multi_v7_defconfig/gcc-10/lab-pengutroni=
x/baseline-imx53-qsrb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-78-gb24e2a62dde0/arm/multi_v7_defconfig/gcc-10/lab-pengutroni=
x/baseline-imx53-qsrb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1baca74fc5f27528ace3b
        failing since 22 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-14T21:14:28.165992  + set +x
    2023-07-14T21:14:28.272817  / # #
    2023-07-14T21:14:28.374613  export SHELL=3D/bin/sh
    2023-07-14T21:14:28.375139  [   12.758786] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-07-14T21:14:28.375293  [   12.760795] <LAVA_SIGNAL_ENDRUN 0_dmesg =
995301_1.5.2.3.1>
    2023-07-14T21:14:28.375410  #
    2023-07-14T21:14:28.476587  / # export SHELL=3D/bin/sh. /lava-995301/en=
vironment
    2023-07-14T21:14:28.477142  =

    2023-07-14T21:14:28.578614  / # . /lava-995301/environment/lava-995301/=
bin/lava-test-runner /lava-995301/1
    2023-07-14T21:14:28.579327   =

    ... (13 line(s) more)  =

 =



platform          | arch | lab             | compiler | defconfig          =
| regressions
------------------+------+-----------------+----------+--------------------=
+------------
imx7ulp-evk       | arm  | lab-nxp         | gcc-10   | multi_v7_defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/64b1bb2a309e129e108ace30

  Results:     4 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-78-gb24e2a62dde0/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseli=
ne-imx7ulp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-78-gb24e2a62dde0/arm/multi_v7_defconfig/gcc-10/lab-nxp/baseli=
ne-imx7ulp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/64b1bb2a309e129e108ace35
        failing since 114 days (last pass: v5.10.145-rt74-1329-ga59fc50f38f=
6, first fail: v5.10.175-cip29-rt12)

    2023-07-14T21:16:03.220828  + set +x
    2023-07-14T21:16:03.327354  / # #
    2023-07-14T21:16:04.482828  export SHELL=3D/bin/sh
    2023-07-14T21:16:04.488497  <8>[   33.132442] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Demerg RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>
    2023-07-14T21:16:04.488788  <8>[   33.134892] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1236693_1.5.2.4.1>
    2023-07-14T21:16:04.489030  #
    2023-07-14T21:16:04.489256  / # export SHELL=3D/bin/sh
    2023-07-14T21:16:06.031358  / # . /lava-1236693/environment
    2023-07-14T21:16:08.848771  /lava-1236693/bin/lava-test-runner /lava-12=
36693/1
    2023-07-14T21:16:08.854790  . /lava-1236693/environment =

    ... (13 line(s) more)  =

 =



platform          | arch | lab             | compiler | defconfig          =
| regressions
------------------+------+-----------------+----------+--------------------=
+------------
rk3288-veyron-jaq | arm  | lab-collabora   | gcc-10   | multi_v7_defconfig =
| 2          =


  Details:     https://kernelci.org/test/plan/id/64b1bae8993757bb538ace1d

  Results:     64 PASS, 4 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-78-gb24e2a62dde0/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.38-cip1-78-gb24e2a62dde0/arm/multi_v7_defconfig/gcc-10/lab-collabora/=
baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64b1bae8993757bb538ace4c
        failing since 175 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-14T21:16:39.610552  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA<8=
>[   26.914587] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-07-14T21:16:39.610778  ST

    2023-07-14T21:16:39.611007  =


    2023-07-14T21:16:39.616024  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-07-14T21:16:39.618477  FIRST, INC default to 1.

    2023-07-14T21:16:39.618710  =


    2023-07-14T21:16:39.622169  	-w	Pad to last with leading zeros
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64b1bae8993757bb538ace4d
        failing since 175 days (last pass: v5.10.158-cip22-435-g2c52868ae1c=
bc, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-07-14T21:16:39.594312  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC)<8=
>[   26.903452] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed=
 RESULT=3Dpass>

    2023-07-14T21:16:39.595969   multi-call binary.

    2023-07-14T21:16:39.596203  =

   =

 =20

