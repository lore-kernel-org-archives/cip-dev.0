Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17162C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 13:20:48 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
 by mx.groups.io with SMTP id smtpd.web10.21765.1702560039278951213
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 05:20:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=gYK9welt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.51, mailfrom: bot@kernelci.org)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7b771176f80so153392639f.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 05:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702560038; x=1703164838; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ddHJ0anM0zgQ6iVz0kWxwvztvWqM7ApE7T0ZQAgfTuQ=;
        b=gYK9weltkcaFeAt9mOiJncH88eX0gxZdr0wwKijgKsjNAGbc7YS3G8PYD5SdPH+kdW
         ihScyBK8Lae7I1vqi1AcJhX+w/FnYYE9Fu6iOT/5ZuP3YSSFAv29hgkLTMpY/iweMf+T
         1IhjWpGpAtJk1O8GqId8BPBf4kPVagJ2+tWU0bEp3VlFf5VCgK6n+ZD5KrP5JtraChEd
         jIZXPh1JHfQnbpFCQQclYBJ/MiDOQmMaJPMgqAZguiZy8bvN/nt1bB658oHB+nmR9C1W
         iVCmRCN/vuwhgTvyC2R8uBiz37JFE+tKP7WCF1V6J0zR8VB7YPGFNgsKYSIAUYryTxj6
         7P1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702560038; x=1703164838;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddHJ0anM0zgQ6iVz0kWxwvztvWqM7ApE7T0ZQAgfTuQ=;
        b=TbBNbZMX79Y3Vg3WvXgTRDwVqRAgxcvp6izfTL0LNVEXv2jFlj90ENYRirasSTEq/d
         wwwBTcZtJAp8YJZxmIdXDdQOY6VDSripyqPpj5iRbjThAa2f4D/HCAxUjEQWEztjjLT+
         tDJ8Rgr6uuf/U+D4gP986LCRYWoSaKiRRs6IfzWjumDpo8s8mTVW5Z7z28bSgx+m0pQH
         rjVad+cGaBlomD0PO5I8kKmErqosjuoDgLeOhurP3PLy33F0yvscceezjUo9M3DbC/7c
         CvEx/Tvhbo6s1N9M4BaQkxPJcbIE3CB2asCvNYXlq/93rWL8WIa5BWbWf/rx1wCuyjn4
         j2Uw==
X-Gm-Message-State: AOJu0YyK4zW2C5kGZmFpeLgI3B05YY3GlGRuLBHmbVdP3zO/568RCvpc
	RscZE10EcGJDBeAAye9r6yy35U+h24ZwpGtN3EQjag==
X-Google-Smtp-Source: AGHT+IEhIP+qunegx9YZYi/xNHfPi/3nSrdWcToguAtYCkjp1HUO8NWEDhuDDyIf4zBWomTPNiGkhA==
X-Received: by 2002:a05:6e02:152c:b0:35f:77c5:5e6e with SMTP id i12-20020a056e02152c00b0035f77c55e6emr2361699ilu.29.1702560037639;
        Thu, 14 Dec 2023 05:20:37 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 3-20020a630c43000000b005bdbe9a597fsm11438621pgm.57.2023.12.14.05.20.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 05:20:36 -0800 (PST)
Message-ID: <657b0124.630a0220.ed389.2162@mx.google.com>
Date: Thu, 14 Dec 2023 05:20:36 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 141 runs,
 12 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 13:20:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14100

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 141 runs, 12 regressio=
ns (v5.10.201-cip41-69-g8f7b450fc28ed)

Regressions Summary
-------------------

platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
bcm2836-rpi-2-b    | arm   | lab-collabora | gcc-10   | bcm2835_defconfig  =
 | 1          =

beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
 | 1          =

beaglebone-black   | arm   | lab-cip       | gcc-10   | omap2plus_defconfig=
 | 1          =

juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig+kselftest=
 | 1          =

juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig          =
 | 1          =

r8a7743-iwg20d-q7  | arm   | lab-cip       | gcc-10   | shmobile_defconfig =
 | 1          =

r8a774c0-ek874     | arm64 | lab-cip       | gcc-10   | defconfig+kselftest=
 | 1          =

r8a774c0-ek874     | arm64 | lab-cip       | gcc-10   | defconfig          =
 | 1          =

r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

rk3399-rock-pi-4b  | arm64 | lab-collabora | gcc-10   | defconfig+kselftest=
 | 1          =

rk3399-rock-pi-4b  | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =

sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-69-g8f7b450fc28ed/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160 =



Test Regressions
---------------- =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
bcm2836-rpi-2-b    | arm   | lab-collabora | gcc-10   | bcm2835_defconfig  =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657aee941bc97d6e83e1347a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm/bcm2835_defconfig/gcc-10=
/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm/bcm2835_defconfig/gcc-10=
/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657aee941bc97d6e83e13483
        failing since 140 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-14T12:08:41.673602  / # #

    2023-12-14T12:08:41.775660  export SHELL=3D/bin/sh

    2023-12-14T12:08:41.776399  #

    2023-12-14T12:08:41.877809  / # export SHELL=3D/bin/sh. /lava-12269224/=
environment

    2023-12-14T12:08:41.878519  =


    2023-12-14T12:08:41.979958  / # . /lava-12269224/environment/lava-12269=
224/bin/lava-test-runner /lava-12269224/1

    2023-12-14T12:08:41.981086  =


    2023-12-14T12:08:41.997865  / # /lava-12269224/bin/lava-test-runner /la=
va-12269224/1

    2023-12-14T12:08:42.061783  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T12:08:42.105836  + cd /lava-12269224/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beaglebone-black   | arm   | lab-broonie   | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657af51f59f13270a6e1347b

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657af51f59f13270a6e134b3
        failing since 344 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-12-14T12:28:59.731314  <8>[   20.155265] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 353487_1.5.2.4.1>
    2023-12-14T12:28:59.839435  / # #
    2023-12-14T12:28:59.941315  export SHELL=3D/bin/sh
    2023-12-14T12:28:59.941924  #
    2023-12-14T12:29:00.043221  / # export SHELL=3D/bin/sh. /lava-353487/en=
vironment
    2023-12-14T12:29:00.043639  =

    2023-12-14T12:29:00.144874  / # . /lava-353487/environment/lava-353487/=
bin/lava-test-runner /lava-353487/1
    2023-12-14T12:29:00.145528  =

    2023-12-14T12:29:00.149738  / # /lava-353487/bin/lava-test-runner /lava=
-353487/1
    2023-12-14T12:29:00.257075  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
beaglebone-black   | arm   | lab-cip       | gcc-10   | omap2plus_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657afabaefbe6c5acfe1353d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657afabaefbe6c5acfe13575
        failing since 344 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-12-14T12:53:01.315289  / # #
    2023-12-14T12:53:01.416389  export SHELL=3D/bin/sh
    2023-12-14T12:53:01.416766  #
    2023-12-14T12:53:01.517435  / # export SHELL=3D/bin/sh. /lava-1059097/e=
nvironment
    2023-12-14T12:53:01.517778  =

    2023-12-14T12:53:01.618587  / # . /lava-1059097/environment/lava-105909=
7/bin/lava-test-runner /lava-1059097/1
    2023-12-14T12:53:01.619317  =

    2023-12-14T12:53:01.660886  / # /lava-1059097/bin/lava-test-runner /lav=
a-1059097/1
    2023-12-14T12:53:01.772352  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-14T12:53:01.772660  + cd /lava-1059097/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657af30f6fc735312ae1348c

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657af3106fc735312ae134cc
        failing since 84 days (last pass: v5.10.191-cip38-661-g112a3073ff26=
, first fail: v5.10.194-cip39-407-g664623343843d)

    2023-12-14T12:19:51.801061  <8>[   26.509397] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 353418_1.5.2.4.1>
    2023-12-14T12:19:51.907726  / # #
    2023-12-14T12:19:52.010100  export SHELL=3D/bin/sh
    2023-12-14T12:19:52.010766  #
    2023-12-14T12:19:52.112410  / # export SHELL=3D/bin/sh. /lava-353418/en=
vironment
    2023-12-14T12:19:52.113071  =

    2023-12-14T12:19:52.214724  / # . /lava-353418/environment/lava-353418/=
bin/lava-test-runner /lava-353418/1
    2023-12-14T12:19:52.215781  =

    2023-12-14T12:19:52.232531  / # /lava-353418/bin/lava-test-runner /lava=
-353418/1
    2023-12-14T12:19:52.359573  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
juno-uboot         | arm64 | lab-broonie   | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657afa18c711682261e13580

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657afa19c711682261e135bf
        failing since 15 days (last pass: v5.10.200-cip40-188-g33d0b44cd71d=
, first fail: v5.10.201-cip41-197-g2d08925b44e52)

    2023-12-14T12:50:07.807859  / # #
    2023-12-14T12:50:07.910805  export SHELL=3D/bin/sh
    2023-12-14T12:50:07.911584  #
    2023-12-14T12:50:08.013507  / # export SHELL=3D/bin/sh. /lava-353532/en=
vironment
    2023-12-14T12:50:08.014305  =

    2023-12-14T12:50:08.116280  / # . /lava-353532/environment/lava-353532/=
bin/lava-test-runner /lava-353532/1
    2023-12-14T12:50:08.117586  =

    2023-12-14T12:50:08.130627  / # /lava-353532/bin/lava-test-runner /lava=
-353532/1
    2023-12-14T12:50:08.191495  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-14T12:50:08.192005  + cd /lava-353532/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a7743-iwg20d-q7  | arm   | lab-cip       | gcc-10   | shmobile_defconfig =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657aef5cf988581c43e13490

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/657aef5cf988581c43e13=
491
        new failure (last pass: v5.10.201-cip41-473-gc43d7b7bbe83a) =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a774c0-ek874     | arm64 | lab-cip       | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657af31ba200a27c0ce13484

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657af31ba200a27c0ce1348b
        failing since 140 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-14T12:20:27.285231  / # #
    2023-12-14T12:20:28.739373  export SHELL=3D/bin/sh
    2023-12-14T12:20:28.759722  #
    2023-12-14T12:20:28.759880  / # export SHELL=3D/bin/sh
    2023-12-14T12:20:30.706316  / # . /lava-1059063/environment
    2023-12-14T12:20:34.290422  /lava-1059063/bin/lava-test-runner /lava-10=
59063/1
    2023-12-14T12:20:34.311976  . /lava-1059063/environment
    2023-12-14T12:20:34.312353  / # /lava-1059063/bin/lava-test-runner /lav=
a-1059063/1
    2023-12-14T12:20:34.492109  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-14T12:20:34.492440  + cd /lava-1059063/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a774c0-ek874     | arm64 | lab-cip       | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657afa25926a83136de1347f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657afa25926a83136de13488
        failing since 140 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-14T12:50:24.713554  / # #
    2023-12-14T12:50:26.172686  export SHELL=3D/bin/sh
    2023-12-14T12:50:26.193618  #
    2023-12-14T12:50:26.194106  / # export SHELL=3D/bin/sh
    2023-12-14T12:50:28.142693  / # . /lava-1059106/environment
    2023-12-14T12:50:31.737465  /lava-1059106/bin/lava-test-runner /lava-10=
59106/1
    2023-12-14T12:50:31.757951  . /lava-1059106/environment
    2023-12-14T12:50:31.758034  / # /lava-1059106/bin/lava-test-runner /lav=
a-1059106/1
    2023-12-14T12:50:31.836652  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-14T12:50:31.837260  + cd /lava-1059106/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
r8a77960-ulcb      | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657af98608a037fa9de13478

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657af98608a037fa9de13481
        failing since 140 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-14T12:55:34.121854  / # #

    2023-12-14T12:55:34.223980  export SHELL=3D/bin/sh

    2023-12-14T12:55:34.224727  #

    2023-12-14T12:55:34.326053  / # export SHELL=3D/bin/sh. /lava-12269980/=
environment

    2023-12-14T12:55:34.326740  =


    2023-12-14T12:55:34.428031  / # . /lava-12269980/environment/lava-12269=
980/bin/lava-test-runner /lava-12269980/1

    2023-12-14T12:55:34.429108  =


    2023-12-14T12:55:34.446373  / # /lava-12269980/bin/lava-test-runner /la=
va-12269980/1

    2023-12-14T12:55:34.495060  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T12:55:34.495572  + cd /lav<8>[   16.469476] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12269980_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
rk3399-rock-pi-4b  | arm64 | lab-collabora | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657af2979ffc671bd6e134fa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657af2979ffc671bd6e13503
        failing since 109 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-12-14T12:18:08.780749  / # #

    2023-12-14T12:18:10.039857  export SHELL=3D/bin/sh

    2023-12-14T12:18:10.050095  #

    2023-12-14T12:18:10.050177  / # export SHELL=3D/bin/sh

    2023-12-14T12:18:11.791799  / # . /lava-12269383/environment

    2023-12-14T12:18:14.995471  /lava-12269383/bin/lava-test-runner /lava-1=
2269383/1

    2023-12-14T12:18:15.006953  . /lava-12269383/environment

    2023-12-14T12:18:15.007277  / # /lava-12269383/bin/lava-test-runner /la=
va-12269383/1

    2023-12-14T12:18:15.145243  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T12:18:15.145766  + cd /lava-12269383/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
rk3399-rock-pi-4b  | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657af9c76763c62586e1353e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657af9c76763c62586e13547
        failing since 109 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-12-14T12:48:48.705566  / # #

    2023-12-14T12:48:49.966089  export SHELL=3D/bin/sh

    2023-12-14T12:48:49.977000  #

    2023-12-14T12:48:49.977494  / # export SHELL=3D/bin/sh

    2023-12-14T12:48:51.720186  / # . /lava-12269976/environment

    2023-12-14T12:48:54.920939  /lava-12269976/bin/lava-test-runner /lava-1=
2269976/1

    2023-12-14T12:48:54.932053  . /lava-12269976/environment

    2023-12-14T12:48:54.932339  / # /lava-12269976/bin/lava-test-runner /la=
va-12269976/1

    2023-12-14T12:48:54.987840  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T12:48:54.987932  + cd /lava-12269976/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab           | compiler | defconfig          =
 | regressions
-------------------+-------+---------------+----------+--------------------=
-+------------
sun50i-h6-pine-h64 | arm64 | lab-collabora | gcc-10   | defconfig          =
 | 1          =


  Details:     https://kernelci.org/test/plan/id/657af99a08a037fa9de1348a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657af99a08a037fa9de13493
        failing since 140 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-14T12:55:48.529628  / # #

    2023-12-14T12:55:48.631745  export SHELL=3D/bin/sh

    2023-12-14T12:55:48.632486  #

    2023-12-14T12:55:48.733876  / # export SHELL=3D/bin/sh. /lava-12269975/=
environment

    2023-12-14T12:55:48.734597  =


    2023-12-14T12:55:48.835953  / # . /lava-12269975/environment/lava-12269=
975/bin/lava-test-runner /lava-12269975/1

    2023-12-14T12:55:48.837088  =


    2023-12-14T12:55:48.854215  / # /lava-12269975/bin/lava-test-runner /la=
va-12269975/1

    2023-12-14T12:55:48.896872  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T12:55:48.913206  + cd /lava-1226997<8>[   18.226058] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12269975_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

