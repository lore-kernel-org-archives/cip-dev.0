Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E56C4828D
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 21:50:43 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.8422.1706824235877769373
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 13:50:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ZKL89TEq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6de287449f1so1006034b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 13:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706824235; x=1707429035; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MXYSKvuZUWm5De+Xsr87fCrxBORcZyL05Zv6KSYPu3Y=;
        b=ZKL89TEqA65zG2Z7srNLAkUi3YBIAHTGJpXOPMkH43xk/HW/kEpTf8DTJNCVZsTLCS
         BiH0qiW4Qety123/3w60w83ssRmLfYM4pidSZ4uHVPxLZ4QakztslPPdZ6X8LpezYGNp
         FLysWUF8RkxOKp+3Y00ptc1SPE4QvEqaDLlcjpiCa4/dCT1R7yQoYt6mJzXbxt+Cao+/
         MRbxrW/UrnyyhnaQ9Ehen0ARYNuYTWUYezfSU5I6QIqj50fQDkEj93u7DDiRqdH3RfNB
         mJQjyFK5KrwekiDTZG/h+X8ImKCDJFav9tYaBJouUa9rHMf/SEEzVOoD9yTbv5Wb3Zmh
         3Z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706824235; x=1707429035;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXYSKvuZUWm5De+Xsr87fCrxBORcZyL05Zv6KSYPu3Y=;
        b=ONMTCrD84ZId7NefDxCdm5TCV3OZkEgTIqJENzw+1dBh8s6EePPCbDx0QCbiwrdTR/
         9dbWYq4nagoZEaU6IGxLnfRDf4SZVqmx0wZSKU2TfEgVr4DB/xW9JRFYGe9DYzM4U2YR
         ydLPLee+lbcdiiWsXqXBdDehnLPwn7lWplGFyeIzTCSu+j7uCVx31397CmZtEXbLZm0b
         Ra399bN89lEGtQ10WhQFjQ/ZdYXcv1+7KIVWDxYOeKKpOZ22f0gpZB0wjrnXCicHommv
         ZZLx0f2W++duGqkBXxkWheFrHG0WbkJlqTcFDxNaPQNptNJaGHaVHwS8u0L/AkWtLHIj
         HEfw==
X-Gm-Message-State: AOJu0YxKCAN/XILV6SOPOja7zUbv/ZDcCgORgrW2mRawtMGEr9xxw5el
	nU28FEHcLK5GDoXSTlHVqt3DwsQCNrN/tzaTYyXJYWbxQSr+ra92XaSIm1X8ZD+ZUUWiizRShda
	W
X-Google-Smtp-Source: AGHT+IGqFLLHMu0TXO05+l6r+q7p31ff5nmCM9ehQhNafjYIMSYZouDckJkk1aDzU2GJBge2SiZxVg==
X-Received: by 2002:a05:6a00:b84:b0:6d9:999b:3785 with SMTP id g4-20020a056a000b8400b006d9999b3785mr7010226pfj.30.1706824234204;
        Thu, 01 Feb 2024 13:50:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUlqyWuDV/sAuwLsF3FXLdSvMxoT2O4OFOPRfgsiqsDhNVQLVpZagwQ2BPrYGQn9rnZBGHJvKrRVXdy9LD8kgQLOBt4Zqst4Di6ZjgOehHqW5MYpyxLRsq8Gmo99jcrFZT1khDvt13eHEFrWC8jIYP2mw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o12-20020a62cd0c000000b006dde04c10dasm224414pfg.217.2024.02.01.13.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 13:50:33 -0800 (PST)
Message-ID: <65bc1229.620a0220.d1bab.1cdc@mx.google.com>
Date: Thu, 01 Feb 2024 13:50:33 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.208-cip43-4-g1c63c70fb18b8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 62 runs,
 18 regressions (v5.10.208-cip43-4-g1c63c70fb18b8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 21:50:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14589

cip/linux-5.10.y-cip baseline-nfs: 62 runs, 18 regressions (v5.10.208-cip43=
-4-g1c63c70fb18b8)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig           | 1          =

beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig          | 1          =

beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig          | 1          =

imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig           | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | cip://5.1=
0.y-...64_defconfig | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                    | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook   | 2          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                    | 1          =

sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.208-cip43-4-g1c63c70fb18b8/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.208-cip43-4-g1c63c70fb18b8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1c63c70fb18b87b5bcfe5d7ddf0096c92a1557ed =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0bbab04c54d3c100a04b

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bc0bbab04c54d3c100a07c
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:22:19.618040  <8>[   49.313591] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 533010_1.6.2.4.1>
    2024-02-01T21:22:19.738806  / # #
    2024-02-01T21:22:19.841904  export SHELL=3D/bin/sh
    2024-02-01T21:22:19.842774  #
    2024-02-01T21:22:19.944942  / # export SHELL=3D/bin/sh. /lava-533010/en=
vironment
    2024-02-01T21:22:19.945801  =

    2024-02-01T21:22:20.047827  / # . /lava-533010/environment/lava-533010/=
bin/lava-test-runner /lava-533010/1
    2024-02-01T21:22:20.049104  =

    2024-02-01T21:22:20.052443  / # /lava-533010/bin/lava-test-runner /lava=
-533010/1
    2024-02-01T21:22:20.307988  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0bab94f6204b0000a06f

  Results:     31 PASS, 15 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bc0bab94f6204b0000a09f
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:22:06.699510  <8>[   45.854435] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1086338_1.6.2.4.1>
    2024-02-01T21:22:06.806072  / # #
    2024-02-01T21:22:06.909332  export SHELL=3D/bin/sh
    2024-02-01T21:22:06.910257  #
    2024-02-01T21:22:07.012293  / # export SHELL=3D/bin/sh. /lava-1086338/e=
nvironment
    2024-02-01T21:22:07.013322  =

    2024-02-01T21:22:07.114983  / # . /lava-1086338/environment/lava-108633=
8/bin/lava-test-runner /lava-1086338/1
    2024-02-01T21:22:07.116476  =

    2024-02-01T21:22:07.130890  / # /lava-1086338/bin/lava-test-runner /lav=
a-1086338/1
    2024-02-01T21:22:07.424153  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-broonie   | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc087c03938ac89300a03c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bc087c03938ac89300a076
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:09:01.408847  <8>[   47.116923] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 532967_1.6.2.4.1>
    2024-02-01T21:09:01.531786  #
    2024-02-01T21:09:01.634324  / # #export SHELL=3D/bin/sh
    2024-02-01T21:09:01.634825  =

    2024-02-01T21:09:01.736701  / # export SHELL=3D/bin/sh. /lava-532967/en=
vironment
    2024-02-01T21:09:01.737191  =

    2024-02-01T21:09:01.839012  / # . /lava-532967/environment/lava-532967/=
bin/lava-test-runner /lava-532967/1
    2024-02-01T21:09:01.839876  =

    2024-02-01T21:09:01.843802  / # /lava-532967/bin/lava-test-runner /lava=
-532967/1
    2024-02-01T21:09:02.135752  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
beaglebone-black             | arm   | lab-cip       | gcc-10   | omap2plus=
_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc086303f4eb0e6700a0ef

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bc086303f4eb0e6700a11e
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:08:21.220195  <8>[   38.887688] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1086319_1.6.2.4.1>
    2024-02-01T21:08:21.341415  / # #
    2024-02-01T21:08:21.444431  export SHELL=3D/bin/sh
    2024-02-01T21:08:21.445433  #
    2024-02-01T21:08:21.547274  / # export SHELL=3D/bin/sh. /lava-1086319/e=
nvironment
    2024-02-01T21:08:21.548372  =

    2024-02-01T21:08:21.650203  / # . /lava-1086319/environment/lava-108631=
9/bin/lava-test-runner /lava-1086319/1
    2024-02-01T21:08:21.651679  =

    2024-02-01T21:08:21.667951  / # /lava-1086319/bin/lava-test-runner /lav=
a-1086319/1
    2024-02-01T21:08:21.992043  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
imx6q-sabrelite              | arm   | lab-collabora | gcc-10   | multi_v7_=
defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0b89991ce2436100a0b4

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm/multi_v7_defconfig/gcc-10/lab-collabora/baselin=
e-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bc0b89991ce2436100a0bd
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:27:38.753475  / # #

    2024-02-01T21:27:38.855589  export SHELL=3D/bin/sh

    2024-02-01T21:27:38.856278  #

    2024-02-01T21:27:38.957639  / # export SHELL=3D/bin/sh. /lava-12684731/=
environment

    2024-02-01T21:27:38.958335  =


    2024-02-01T21:27:39.059853  / # . /lava-12684731/environment/lava-12684=
731/bin/lava-test-runner /lava-12684731/1

    2024-02-01T21:27:39.060919  =


    2024-02-01T21:27:39.062050  / # /lava-12684731/bin/lava-test-runner /la=
va-12684731/1

    2024-02-01T21:27:39.189948  + export TESTRUN_ID=3D1_bootrr

    2024-02-01T21:27:39.205755  + cd /lava-12684731/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | cip://5.1=
0.y-...64_defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0f8f4086a0fc1400a044

  Results:     47 PASS, 13 FAIL, 1 SKIP
  Full config: cip://5.10.y-cip/arm64/qemu_arm64_defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/cip---5.10.y-cip-arm64-qemu_arm64_defconfig/g=
cc-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bc0f8f4086a0fc1400a081
        failing since 120 days (last pass: v5.10.184-cip36-8-gb192df20e8c9,=
 first fail: v5.10.194-cip39-1-g53e59f50ca3ff)

    2024-02-01T21:39:03.831265  <8>[   42.258961] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 533030_1.6.2.4.1>
    2024-02-01T21:39:03.950133  / # #
    2024-02-01T21:39:04.053158  export SHELL=3D/bin/sh
    2024-02-01T21:39:04.053927  #
    2024-02-01T21:39:04.155932  / # export SHELL=3D/bin/sh. /lava-533030/en=
vironment
    2024-02-01T21:39:04.156765  =

    2024-02-01T21:39:04.258941  / # . /lava-533030/environment/lava-533030/=
bin/lava-test-runner /lava-533030/1
    2024-02-01T21:39:04.260200  =

    2024-02-01T21:39:04.278914  / # /lava-533030/bin/lava-test-runner /lava=
-533030/1
    2024-02-01T21:39:04.425810  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0e7656f2bea23500a047

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bc0e7656f2bea23500a086
        new failure (last pass: v5.10.201-cip41-69-g8f7b450fc28ed)

    2024-02-01T21:34:09.539952  <8>[   52.609204] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 532982_1.6.2.4.1>
    2024-02-01T21:34:09.658943  / # #
    2024-02-01T21:34:09.761382  export SHELL=3D/bin/sh
    2024-02-01T21:34:09.762168  #
    2024-02-01T21:34:09.864107  / # export SHELL=3D/bin/sh. /lava-532982/en=
vironment
    2024-02-01T21:34:09.864844  =

    2024-02-01T21:34:09.966956  / # . /lava-532982/environment/lava-532982/=
bin/lava-test-runner /lava-532982/1
    2024-02-01T21:34:09.968269  =

    2024-02-01T21:34:09.987631  / # /lava-532982/bin/lava-test-runner /lava=
-532982/1
    2024-02-01T21:34:10.373180  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc10bbf8e7b008e500a046

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-jun=
o-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-jun=
o-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bc10bbf8e7b008e500a084
        failing since 120 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff)

    2024-02-01T21:43:53.007545  <8>[   42.605577] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 533044_1.6.2.4.1>
    2024-02-01T21:43:53.112086  / # #
    2024-02-01T21:43:53.214848  export SHELL=3D/bin/sh
    2024-02-01T21:43:53.215600  #
    2024-02-01T21:43:53.317463  / # export SHELL=3D/bin/sh. /lava-533044/en=
vironment
    2024-02-01T21:43:53.318216  =

    2024-02-01T21:43:53.420107  / # . /lava-533044/environment/lava-533044/=
bin/lava-test-runner /lava-533044/1
    2024-02-01T21:43:53.420789  =

    2024-02-01T21:43:53.424893  / # /lava-533044/bin/lava-test-runner /lava=
-533044/1
    2024-02-01T21:43:53.590713  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0ba51706ae884c00a055

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-broonie/baseli=
ne-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65bc0ba51706ae884=
c00a056
        new failure (last pass: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0d3a0b92a7dfdf00a03b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65bc0d3a0b92a7dfd=
f00a03c
        failing since 49 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc07b39588786a8400a085

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/bas=
eline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65bc07b49588786a8=
400a086
        failing since 163 days (last pass: v5.10.186-cip37-14-gc9b5a049d8ea=
, first fail: v5.10.186-cip37-27-gd6d928db0a620) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0b5fc7976558ea00a0b7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-n=
fs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65bc0b60c7976558e=
a00a0b8
        new failure (last pass: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0db8a6fbe4040e00a052

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65bc0db8a6fbe4040=
e00a053
        failing since 120 days (last pass: v5.10.194-cip39, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65bc070187d39e919a00a0c0

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabo=
ra/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65bc070187d39e919a00a0ca
        failing since 316 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2024-02-01T21:05:23.339692  <8>[   38.365513] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2024-02-01T21:05:24.402895  /lava-12684602/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65bc070187d39e919a00a0cb
        failing since 316 days (last pass: v5.10.173-cip28, first fail: v5.=
10.175-cip29)

    2024-02-01T21:05:23.299035  /lava-12684602/1/../bin/lava-test-case
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0affc71e25877600a039

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+kselftest/gcc-10/lab-collabora/base=
line-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bc0affc71e25877600a042
        failing since 120 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff)

    2024-02-01T21:19:41.384597  <8>[   51.610138] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12684721_1.6.2.4.1>

    2024-02-01T21:19:41.490214  #

    2024-02-01T21:19:42.751623  / # #export SHELL=3D/bin/sh

    2024-02-01T21:19:42.762615  =


    2024-02-01T21:19:42.763081  / # export SHELL=3D/bin/sh

    2024-02-01T21:19:44.506192  . /lava-12684721/environment

    2024-02-01T21:19:44.517108  / # . /lava-12684721/environment

    2024-02-01T21:19:47.710225  /lava-12684721/bin/lava-test-runner /lava-1=
2684721/1

    2024-02-01T21:19:47.726256  / # /lava-12684721/bin/lava-test-runner /la=
va-12684721/1

    2024-02-01T21:19:48.120595  + export TESTRUN_ID=3D1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0bad94f6204b0000a0a6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-r=
k3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-r=
k3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bc0bad94f6204b0000a0af
        failing since 120 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff)

    2024-02-01T21:23:34.651529  / # #

    2024-02-01T21:23:35.912114  export SHELL=3D/bin/sh

    2024-02-01T21:23:35.923087  #

    2024-02-01T21:23:35.923556  / # export SHELL=3D/bin/sh

    2024-02-01T21:23:37.666792  / # . /lava-12684747/environment

    2024-02-01T21:23:40.870790  /lava-12684747/bin/lava-test-runner /lava-1=
2684747/1

    2024-02-01T21:23:40.882141  . /lava-12684747/environment

    2024-02-01T21:23:40.885997  / # /lava-12684747/bin/lava-test-runner /la=
va-12684747/1

    2024-02-01T21:23:41.058769  + export TESTRUN_ID=3D1_bootrr

    2024-02-01T21:23:41.059176  + cd /lava-12684747/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                    | regressions
-----------------------------+-------+---------------+----------+----------=
--------------------+------------
sun50i-a64-pine64-plus       | arm64 | lab-broonie   | gcc-10   | defconfig=
                    | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0c9861a5115d0500a039

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun=
50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun=
50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65bc0c9861a5115d0500a069
        failing since 383 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2024-02-01T21:26:24.987190  <8>[   35.755040] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 533047_1.6.2.4.1>
    2024-02-01T21:26:25.111308  #
    2024-02-01T21:26:25.213448  / # #export SHELL=3D/bin/sh
    2024-02-01T21:26:25.213967  =

    2024-02-01T21:26:25.315289  / # export SHELL=3D/bin/sh. /lava-533047/en=
vironment
    2024-02-01T21:26:25.315789  =

    2024-02-01T21:26:25.417042  / # . /lava-533047/environment/lava-533047/=
bin/lava-test-runner /lava-533047/1
    2024-02-01T21:26:25.417818  =

    2024-02-01T21:26:25.421544  / # /lava-533047/bin/lava-test-runner /lava=
-533047/1
    2024-02-01T21:26:25.563123  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

