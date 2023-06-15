Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2D2EB64D9
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 10:08:10 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.14622.1686823682251801954
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 03:08:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=gjxKt6uv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-666acbdfc86so11303b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 03:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686823681; x=1689415681;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Epj16O1Hd+xpmm9iz0oPhtOgAAToVU6t06IZ7e/Z+fg=;
        b=gjxKt6uv6PpxASOGrAuVK3pVuwTbLMwLBr0WgblPA5eUJHr0kC8ZDDcPzT5xze/DZ9
         MeX5xZjR2C6JKwP9A4ahsJofJfcr+ssht1RmXi92rLZpP1PktQrM/Ul0Bfzjz/PQNip+
         LOdSo7QMDRhaA7d8CzDrJq8Xdu4dsCqpyM6kArM5mMwATyKiXHAPM03WHIMhh3pumVuW
         l/Sv9M3DgVTZ9MJHL8mRUzCWH2tIo6Uy1s7zkznH1KxjaVSXSeSLn64SUhQX6q85QcOH
         XUGx+Z6sU3MnsVG3PbgcHbk5kBZzHxhWJiU3Czcx4Vt8dRk0HoxqQHhq0xYBd2tqH9qQ
         0KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686823681; x=1689415681;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Epj16O1Hd+xpmm9iz0oPhtOgAAToVU6t06IZ7e/Z+fg=;
        b=RBEUF6jqDXYfa4lINlZw0q70YH54q2oJkMAhqB3p5OwMBCmJZpNtw8NXDoo0/thNR2
         ZNPou4y85PNQtkrcHmZ/3yrzsWY1KsYeEDdSXBYSoCjQkUIaxXxu4jZbC1poyf7X8oCZ
         62iLgneJMSIh4bwHJ9BkB/ee4FdWxGzypiIevZfiKls0P5/N5iPRBacoOggxMBRo6uo/
         y/r/HlbeDmGHA4CR/GOTOVgCJkYecV45L36jTumQ7ixFiaX+9xGwb4xq0FfwHB0F2f1H
         OLjjobIyYKmr9mGnT6qSrKI9AMffG0M8f5qCkOJhO2NQ47rAmGe1PCQILASO2qABK0j6
         5rSg==
X-Gm-Message-State: AC+VfDw65BiJq1Aas7b4Y3C0fn461W338bZ6yKbNs8rN+H6iw+z70i5N
	+CukEwTD4jCXyNlD+KOYYOUYIDt7m/g8yHH/VEuuPQ==
X-Google-Smtp-Source: ACHHUZ5TcHL3HK2U/yM/mQPPEkST6gEKDOnNcLdMzdfX+EtyB2vW7jHDvPcT/GjP0vAg7z0geXGoBw==
X-Received: by 2002:a05:6a21:158a:b0:10c:8e0f:7b1b with SMTP id nr10-20020a056a21158a00b0010c8e0f7b1bmr3424666pzb.59.1686823680750;
        Thu, 15 Jun 2023 03:08:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p6-20020aa78606000000b0064d47cd117esm1005547pfn.39.2023.06.15.03.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:08:00 -0700 (PDT)
Message-ID: <648ae300.a70a0220.2f122.1eba@mx.google.com>
Date: Thu, 15 Jun 2023 03:08:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gdba81ae6f2be
Subject: cip/linux-5.10.y-cip baseline-nfs: 56 runs,
 14 regressions (v5.10.182-cip35-8-gdba81ae6f2be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 10:08:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12046

cip/linux-5.10.y-cip baseline-nfs: 56 runs, 14 regressions (v5.10.182-cip35=
-8-gdba81ae6f2be)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =

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

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-8-gdba81ae6f2be/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-8-gdba81ae6f2be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dba81ae6f2be7f7d87f3a29a8566758d2e0017ae =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad6a3f391ccf65330612e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/648ad6a3f391ccf653306133
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:14:56.264618  <8>[   19.367395] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10740244_1.5.2.3.1>

    2023-06-15T09:14:56.267921  + set +x

    2023-06-15T09:14:56.372536  / # #

    2023-06-15T09:14:56.473225  export SHELL=3D/bin/sh

    2023-06-15T09:14:56.473471  #

    2023-06-15T09:14:56.573995  / # export SHELL=3D/bin/sh. /lava-10740244/=
environment

    2023-06-15T09:14:56.574179  =


    2023-06-15T09:14:56.674660  / # . /lava-10740244/environment/lava-10740=
244/bin/lava-test-runner /lava-10740244/1

    2023-06-15T09:14:56.674976  =


    2023-06-15T09:14:56.680750  / # /lava-10740244/bin/lava-test-runner /la=
va-10740244/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad6c65cb6041768306147

  Results:     46 PASS, 7 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-n=
fs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-n=
fs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/648ad6c65cb6041768306179
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:15:18.346838  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 614931_1.6.2=
.4.1>
    2023-06-15T09:15:18.479306  #
    2023-06-15T09:15:18.582724  / # #export SHELL=3D/bin/sh
    2023-06-15T09:15:18.583564  =

    2023-06-15T09:15:18.685514  / # export SHELL=3D/bin/sh. /lava-614931/en=
vironment
    2023-06-15T09:15:18.686315  =

    2023-06-15T09:15:18.788333  / # . /lava-614931/environment/lava-614931/=
bin/lava-test-runner /lava-614931/1
    2023-06-15T09:15:18.789589  =

    2023-06-15T09:15:18.796337  / # /lava-614931/bin/lava-test-runner /lava=
-614931/1
    2023-06-15T09:15:19.212464  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad7760dd2e802b2306183

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline-n=
fs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648ad7760dd2e802b=
2306184
        failing since 0 day (last pass: v5.10.182-cip35, first fail: v5.10.=
182-cip35-1-g7cde3fba93966) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648ada2bea315ed06830612e

  Results:     28 PASS, 5 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-b=
eaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-b=
eaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/648ada2cea315ed068306131
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:28:23.078092  + set +x
    2023-06-15T09:28:23.082435  <8>[  121.822757] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 963631_1.6.2.4.1>
    2023-06-15T09:28:23.791842  / # #
    2023-06-15T09:28:23.893549  export SHELL=3D/bin/sh
    2023-06-15T09:28:23.893984  #
    2023-06-15T09:28:23.995278  / # export SHELL=3D/bin/sh. /lava-963631/en=
vironment
    2023-06-15T09:28:23.995711  =

    2023-06-15T09:28:24.096981  / # . /lava-963631/environment/lava-963631/=
bin/lava-test-runner /lava-963631/1
    2023-06-15T09:28:24.097771  =

    2023-06-15T09:28:24.103960  / # /lava-963631/bin/lava-test-runner /lava=
-963631/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad8b6ef84671258306150

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-=
nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648ad8b6ef8467125=
8306151
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/648ae1c0abaddcfe9a306159

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/648ae1c0abaddcfe9a30615c
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T10:01:56.941071  + set +x
    2023-06-15T10:01:56.945249  <8>[   64.238297] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 963673_1.6.2.4.1>
    2023-06-15T10:01:57.196227  #
    2023-06-15T10:01:57.298137  / # #export SHELL=3D/bin/sh
    2023-06-15T10:01:57.298730  =

    2023-06-15T10:01:57.400003  / # export SHELL=3D/bin/sh. /lava-963673/en=
vironment
    2023-06-15T10:01:57.400483  =

    2023-06-15T10:01:57.501717  / # . /lava-963673/environment/lava-963673/=
bin/lava-test-runner /lava-963673/1
    2023-06-15T10:01:57.502391  =

    2023-06-15T10:01:57.509343  /lava-963673/bin/lava-test-runner /lava-963=
673/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad6a78e5d04ed7b306135

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/648ad6a78e5d04ed7b30613a
        failing since 61 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-15T09:15:22.001006  + <8>[   16.173410] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 10740212_1.5.2.3.1>

    2023-06-15T09:15:22.001092  set +x

    2023-06-15T09:15:22.105392  / # #

    2023-06-15T09:15:22.205995  export SHELL=3D/bin/sh

    2023-06-15T09:15:22.206210  #

    2023-06-15T09:15:22.306723  / # export SHELL=3D/bin/sh. /lava-10740212/=
environment

    2023-06-15T09:15:22.306918  =


    2023-06-15T09:15:22.407430  / # . /lava-10740212/environment/lava-10740=
212/bin/lava-test-runner /lava-10740212/1

    2023-06-15T09:15:22.407801  =


    2023-06-15T09:15:22.411681  / # /lava-10740212/bin/lava-test-runner /la=
va-10740212/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad6b0f391ccf653306189

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/648ad6b0f391ccf65330618e
        failing since 61 days (last pass: v5.10.176-cip30, first fail: v5.1=
0.177-cip31)

    2023-06-15T09:15:08.297460  + set +x

    2023-06-15T09:15:08.303363  <8>[   21.178897] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 10740271_1.5.2.3.1>

    2023-06-15T09:15:08.407928  / # #

    2023-06-15T09:15:08.508796  export SHELL=3D/bin/sh

    2023-06-15T09:15:08.508971  #

    2023-06-15T09:15:08.609503  / # export SHELL=3D/bin/sh. /lava-10740271/=
environment

    2023-06-15T09:15:08.609680  =


    2023-06-15T09:15:08.710325  / # . /lava-10740271/environment/lava-10740=
271/bin/lava-test-runner /lava-10740271/1

    2023-06-15T09:15:08.711548  =


    2023-06-15T09:15:08.716783  / # /lava-10740271/bin/lava-test-runner /la=
va-10740271/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
imx6q-sabrelite              | arm    | lab-collabora | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad6a6f391ccf65330614a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/648ad6a6f391ccf65330614f
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:15:04.868193  / # #

    2023-06-15T09:15:04.969141  export SHELL=3D/bin/sh

    2023-06-15T09:15:04.969831  #

    2023-06-15T09:15:05.071409  / # export SHELL=3D/bin/sh. /lava-10740195/=
environment

    2023-06-15T09:15:05.071651  =


    2023-06-15T09:15:05.172381  / # . /lava-10740195/environment/lava-10740=
195/bin/lava-test-runner /lava-10740195/1

    2023-06-15T09:15:05.173484  =


    2023-06-15T09:15:05.174679  / # /lava-10740195/bin/lava-test-runner /la=
va-10740195/1

    2023-06-15T09:15:05.323644  + export TESTRUN_ID=3D1_bootrr

    2023-06-15T09:15:05.324163  + cd /lava-10740195/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/648ada0b5631a833d030619d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+kselftest/gcc-10/lab-broonie/baselin=
e-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+kselftest/gcc-10/lab-broonie/baselin=
e-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648ada0b5631a833d=
030619e
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/648ade6811816bae97306137

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648ade6811816bae9=
7306138
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/648adc7b3ed4534ad63061b0

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/648adc7b3ed4534ad63061b6
        failing since 85 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-15T09:40:09.797655  <8>[   37.667668] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-06-15T09:40:10.858019  /lava-10740422/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/648adc7b3ed4534ad63061b7
        failing since 85 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.175-cip29)

    2023-06-15T09:40:08.678585  <8>[   36.548765] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-06-15T09:40:09.755449  /lava-10740422/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/648ad7e26849afa879306145

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun5=
0i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-sun5=
0i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/648ad7e26849afa87930616f
        failing since 152 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-06-15T09:20:09.606597  <8>[   30.865788] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 614981_1.6.2.4.1>
    2023-06-15T09:20:09.730829  / # #
    2023-06-15T09:20:09.833286  export SHELL=3D/bin/sh
    2023-06-15T09:20:09.833833  #
    2023-06-15T09:20:09.935775  / # export SHELL=3D/bin/sh. /lava-614981/en=
vironment
    2023-06-15T09:20:09.936345  =

    2023-06-15T09:20:10.038151  / # . /lava-614981/environment/lava-614981/=
bin/lava-test-runner /lava-614981/1
    2023-06-15T09:20:10.039137  =

    2023-06-15T09:20:10.043261  / # /lava-614981/bin/lava-test-runner /lava=
-614981/1
    2023-06-15T09:20:10.184529  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

