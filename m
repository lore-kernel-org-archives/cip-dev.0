Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4580C48BF6
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 09:27:01 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
 by mx.groups.io with SMTP id smtpd.web10.20637.1709198816534174926
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 29 Feb 2024 01:26:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=vyqu9B7z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.171, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bba50cd318so468395b6e.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 29 Feb 2024 01:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709198815; x=1709803615; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PqdEBwyeKPSRzFZJCfZxWSzNiOsU0ZVYD25W0qb2Hg4=;
        b=vyqu9B7zHCIN68sRhVwBzHXVcvwMMMHn7FHpFSHD9yDbfar/CF5dsTo4AYstywxKrL
         FLOIKIj7yV0eOnOvbAQmnUlfHpfqQ7tvnR4gvXvOc0J34hDz9PlyTFVC92DrO2Za3+be
         gxIpgDtZingyG9kxY81GUFD/wu5GSWhzgwXOp68/wwCVfwWYANLlqwn1uPKKp3bDvUF8
         RcGMS+znkRr1gjFWEpm0865xZnhIOPPEceKyEej1cNE8d9kDUtF5U9LViUd/apqyuVSG
         hvO6trqfmmJH6n6tnKhttNZnxMboe5sbDMbLL1VBVvTSRXCKXgP31MsVkOq0GhUPiAkX
         fRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709198815; x=1709803615;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PqdEBwyeKPSRzFZJCfZxWSzNiOsU0ZVYD25W0qb2Hg4=;
        b=FEKRjZCxjded5wmFn8PetAPosuNLIDax7u80cfPf9MYjjVXvxGI3BS4hMYEbp+2aWJ
         Z4MHcNnpaIgbag9DNIJpPYVWP110tTX+6+Hsn03u4jeimf/y3Bbaupq6MUnl26I6igNp
         HSUUkg2wB2N35JEpoXYABBl//ZYI6DUyLZE65nTO/tRJSN21QCtFc0vsbnTyHNLL4wpW
         mFV1NFIfePLHF1qCu8b79BtYKqIhQqrV7Xo7bssspz1Ldn9bW3hFefZkI1ArYtLXGLqh
         Do/mi556KnmsPvhUqak4YEP225vUoJaCuBzglKkVhY8Z+gPD/EOUaJ3E1xgXnYeGqkOK
         PLGg==
X-Gm-Message-State: AOJu0Yxn78d4aXasRctMc5D32x96v6i6sw/7Ffg/XUsEXbbDFrKa3h6Z
	ID7ro5SjvuTP+8BDK6ciMVevutfQWuVl9grnOe2pI0FKkyiSqSDstLOZaA68IN1Bi/DpvlRjEvP
	+dNs=
X-Google-Smtp-Source: AGHT+IEsfjXiPmfr/AxGwqWcm32vsIlyfEKOXxF4Yl90DnoYnebkdXalaW2mvM2L6JQimoTSiPY/8w==
X-Received: by 2002:a05:6808:1a16:b0:3bf:db6a:7614 with SMTP id bk22-20020a0568081a1600b003bfdb6a7614mr1818414oib.42.1709198814649;
        Thu, 29 Feb 2024 01:26:54 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090a744800b00299d061656csm965726pjk.41.2024.02.29.01.26.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 01:26:54 -0800 (PST)
Message-ID: <65e04dde.170a0220.74316.2db1@mx.google.com>
Date: Thu, 29 Feb 2024 01:26:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-56-g55117716ac0fd
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 142 runs,
 16 regressions (v5.10.209-cip44-56-g55117716ac0fd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 09:27:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15104

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 142 runs, 16 regressio=
ns (v5.10.209-cip44-56-g55117716ac0fd)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
at91sam9g20ek            | arm   | lab-broonie   | gcc-10   | at91_dt_defco=
nfig            | 2          =

bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =

r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =

r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =

sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-56-g55117716ac0fd/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-56-g55117716ac0fd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      55117716ac0fd541adb5a35e66eb21c45107b040 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
at91sam9g20ek            | arm   | lab-broonie   | gcc-10   | at91_dt_defco=
nfig            | 2          =


  Details:     https://kernelci.org/test/plan/id/65e0388c8787018d39637012

  Results:     47 PASS, 6 FAIL, 1 SKIP
  Full config: at91_dt_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/at91_dt_defconfig/gcc-10=
/lab-broonie/baseline-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/at91_dt_defconfig/gcc-10=
/lab-broonie/baseline-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.sound-card: https://kernelci.org/test/case/id/65e0388c8=
787018d3963701d
        failing since 5 days (last pass: v5.10.205-905-gb40421b142370, firs=
t fail: v5.10.209-cip44-424-g38943e302f8c8)

    2024-02-29T07:55:39.278168  /lava-646760/1/../bin/lava-test-case
    2024-02-29T07:55:39.315876  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dsou=
nd-card RESULT=3Dfail>   =


  * baseline.bootrr.audio-card-probed: https://kernelci.org/test/case/id/65=
e0388c8787018d3963701e
        failing since 5 days (last pass: v5.10.205-905-gb40421b142370, firs=
t fail: v5.10.209-cip44-424-g38943e302f8c8)

    2024-02-29T07:55:38.184361  /lava-646760/1/../bin/lava-test-case
    2024-02-29T07:55:38.223658  <8><LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Daud=
io-card-probed RESULT=3Dfail>   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/65e03a909aac70091a637026

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/bcm2835_defconfig/gcc-10=
/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/bcm2835_defconfig/gcc-10=
/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e03a909aac70091a63702b
        failing since 216 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-02-29T08:15:11.321812  / # #

    2024-02-29T08:15:11.423970  export SHELL=3D/bin/sh

    2024-02-29T08:15:11.424676  #

    2024-02-29T08:15:11.525997  / # export SHELL=3D/bin/sh. /lava-12894021/=
environment

    2024-02-29T08:15:11.526733  =


    2024-02-29T08:15:11.628186  / # . /lava-12894021/environment/lava-12894=
021/bin/lava-test-runner /lava-12894021/1

    2024-02-29T08:15:11.629275  =


    2024-02-29T08:15:11.646294  / # /lava-12894021/bin/lava-test-runner /la=
va-12894021/1

    2024-02-29T08:15:11.710247  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-29T08:15:11.748231  + cd /lava-12894021/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e0406bed52d3e4ab637027

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e0406bed52d3e4ab63705b
        failing since 420 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2024-02-29T08:29:16.378866  <8>[   19.471707] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 646824_1.5.2.4.1>
    2024-02-29T08:29:16.486639  / # #
    2024-02-29T08:29:16.587941  export SHELL=3D/bin/sh
    2024-02-29T08:29:16.588206  #
    2024-02-29T08:29:16.689305  / # export SHELL=3D/bin/sh. /lava-646824/en=
vironment
    2024-02-29T08:29:16.689572  =

    2024-02-29T08:29:16.790769  / # . /lava-646824/environment/lava-646824/=
bin/lava-test-runner /lava-646824/1
    2024-02-29T08:29:16.791185  =

    2024-02-29T08:29:16.795838  / # /lava-646824/bin/lava-test-runner /lava=
-646824/1
    2024-02-29T08:29:16.904644  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e04b9a87ee75c2fe637012

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e04b9a87ee75c2fe637047
        failing since 420 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2024-02-29T09:17:01.871204  <8>[   13.978279] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1100576_1.5.2.4.1>
    2024-02-29T09:17:01.978261  / # #
    2024-02-29T09:17:02.079715  export SHELL=3D/bin/sh
    2024-02-29T09:17:02.080280  #
    2024-02-29T09:17:02.181252  / # export SHELL=3D/bin/sh. /lava-1100576/e=
nvironment
    2024-02-29T09:17:02.181711  =

    2024-02-29T09:17:02.282633  / # . /lava-1100576/environment/lava-110057=
6/bin/lava-test-runner /lava-1100576/1
    2024-02-29T09:17:02.283369  =

    2024-02-29T09:17:02.287536  / # /lava-1100576/bin/lava-test-runner /lav=
a-1100576/1
    2024-02-29T09:17:02.392434  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65e043f62d09daa46a637051

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e043f62d09daa46a63708c
        failing since 47 days (last pass: v5.10.205-897-gcc9858ae2881, firs=
t fail: v5.10.205-905-gb40421b142370)

    2024-02-29T08:44:01.713316  <8>[   27.660460] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 646874_1.5.2.4.1>
    2024-02-29T08:44:01.821613  / # #
    2024-02-29T08:44:01.924482  export SHELL=3D/bin/sh
    2024-02-29T08:44:01.925214  #
    2024-02-29T08:44:02.027211  / # export SHELL=3D/bin/sh. /lava-646874/en=
vironment
    2024-02-29T08:44:02.027990  =

    2024-02-29T08:44:02.130069  / # . /lava-646874/environment/lava-646874/=
bin/lava-test-runner /lava-646874/1
    2024-02-29T08:44:02.131317  =

    2024-02-29T08:44:02.145611  / # /lava-646874/bin/lava-test-runner /lava=
-646874/1
    2024-02-29T08:44:02.204472  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a7743-iwg20d-q7        | arm   | lab-cip       | gcc-10   | shmobile_defc=
onfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/65e03d88bccc49cc5163701f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65e03d88bccc49cc51637=
020
        failing since 76 days (last pass: v5.10.201-cip41-473-gc43d7b7bbe83=
a, first fail: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65e0461968ef513ef9637025

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e0461968ef513ef963702a
        failing since 182 days (last pass: v5.10.180-cip33-21-g090289427e8b=
2, first fail: v5.10.191-cip38-218-g9947ff6f0dba7)

    2024-02-29T08:53:22.166327  + set +x
    2024-02-29T08:53:22.169619  <8>[   84.011456] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1100604_1.5.2.4.1>
    2024-02-29T08:53:22.277751  / # #
    2024-02-29T08:53:23.736261  export SHELL=3D/bin/sh
    2024-02-29T08:53:23.757031  #
    2024-02-29T08:53:23.757447  / # export SHELL=3D/bin/sh
    2024-02-29T08:53:25.707292  / # . /lava-1100604/environment
    2024-02-29T08:53:29.294277  /lava-1100604/bin/lava-test-runner /lava-11=
00604/1
    2024-02-29T08:53:29.315498  . /lava-1100604/environment
    2024-02-29T08:53:29.315860  / # /lava-1100604/bin/lava-test-runner /lav=
a-1100604/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e04328e67b44aa7a6370a0

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e04328e67b44aa7a6370a5
        failing since 216 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-02-29T08:40:51.748589  / # #
    2024-02-29T08:40:53.206593  export SHELL=3D/bin/sh
    2024-02-29T08:40:53.226939  #
    2024-02-29T08:40:53.227047  / # export SHELL=3D/bin/sh
    2024-02-29T08:40:55.176168  / # . /lava-1100586/environment
    2024-02-29T08:40:58.763366  /lava-1100586/bin/lava-test-runner /lava-11=
00586/1
    2024-02-29T08:40:58.785112  . /lava-1100586/environment
    2024-02-29T08:40:58.785490  / # /lava-1100586/bin/lava-test-runner /lav=
a-1100586/1
    2024-02-29T08:40:58.963234  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-29T08:40:58.963885  + cd /lava-1100586/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65e045abb2b42eac47637012

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e045abb2b42eac47637017
        failing since 216 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-02-29T08:51:24.599738  / # #
    2024-02-29T08:51:26.055766  export SHELL=3D/bin/sh
    2024-02-29T08:51:26.076553  #
    2024-02-29T08:51:26.076945  / # export SHELL=3D/bin/sh
    2024-02-29T08:51:28.023981  / # . /lava-1100597/environment
    2024-02-29T08:51:31.606869  /lava-1100597/bin/lava-test-runner /lava-11=
00597/1
    2024-02-29T08:51:31.628237  . /lava-1100597/environment
    2024-02-29T08:51:31.628676  / # /lava-1100597/bin/lava-test-runner /lav=
a-1100597/1
    2024-02-29T08:51:31.707110  + export 'TESTRUN_ID=3D1_bootrr'
    2024-02-29T08:51:31.707757  + cd /lava-1100597/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a77960-ulcb            | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65e04315e67b44aa7a637087

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e04315e67b44aa7a63708c
        failing since 216 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-02-29T08:51:42.664892  / # #

    2024-02-29T08:51:42.767236  export SHELL=3D/bin/sh

    2024-02-29T08:51:42.768013  #

    2024-02-29T08:51:42.869458  / # export SHELL=3D/bin/sh. /lava-12894483/=
environment

    2024-02-29T08:51:42.870275  =


    2024-02-29T08:51:42.971759  / # . /lava-12894483/environment/lava-12894=
483/bin/lava-test-runner /lava-12894483/1

    2024-02-29T08:51:42.972982  =


    2024-02-29T08:51:42.975745  / # /lava-12894483/bin/lava-test-runner /la=
va-12894483/1

    2024-02-29T08:51:43.038867  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-29T08:51:43.039378  + cd /lav<8>[   16.426368] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 12894483_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/65e03d840414bc2a76637022

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65e03d840414bc2a76637028
        failing since 314 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-02-29T08:17:31.377584  <8>[   43.059947] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2024-02-29T08:17:32.439394  /lava-12894082/1/../bin/lava-test-case

    2024-02-29T08:17:32.464407  <8>[   44.146299] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65e03d840414bc2a76637029
        failing since 314 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-02-29T08:17:31.351544  /lava-12894082/1/../bin/lava-test-case
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65e0426292d263412c6370a5

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e0426292d263412c6370aa
        failing since 186 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2024-02-29T08:38:58.918146  / # #

    2024-02-29T08:39:00.178807  export SHELL=3D/bin/sh

    2024-02-29T08:39:00.189699  #

    2024-02-29T08:39:00.190127  / # export SHELL=3D/bin/sh

    2024-02-29T08:39:01.933465  / # . /lava-12894298/environment

    2024-02-29T08:39:05.137481  /lava-12894298/bin/lava-test-runner /lava-1=
2894298/1

    2024-02-29T08:39:05.147828  . /lava-12894298/environment

    2024-02-29T08:39:05.152037  / # /lava-12894298/bin/lava-test-runner /la=
va-12894298/1

    2024-02-29T08:39:05.279781  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-29T08:39:05.279842  + cd /lava-12894298/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65e0433e31b0963b73637055

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e0433e31b0963b7363705a
        failing since 186 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2024-02-29T08:42:30.441621  / # #

    2024-02-29T08:42:31.701700  export SHELL=3D/bin/sh

    2024-02-29T08:42:31.712675  #

    2024-02-29T08:42:31.713144  / # export SHELL=3D/bin/sh

    2024-02-29T08:42:33.456149  / # . /lava-12894480/environment

    2024-02-29T08:42:36.659004  /lava-12894480/bin/lava-test-runner /lava-1=
2894480/1

    2024-02-29T08:42:36.670336  . /lava-12894480/environment

    2024-02-29T08:42:36.675474  / # /lava-12894480/bin/lava-test-runner /la=
va-12894480/1

    2024-02-29T08:42:36.725458  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-29T08:42:36.725941  + cd /lava-12894480/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
sun50i-h6-pine-h64       | arm64 | lab-collabora | gcc-10   | defconfig    =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65e04329e67b44aa7a6370ad

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-56-g55117716ac0fd/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65e04329e67b44aa7a6370b2
        failing since 216 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2024-02-29T08:51:58.105919  / # #

    2024-02-29T08:51:58.208133  export SHELL=3D/bin/sh

    2024-02-29T08:51:58.208853  #

    2024-02-29T08:51:58.310281  / # export SHELL=3D/bin/sh. /lava-12894472/=
environment

    2024-02-29T08:51:58.311009  =


    2024-02-29T08:51:58.412480  / # . /lava-12894472/environment/lava-12894=
472/bin/lava-test-runner /lava-12894472/1

    2024-02-29T08:51:58.413638  =


    2024-02-29T08:51:58.430129  / # /lava-12894472/bin/lava-test-runner /la=
va-12894472/1

    2024-02-29T08:51:58.470584  + export 'TESTRUN_ID=3D1_bootrr'

    2024-02-29T08:51:58.489254  + cd /lava-1289447<8>[   18.167812] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 12894472_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

