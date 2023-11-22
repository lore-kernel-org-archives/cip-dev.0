Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA56C61D97
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 20:04:52 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.34264.1700683485195391192
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Nov 2023 12:04:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=20AqwXE2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso189079b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Nov 2023 12:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700683484; x=1701288284; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qkokthdp8WwN4ivo8W9aO1NI/XXEMh1lFknssrLhicY=;
        b=20AqwXE20Mp8Wo3I0wiOQIHPfmxDS+KyNFkcZIRafp0dC0SjRTDKE00UOy5bwqNznZ
         cO4hXTMBCvEGw2SnOCNUXrwdD89brExdYXcChETb7aANsVSAXZbpEc/VIUXdV4y+ePXt
         bV1EppAlssDBAoW0JselYOCmzhBS+R8x0sBDQSgJMK3LWjomoN6y4Y5cryd/5vKElRnl
         BOYQSgfnR9L2YvfMa/EZe8S5SN/F6yo0GlGzHK2xSq2nYEu07S3erf6VCvVHklhgV/9M
         +0adxzO8c8G+0PtHFP3GI5T7jmSDFqE2RdbmqCGxPh5Z01qmzqIGWWAkPfKuWar5JFdP
         uGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683484; x=1701288284;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qkokthdp8WwN4ivo8W9aO1NI/XXEMh1lFknssrLhicY=;
        b=BEzOLiPd05Dmzyk7r/TFSDUeRjvluRXn/Y8Qnixd8YLK/8G3K1M/zpsrk/smkyTSTl
         bHSJwRV4KMijnmZkdQ/mF1SlUKJq7EPwq6YHEZaA7m7Mkn9sRyLuqpzZVzNwODITznTJ
         FwjT93gwz2WOxpYIniyKBUHkeARnIUxCmfHMsM+8PoVlix9iIA1WwCcPVmMQ7nx4Vexe
         x3iA6ud0NADti47u9UZ0azmJVN6hOiK25KUuboEH26cGyQlyFvS3VwudcN+1jns/pDzB
         tF9Uc0jFypLr45I6WpODAbaPeurfEMWlYe95YK7+UnyiaKq0s5umgmmERlxkVlUg2yQL
         Qi/w==
X-Gm-Message-State: AOJu0YzJcNmVgHxQRJLneszde9o6sSkWfPcGT7+EVFdczXoCoO61Qi9h
	7cc2vv6HWl3pYry2ORjJlx8HqrSXNtggDrIrgyk=
X-Google-Smtp-Source: AGHT+IFSRkkK9hIrHckApxUWx4WxNfzHFy1gbCk8W+wxSLI3iw0N54XMXNIXfy9WEXwu7Jb23rXSLw==
X-Received: by 2002:a05:6a00:8d97:b0:68f:bb02:fdf with SMTP id im23-20020a056a008d9700b0068fbb020fdfmr3897540pfb.27.1700683484040;
        Wed, 22 Nov 2023 12:04:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g8-20020a056a00078800b006cb94e20014sm121048pfu.41.2023.11.22.12.04.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:04:43 -0800 (PST)
Message-ID: <655e5edb.050a0220.8327f.0d67@mx.google.com>
Date: Wed, 22 Nov 2023 12:04:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-188-g33d0b44cd71d
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 82 runs,
 6 regressions (v5.10.200-cip40-188-g33d0b44cd71d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 20:04:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13642

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 82 runs, 6 regress=
ions (v5.10.200-cip40-188-g33d0b44cd71d)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
           | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
           | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.200-cip40-188-g33d0b44cd71d/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.200-cip40-188-g33d0b44cd71d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33d0b44cd71d9f81944784e605bc1def7fa0b71e =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/655e54a4d352c1d0c17e4a6d

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/655e54a4d352c1d0c17e4aad
        failing since 20 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2023-11-22T19:20:34.115418  <8>[   52.855958] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 262734_1.6.2.4.1>
    2023-11-22T19:20:34.221218  #
    2023-11-22T19:20:34.324590  / # #export SHELL=3D/bin/sh
    2023-11-22T19:20:34.325390  =

    2023-11-22T19:20:34.427329  / # export SHELL=3D/bin/sh. /lava-262734/en=
vironment
    2023-11-22T19:20:34.428130  =

    2023-11-22T19:20:34.530125  / # . /lava-262734/environment/lava-262734/=
bin/lava-test-runner /lava-262734/1
    2023-11-22T19:20:34.531506  =

    2023-11-22T19:20:34.545326  / # /lava-262734/bin/lava-test-runner /lava=
-262734/1
    2023-11-22T19:20:34.912735  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/655e55d00bd6044d857e4ab4

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/655e55d00bd6044d857e4af4
        failing since 20 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2023-11-22T19:25:48.458763  <8>[   39.892292] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 262774_1.6.2.4.1>
    2023-11-22T19:25:48.562659  / # #
    2023-11-22T19:25:48.665497  export SHELL=3D/bin/sh
    2023-11-22T19:25:48.666311  #
    2023-11-22T19:25:48.768199  / # export SHELL=3D/bin/sh. /lava-262774/en=
vironment
    2023-11-22T19:25:48.768985  =

    2023-11-22T19:25:48.871156  / # . /lava-262774/environment/lava-262774/=
bin/lava-test-runner /lava-262774/1
    2023-11-22T19:25:48.872517  =

    2023-11-22T19:25:48.891226  / # /lava-262774/bin/lava-test-runner /lava=
-262774/1
    2023-11-22T19:25:49.057033  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/655e51b0faa56abc117e4ae1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655e51b0faa56abc1=
17e4ae2
        failing since 64 days (last pass: v5.10.186-cip37-982-g80a0585c0aa6=
2, first fail: v5.10.191-cip38-661-g112a3073ff26) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/655e51be41d1e1815c7e4a83

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/655e51be41d1e1815=
c7e4a84
        failing since 118 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/655e507d2c907540727e4ad8

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/655e507d2c907540727e4ae1
        failing since 20 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2023-11-22T19:03:00.942562  / # #

    2023-11-22T19:03:02.198154  export SHELL=3D/bin/sh

    2023-11-22T19:03:02.208437  #

    2023-11-22T19:03:03.949508  / # export SHELL=3D/bin/sh. /lava-12061802/=
environment

    2023-11-22T19:03:03.960469  =


    2023-11-22T19:03:03.960960  / # . /lava-12061802/environment

    2023-11-22T19:03:07.155550  /lava-12061802/bin/lava-test-runner /lava-1=
2061802/1

    2023-11-22T19:03:07.166977  / # /lava-12061802/bin/lava-test-runner /la=
va-12061802/1

    2023-11-22T19:03:07.590546  + export TESTRUN_ID=3D1_bootrr

    2023-11-22T19:03:07.591065  + cd /lava-12061802/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
           | regressions
-----------------------------+-------+---------------+----------+----------=
-----------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
           | 1          =


  Details:     https://kernelci.org/test/plan/id/655e512f77ea7876ae7e4ac1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/655e512f77ea7876ae7e4aca
        failing since 20 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2023-11-22T19:05:54.993873  / # #

    2023-11-22T19:05:56.252746  export SHELL=3D/bin/sh

    2023-11-22T19:05:56.263709  #

    2023-11-22T19:05:58.005065  / # export SHELL=3D/bin/sh. /lava-12061822/=
environment

    2023-11-22T19:05:58.015882  =


    2023-11-22T19:05:58.016321  / # . /lava-12061822/environment

    2023-11-22T19:06:01.200534  /lava-12061822/bin/lava-test-runner /lava-1=
2061822/1

    2023-11-22T19:06:01.210928  / # /lava-12061822/bin/lava-test-runner /la=
va-12061822/1

    2023-11-22T19:06:01.376291  + export TESTRUN_ID=3D1_bootrr

    2023-11-22T19:06:01.376373  + cd /lava-12061822/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

