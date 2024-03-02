Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D72C54E41
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 23:06:38 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.62934.1709420796526987835
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Mar 2024 15:06:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Ek4R0yhf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dca3951ad9so31487265ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 02 Mar 2024 15:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709420795; x=1710025595; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qHwcm9kNaxTTGkKs9Objwvo6kpARAaXZVzUSHjCZ8MA=;
        b=Ek4R0yhfMz3i8Gi49o8reIR8db/lerIcTlb+aSsctI3HH9N5PkZzA4Za6lQXE9DQ54
         wleUjATJ8WeuaJNg0WXWNcAIxY3JHRdNWN1Ra1CIYxgrvN4zO8x9lRSI+88hBTd7uW5P
         EYXpdfffn+kFc/LIiLQhmukKJkTpX3qN94P6RegBjVRQFl2J6hh0aKywrtX/lAlg2Gcj
         fPHcFHkasYetun1EjwLi9EUyWXTJTGeVYqP2XLfkuCSUAdY4vu2flSg6wLBmYe96Ar8a
         ZDJc3WYB8ufSayykkJaLoMk1CbIZN0FKV5TO40/KjsF8j4SN8OymQ/ZOAT64kgpc3M7l
         3ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709420795; x=1710025595;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHwcm9kNaxTTGkKs9Objwvo6kpARAaXZVzUSHjCZ8MA=;
        b=aBCDHc/BSxOl5exSHhewhwa9dgoy2s19bsQ9/WTzddKjw/BDuJurs1lSLbtrxef6Ig
         Qhgm+o0QYTizrkwI3TMtL9OYIS6daHftrOEUlpgR8fQ4bIoIrqErAQbqDZxPg9bjfng2
         jLePP8gTNrI5SYKIwUNafXQHwHLBpRYkY9HDweELfUjFxkpXUCHXHwQuIbsI3lSK8WMM
         gDl+GnA9BSb2pLQp9Mf0I5am3isXnvay7bTMxJl+22LZ3sWgj2+rK1Gwjd+ZyEbOfTcD
         HF/sFIagTXbGm/XtIR++NxpiC/Oot4pQ5FZ81YRznd/q6jzn4lLjbVqJExVAqAVffifr
         Qv4A==
X-Gm-Message-State: AOJu0YzVDo2WifRrY4ePdCjGfF5M6Em1un/nvjORhg04LO67tIU8PHI+
	OnSuRVrQW1IbkcuVFevXL2OLRVN6qB5/7reKfq3IYFfLrXrE/O7uLO/Ku6xod3oUcXsrfNqVm7j
	G4MY=
X-Google-Smtp-Source: AGHT+IG5DslkqSEnoTR+42y473LbjRcOOGRe2SqkS9lu985/HMJCv8SzoYJIpVuiI9600t4d8Sj3bA==
X-Received: by 2002:a17:902:c3c6:b0:1dc:ce55:e6da with SMTP id j6-20020a170902c3c600b001dcce55e6damr4468672plj.62.1709420795316;
        Sat, 02 Mar 2024 15:06:35 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q7-20020a170902dac700b001dc23e877c9sm5732468plx.106.2024.03.02.15.06.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 15:06:34 -0800 (PST)
Message-ID: <65e3b0fa.170a0220.5f79c.8863@mx.google.com>
Date: Sat, 02 Mar 2024 15:06:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-404-gdddfc5d4f194
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 51 runs,
 11 regressions (v6.1.78-cip15-404-gdddfc5d4f194)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 23:06:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15168

cip-gitlab/ci/pavel/linux-test baseline-nfs: 51 runs, 11 regressions (v6.1.=
78-cip15-404-gdddfc5d4f194)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig        | 1          =

imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig        | 1          =

imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-404-gdddfc5d4f194/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-404-gdddfc5d4f194
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dddfc5d4f194925df6ee3d06e86b1d1e12412f06 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a203968f1c0100637022

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e3a203968f1c0100637027
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:02:18.347365  + set +x<8>[   18.395210] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 12919805_1.5.2.3.1>

    2024-03-02T22:02:18.347433  =


    2024-03-02T22:02:18.452067  / # #

    2024-03-02T22:02:18.553576  export SHELL=3D/bin/sh

    2024-03-02T22:02:18.554124  #

    2024-03-02T22:02:18.655075  / # export SHELL=3D/bin/sh. /lava-12919805/=
environment

    2024-03-02T22:02:18.655335  =


    2024-03-02T22:02:18.755842  / # . /lava-12919805/environment/lava-12919=
805/bin/lava-test-runner /lava-12919805/1

    2024-03-02T22:02:18.756106  =


    2024-03-02T22:02:18.760986  / # /lava-12919805/bin/lava-test-runner /la=
va-12919805/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a5e2a14b7bbcbe63704e

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e3a5e2a14b7bbcbe637083
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:18:43.383833  + set +x
    2024-03-02T22:18:43.384084  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 654611_1.6.2=
.4.1>
    2024-03-02T22:18:43.516050  #
    2024-03-02T22:18:43.619244  / # #export SHELL=3D/bin/sh
    2024-03-02T22:18:43.620034  =

    2024-03-02T22:18:43.721969  / # export SHELL=3D/bin/sh. /lava-654611/en=
vironment
    2024-03-02T22:18:43.722813  =

    2024-03-02T22:18:43.824789  / # . /lava-654611/environment/lava-654611/=
bin/lava-test-runner /lava-654611/1
    2024-03-02T22:18:43.826113  =

    2024-03-02T22:18:43.829975  / # /lava-654611/bin/lava-test-runner /lava=
-654611/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a7c4490a9907f563701d

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/omap2plus_defconfig/gcc-10/lab-broonie=
/baseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e3a7c5490a9907f5637050
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:27:01.383550  + set +x
    2024-03-02T22:27:01.387446  <8>[   45.316730] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 654654_1.6.2.4.1>
    2024-03-02T22:27:01.513669  / # #
    2024-03-02T22:27:01.616710  export SHELL=3D/bin/sh
    2024-03-02T22:27:01.617413  #
    2024-03-02T22:27:01.719319  / # export SHELL=3D/bin/sh. /lava-654654/en=
vironment
    2024-03-02T22:27:01.720298  =

    2024-03-02T22:27:01.822370  / # . /lava-654654/environment/lava-654654/=
bin/lava-test-runner /lava-654654/1
    2024-03-02T22:27:01.823819  =

    2024-03-02T22:27:01.827975  / # /lava-654654/bin/lava-test-runner /lava=
-654654/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a2b0eeb1ccbb2263704a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e3a2b0eeb1ccbb2263704f
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:08:07.898494  + <8>[   18.348041] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12919854_1.5.2.3.1>

    2024-03-02T22:08:07.898579  set +x

    2024-03-02T22:08:08.002848  / # #

    2024-03-02T22:08:08.103467  export SHELL=3D/bin/sh

    2024-03-02T22:08:08.103619  #

    2024-03-02T22:08:08.204102  / # export SHELL=3D/bin/sh. /lava-12919854/=
environment

    2024-03-02T22:08:08.204251  =


    2024-03-02T22:08:08.304818  / # . /lava-12919854/environment/lava-12919=
854/bin/lava-test-runner /lava-12919854/1

    2024-03-02T22:08:08.305065  =


    2024-03-02T22:08:08.309517  / # /lava-12919854/bin/lava-test-runner /la=
va-12919854/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a1f40137666105637037

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e3a1f5013766610563703c
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:02:13.918000  + set +x

    2024-03-02T22:02:13.924598  <8>[   17.802462] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12919775_1.5.2.3.1>

    2024-03-02T22:02:14.029214  / # #

    2024-03-02T22:02:14.129844  export SHELL=3D/bin/sh

    2024-03-02T22:02:14.130005  #

    2024-03-02T22:02:14.230594  / # export SHELL=3D/bin/sh. /lava-12919775/=
environment

    2024-03-02T22:02:14.230757  =


    2024-03-02T22:02:14.331448  / # . /lava-12919775/environment/lava-12919=
775/bin/lava-test-runner /lava-12919775/1

    2024-03-02T22:02:14.331688  =


    2024-03-02T22:02:14.336664  / # /lava-12919775/bin/lava-test-runner /la=
va-12919775/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a1ee013766610563702c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e3a1ee0137666105637031
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:02:14.659320  <8>[   15.468951] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12919788_1.5.2.3.1>

    2024-03-02T22:02:14.764334  / # #

    2024-03-02T22:02:14.864873  export SHELL=3D/bin/sh

    2024-03-02T22:02:14.865011  #

    2024-03-02T22:02:14.965499  / # export SHELL=3D/bin/sh. /lava-12919788/=
environment

    2024-03-02T22:02:14.965639  =


    2024-03-02T22:02:15.066158  / # . /lava-12919788/environment/lava-12919=
788/bin/lava-test-runner /lava-12919788/1

    2024-03-02T22:02:15.066444  =


    2024-03-02T22:02:15.071982  / # /lava-12919788/bin/lava-test-runner /la=
va-12919788/1

    2024-03-02T22:02:15.155760  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6dl-udoo                  | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a572e82240020463707c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e3a572e82240020=
463707d
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx6q-udoo                   | arm    | lab-broonie   | gcc-10   | imx_v6_v=
7_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a5732b842cdc28637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e3a5732b842cdc2=
8637013
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
imx8mp-evk                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3ab495dacf80bc6637104

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-nfs-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-nfs-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e3ab495dacf80bc6637109
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-02T22:41:52.421197  + set<8>[   80.035978] <LAVA_SIGNAL_ENDRUN =
0_dmesg 654676_1.6.2.4.1>
    2024-03-02T22:41:52.421536   +x
    2024-03-02T22:41:52.540803  / # #
    2024-03-02T22:41:53.701741  export SHELL=3D/bin/sh
    2024-03-02T22:41:53.707366  #
    2024-03-02T22:41:55.201894  / # export SHELL=3D/bin/sh. /lava-654676/en=
vironment
    2024-03-02T22:41:55.207968  =

    2024-03-02T22:41:57.922683  / # . /lava-654676/environment/lava-654676/=
bin/lava-test-runner /lava-654676/1
    2024-03-02T22:41:57.928767  =

    2024-03-02T22:41:57.940934  / # /lava-654676/bin/lava-test-runner /lava=
-654676/1 =

    ... (17 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3a1ea0179c71fb7637023

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/x86_64/x86_64_defconfig+x86-board/gcc-10/l=
ab-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e3a1ea0179c71fb7637028
        new failure (last pass: v4.19.306-cip107-1142-gdcbd51e7744f)

    2024-03-02T22:02:44.845462  + <8>[   17.980029] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12919784_1.5.2.3.1>

    2024-03-02T22:02:44.845554  set +x

    2024-03-02T22:02:44.949880  / # #

    2024-03-02T22:02:45.050464  export SHELL=3D/bin/sh

    2024-03-02T22:02:45.050667  #

    2024-03-02T22:02:45.151166  / # export SHELL=3D/bin/sh. /lava-12919784/=
environment

    2024-03-02T22:02:45.151373  =


    2024-03-02T22:02:45.251877  / # . /lava-12919784/environment/lava-12919=
784/bin/lava-test-runner /lava-12919784/1

    2024-03-02T22:02:45.252212  =


    2024-03-02T22:02:45.257679  / # /lava-12919784/bin/lava-test-runner /la=
va-12919784/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e3ab7d33f90a4484637019

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e3ab7d33f90a448=
463701a
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =20

