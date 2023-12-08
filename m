Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA173C4167B
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:19:15 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web11.41318.1702055945925511153
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:19:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=dpnNwl4k;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6cec976b197so1158484b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702055945; x=1702660745; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TSsNuc45zjqlxD5qKgJ0WOS6iLAF/4JejaIZNBO5x9A=;
        b=dpnNwl4kzmSIdvbcZOKVq/cwjCqm27s8nclr0lXWxwK1ETsE9x0Gl/JPJvQxZ4ZZi/
         1cnlETvIsRAWmkt7i0ah6lowz2nZ+hlXLzQNjO1MzGYcOevqlO3FrWLsGF8celR1AoDK
         3CW+Wzci5iBfYUhGER5IHd6ZdqXLk1N4eA49P0EyNMqk/9Q7LefyGpI4k16WVHXU3PVC
         SRC6+UxQmZX/dAZIURSe4e5dy5YuHlQxc21rjZKRS16QiB2dcl6kePuO5zAy0bUx1/Kp
         2UUWsTrv9O54gP2h+khHQj9FDUKoyeuibSEWNUIloi6PZSEYRuVKmJrOjewbtl80LioJ
         2ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702055945; x=1702660745;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSsNuc45zjqlxD5qKgJ0WOS6iLAF/4JejaIZNBO5x9A=;
        b=mLfEvmT7B+B4ShL31OY8adNplRdalrccPFEmwt/p6M9JB6/u0sCpiVUatLtfNeDTo6
         JtQqwwmfVNzwhDnXQMn/5CKVNrBKpcgHftBvgz14iIdE1Ihm4/INDhdYN/i0hpl3h0HK
         umOl9THs2puWkHI9Aqt/7IegC7oz91tohdOmx5FKvqQOPw4rIWfz7H3MDFtMTgjqaRnb
         No2jhlNV9wHw+nEoyMc/Yk6iHMR7eHQTbVqR8sgDPuHEkFe3Kq1DC12X/amdbnHbX6iP
         nKSjOtn0Mc8cqu3jevbVy8uCvjW/zphlxEOcNPuRTm16vjhExkT49SnFKdLlkQsznkx3
         XTMA==
X-Gm-Message-State: AOJu0YykpgmgH7f7GI05FSR6AkJxa4jioxMP5B+DZ+sQZWUIkDg1j7FB
	QS52xHQznIB8B0yIXJy00i8HVdoO4lBBqQgKDP8cGg==
X-Google-Smtp-Source: AGHT+IGNas4EOXdHT4/PvxfOaC0JnM9Ht6NSu0mTaE7VAbnSuTIKPGTcLUbC+NfoLOkxC5e350Yo6w==
X-Received: by 2002:a05:6a00:6594:b0:6ce:e1b0:a1e7 with SMTP id hd20-20020a056a00659400b006cee1b0a1e7mr239771pfb.58.1702055944869;
        Fri, 08 Dec 2023 09:19:04 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n21-20020a056a0007d500b006c320b9897fsm1815567pfu.126.2023.12.08.09.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:19:04 -0800 (PST)
Message-ID: <65735008.050a0220.62464.649e@mx.google.com>
Date: Fri, 08 Dec 2023 09:19:04 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip baseline-nfs: 42 runs,
 7 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:19:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13974

cip/linux-5.10.y-cip baseline-nfs: 42 runs, 7 regressions (v5.10.201-cip41-=
46-g596f4c151d286)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config | 1          =

imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig  | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
       | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
       | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config | 1          =


  Details:     https://kernelci.org/test/plan/id/65734bf685920bf254e1347d

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nf=
s-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65734bf685920bf254e134b6
        failing since 328 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-08T17:01:24.437998  <8>[   39.986256] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1054884_1.6.2.4.1>
    2023-12-08T17:01:24.554380  / # #
    2023-12-08T17:01:24.655591  export SHELL=3D/bin/sh
    2023-12-08T17:01:24.656021  #
    2023-12-08T17:01:24.756824  / # export SHELL=3D/bin/sh. /lava-1054884/e=
nvironment
    2023-12-08T17:01:24.757185  =

    2023-12-08T17:01:24.857932  / # . /lava-1054884/environment/lava-105488=
4/bin/lava-test-runner /lava-1054884/1
    2023-12-08T17:01:24.858597  =

    2023-12-08T17:01:24.862482  / # /lava-1054884/bin/lava-test-runner /lav=
a-1054884/1
    2023-12-08T17:01:25.105350  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/6573497837715c6502e13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6573497837715c6502e13482
        failing since 328 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-08T16:50:51.011042  / # #

    2023-12-08T16:50:51.113843  export SHELL=3D/bin/sh

    2023-12-08T16:50:51.114651  #

    2023-12-08T16:50:51.216548  / # export SHELL=3D/bin/sh. /lava-12221418/=
environment

    2023-12-08T16:50:51.217340  =


    2023-12-08T16:50:51.319187  / # . /lava-12221418/environment/lava-12221=
418/bin/lava-test-runner /lava-12221418/1

    2023-12-08T16:50:51.320526  =


    2023-12-08T16:50:51.333102  / # /lava-12221418/bin/lava-test-runner /la=
va-12221418/1

    2023-12-08T16:50:51.528534  + export TESTRUN_ID=3D1_bootrr

    2023-12-08T16:50:51.529067  + cd /lava-12221418/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/65734de16610d277fbe1349b

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-ju=
no-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-ju=
no-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65734de16610d277fbe134db
        failing since 65 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-08T17:09:31.452715  <8>[   40.474646] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 326607_1.6.2.4.1>
    2023-12-08T17:09:31.561813  / # #
    2023-12-08T17:09:31.664880  export SHELL=3D/bin/sh
    2023-12-08T17:09:31.665657  #
    2023-12-08T17:09:31.767683  / # export SHELL=3D/bin/sh. /lava-326607/en=
vironment
    2023-12-08T17:09:31.768457  =

    2023-12-08T17:09:31.870696  / # . /lava-326607/environment/lava-326607/=
bin/lava-test-runner /lava-326607/1
    2023-12-08T17:09:31.872039  =

    2023-12-08T17:09:31.884659  / # /lava-326607/bin/lava-test-runner /lava=
-326607/1
    2023-12-08T17:09:32.069503  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/65734777ab8cbb2ac7e13518

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65734777ab8cbb2ac=
7e13519
        failing since 65 days (last pass: v5.10.194-cip39, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65734a5b14660cf43ce1348f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65734a5b14660cf43=
ce13490
        failing since 114 days (last pass: v5.10.186-cip37-13-g260094841fe1=
a, first fail: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/657347011e2b7db320e13563

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657347011e2b7db320e1356c
        failing since 65 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-08T16:40:15.471238  / # #

    2023-12-08T16:40:16.731644  export SHELL=3D/bin/sh

    2023-12-08T16:40:16.742664  #

    2023-12-08T16:40:16.743170  / # export SHELL=3D/bin/sh

    2023-12-08T16:40:18.486206  / # . /lava-12221377/environment

    2023-12-08T16:40:21.687090  /lava-12221377/bin/lava-test-runner /lava-1=
2221377/1

    2023-12-08T16:40:21.697527  . /lava-12221377/environment

    2023-12-08T16:40:21.697605  / # /lava-12221377/bin/lava-test-runner /la=
va-12221377/1

    2023-12-08T16:40:21.878566  + export TESTRUN_ID=3D1_bootrr

    2023-12-08T16:40:21.878696  + cd /lava-12221377/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/657347c47f28acbaf6e1347a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/657347c47f28acbaf6e13483
        failing since 65 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-08T16:43:43.296818  / # #

    2023-12-08T16:43:44.554693  export SHELL=3D/bin/sh

    2023-12-08T16:43:44.565587  #

    2023-12-08T16:43:44.566014  / # export SHELL=3D/bin/sh

    2023-12-08T16:43:46.308476  . /lava-12221398/environment

    2023-12-08T16:43:49.512892  / # . /lava-12221398/environment/lava-12221=
398/bin/lava-test-runner /lava-12221398/1

    2023-12-08T16:43:49.524180  =


    2023-12-08T16:43:49.524476  / # /lava-12221398/bin/lava-test-runner /la=
va-12221398/1

    2023-12-08T16:43:49.955911  + export TESTRUN_ID=3D1_bootrr

    2023-12-08T16:43:49.956362  + cd /lava-12221398/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

