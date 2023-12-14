Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00495C4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 01:11:44 +0000 (UTC)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
 by mx.groups.io with SMTP id smtpd.web10.11727.1702516303545144616
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Dec 2023 17:11:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=fFjS292r;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.169, mailfrom: bot@kernelci.org)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-35f7589ea1fso3913975ab.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Dec 2023 17:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702516302; x=1703121102; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iY9ljhkgFgoNTJ9D1fR0iZdQZxae4wyQ0m27f3RuItM=;
        b=fFjS292rkE/SYV+m86E4qqgPZdOtunSU/6n7xvZNqWkjWaEDQ+x+mOxUDHJ0JiNUl3
         ef/URVIo3NgyFy4Ay5uhvnyiza2MRtH5ud9krkvFaO/hhOd1YQWc/dBGbF9355x8Qi6H
         lbeQrljGrpwGyExDljA6WxthgLKQBK64xuZS+BM6cszfEuTf4CpPmwdPOHRPvNkm8Uzu
         6YacSb2JZccvyorx2XOaxxA+Z18CDt5g5DwGaihiv6fqiE4vTlxhx6IeSRoBXuu+FPxy
         LCIuu5BwpaASCBLmw0LP4emCbxROr2Q8WzxTW1NRklYgsiAnfwAw/Kxdi4lv4Yc3vDyp
         SFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702516302; x=1703121102;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iY9ljhkgFgoNTJ9D1fR0iZdQZxae4wyQ0m27f3RuItM=;
        b=Fn6oHcxpRyN6MYZuZ2OpsV2dKi2gZ7vA/9zeZR7LDjdkkYolAtoa/UlRoQk7P5+F5N
         o9Zj70q3ig2XjJSr0+Mu06bAt1zlKnGaoQZI1tkHZLenPH9rDioWyvBHEWul6lV0UxUV
         hOlJkuAdpiUE7CKp3y8sZYdxFlclFHqD13KyM/Pca1KWA8QRlvjQGl0+av41cAFjY8G2
         bEKR0UxeNKHUtBq9GSo65YIlV0MYni/0HQXKvkTQxX5hMm5SLuT7lwmBGA/uoII7d5Dq
         5572JshElvApXM503sWRN6+VJ4j5hMX9Ikg65ofoSfiPULgHITbkrgfQnDPece9LjKVN
         M0ag==
X-Gm-Message-State: AOJu0YxK8jm9JIPW2bQps88biMoae11ZTMDQzjmBi4n+o8S0F5GXAy9U
	SZHuh0+ypea58KzQ4PusS9iGGIByU30QzzdETGkiMw==
X-Google-Smtp-Source: AGHT+IH6ppUL6NY6fTZmXhjABfdd9Ie885Tann3hWCjYCQBgi1c13iFqAFi22QYIBxnhxhOF1y0XeQ==
X-Received: by 2002:a05:6e02:19c8:b0:35d:a93b:a035 with SMTP id r8-20020a056e0219c800b0035da93ba035mr10545945ill.34.1702516301592;
        Wed, 13 Dec 2023 17:11:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709029a4700b001cf7bd9ade5sm11148827plv.3.2023.12.13.17.11.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:11:41 -0800 (PST)
Message-ID: <657a564d.170a0220.fdd91.3215@mx.google.com>
Date: Wed, 13 Dec 2023 17:11:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-473-gc43d7b7bbe83a
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 140 runs,
 13 regressions (v5.10.201-cip41-473-gc43d7b7bbe83a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 01:11:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14075

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 140 runs, 13 regressio=
ns (v5.10.201-cip41-473-gc43d7b7bbe83a)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =

beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =

beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =

r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-473-gc43d7b7bbe83a/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-473-gc43d7b7bbe83a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c43d7b7bbe83ae0f7e001ac115b838d7cd1afe79 =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
bcm2836-rpi-2-b          | arm   | lab-collabora | gcc-10   | bcm2835_defco=
nfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/657a4875559b2d9aebe13480

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm/bcm2835_defconfig/gcc-1=
0/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a4875559b2d9aebe13489
        failing since 139 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-14T00:19:51.839229  / # #

    2023-12-14T00:19:51.941478  export SHELL=3D/bin/sh

    2023-12-14T00:19:51.942224  #

    2023-12-14T00:19:52.043668  / # export SHELL=3D/bin/sh. /lava-12264465/=
environment

    2023-12-14T00:19:52.044473  =


    2023-12-14T00:19:52.145964  / # . /lava-12264465/environment/lava-12264=
465/bin/lava-test-runner /lava-12264465/1

    2023-12-14T00:19:52.147131  =


    2023-12-14T00:19:52.163553  / # /lava-12264465/bin/lava-test-runner /la=
va-12264465/1

    2023-12-14T00:19:52.227564  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T00:19:52.271405  + cd /lava-12264465/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-broonie   | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/657a4f9c6ba3d3ad04e13492

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm/omap2plus_defconfig/gcc=
-10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a4f9c6ba3d3ad04e134cb
        failing since 343 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-12-14T00:42:44.414721  <8>[   17.178866] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 350905_1.5.2.4.1>
    2023-12-14T00:42:44.523168  / # #
    2023-12-14T00:42:44.624774  export SHELL=3D/bin/sh
    2023-12-14T00:42:44.625391  #
    2023-12-14T00:42:44.726813  / # export SHELL=3D/bin/sh. /lava-350905/en=
vironment
    2023-12-14T00:42:44.727192  =

    2023-12-14T00:42:44.828382  / # . /lava-350905/environment/lava-350905/=
bin/lava-test-runner /lava-350905/1
    2023-12-14T00:42:44.829051  =

    2023-12-14T00:42:44.833474  / # /lava-350905/bin/lava-test-runner /lava=
-350905/1
    2023-12-14T00:42:44.939157  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
beaglebone-black         | arm   | lab-cip       | gcc-10   | omap2plus_def=
config          | 1          =


  Details:     https://kernelci.org/test/plan/id/657a539a06ba9a0f60e13479

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a539a06ba9a0f60e134b1
        failing since 343 days (last pass: v5.10.155-cip21-405-g26d566555c3=
de, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-12-14T00:59:59.023132  <8>[   14.014675] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1058624_1.5.2.4.1>
    2023-12-14T00:59:59.131905  / # #
    2023-12-14T00:59:59.233266  export SHELL=3D/bin/sh
    2023-12-14T00:59:59.233788  #
    2023-12-14T00:59:59.334766  / # export SHELL=3D/bin/sh. /lava-1058624/e=
nvironment
    2023-12-14T00:59:59.335199  =

    2023-12-14T00:59:59.436135  / # . /lava-1058624/environment/lava-105862=
4/bin/lava-test-runner /lava-1058624/1
    2023-12-14T00:59:59.436854  =

    2023-12-14T00:59:59.441023  / # /lava-1058624/bin/lava-test-runner /lav=
a-1058624/1
    2023-12-14T00:59:59.550051  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/657a4e1d1b1cc5f4f3e13506

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a4e1d1b1cc5f4f3e13546
        failing since 83 days (last pass: v5.10.191-cip38-661-g112a3073ff26=
, first fail: v5.10.194-cip39-407-g664623343843d)

    2023-12-14T00:36:12.176446  <8>[   32.107835] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 350817_1.5.2.4.1>
    2023-12-14T00:36:12.284287  / # #
    2023-12-14T00:36:12.387080  export SHELL=3D/bin/sh
    2023-12-14T00:36:12.387882  #
    2023-12-14T00:36:12.489731  / # export SHELL=3D/bin/sh. /lava-350817/en=
vironment
    2023-12-14T00:36:12.490554  =

    2023-12-14T00:36:12.592459  / # . /lava-350817/environment/lava-350817/=
bin/lava-test-runner /lava-350817/1
    2023-12-14T00:36:12.593731  =

    2023-12-14T00:36:12.607778  / # /lava-350817/bin/lava-test-runner /lava=
-350817/1
    2023-12-14T00:36:12.786527  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/657a50d4c04493afb2e13479

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a50d4c04493afb2e13482
        failing since 139 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-14T00:48:00.954940  + set +x
    2023-12-14T00:48:00.958263  <8>[   84.042250] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1058615_1.5.2.4.1>
    2023-12-14T00:48:01.067065  / # #
    2023-12-14T00:48:02.525783  export SHELL=3D/bin/sh
    2023-12-14T00:48:02.546765  #
    2023-12-14T00:48:02.547323  / # export SHELL=3D/bin/sh
    2023-12-14T00:48:04.497679  / # . /lava-1058615/environment
    2023-12-14T00:48:08.084216  /lava-1058615/bin/lava-test-runner /lava-10=
58615/1
    2023-12-14T00:48:08.106017  . /lava-1058615/environment
    2023-12-14T00:48:08.106530  / # /lava-1058615/bin/lava-test-runner /lav=
a-1058615/1 =

    ... (28 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/657a5200523029081ce134da

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a5200523029081ce134e3
        failing since 139 days (last pass: v5.10.182-cip35-289-g3c054954070=
6, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-14T00:52:51.780365  + set +x
    2023-12-14T00:52:51.783487  <8>[   84.154898] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1058606_1.5.2.4.1>
    2023-12-14T00:52:51.891593  / # #
    2023-12-14T00:52:53.351406  export SHELL=3D/bin/sh
    2023-12-14T00:52:53.372415  #
    2023-12-14T00:52:53.372931  / # export SHELL=3D/bin/sh
    2023-12-14T00:52:55.324776  / # . /lava-1058606/environment
    2023-12-14T00:52:58.916442  /lava-1058606/bin/lava-test-runner /lava-10=
58606/1
    2023-12-14T00:52:58.937979  . /lava-1058606/environment
    2023-12-14T00:52:58.938354  / # /lava-1058606/bin/lava-test-runner /lav=
a-1058606/1 =

    ... (15 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/657a4e181077010219e13476

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a4e181077010219e1347f
        failing since 139 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-14T00:36:11.701050  / # #
    2023-12-14T00:36:13.157975  export SHELL=3D/bin/sh
    2023-12-14T00:36:13.179068  #
    2023-12-14T00:36:13.179815  / # export SHELL=3D/bin/sh
    2023-12-14T00:36:15.126596  / # . /lava-1058589/environment
    2023-12-14T00:36:18.707666  /lava-1058589/bin/lava-test-runner /lava-10=
58589/1
    2023-12-14T00:36:18.728123  . /lava-1058589/environment
    2023-12-14T00:36:18.728208  / # /lava-1058589/bin/lava-test-runner /lav=
a-1058589/1
    2023-12-14T00:36:18.911325  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-14T00:36:18.911488  + cd /lava-1058589/1/tests/1_bootrr =

    ... (24 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
r8a774c0-ek874           | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/657a5020c37213f3f4e13476

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a5020c37213f3f4e1347f
        failing since 139 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-12-14T00:44:55.061938  / # #
    2023-12-14T00:44:56.519421  export SHELL=3D/bin/sh
    2023-12-14T00:44:56.540272  #
    2023-12-14T00:44:56.540530  / # export SHELL=3D/bin/sh
    2023-12-14T00:44:58.487839  / # . /lava-1058608/environment
    2023-12-14T00:45:02.068815  /lava-1058608/bin/lava-test-runner /lava-10=
58608/1
    2023-12-14T00:45:02.089379  . /lava-1058608/environment
    2023-12-14T00:45:02.089476  / # /lava-1058608/bin/lava-test-runner /lav=
a-1058608/1
    2023-12-14T00:45:02.167625  + export 'TESTRUN_ID=3D1_bootrr'
    2023-12-14T00:45:02.167811  + cd /lava-1058608/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/657a4e17e10971ad48e13476

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/657a4e17e10971ad48e13480
        failing since 237 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-12-14T00:36:24.834251  <8>[   69.787107] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-12-14T00:36:25.906846  /lava-12264705/1/../bin/lava-test-case

    2023-12-14T00:36:25.932148  <8>[   70.884848] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/657a4e17e10971ad48e13481
        failing since 237 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-12-14T00:36:24.809916  /lava-12264705/1/../bin/lava-test-case
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/657a4f4e867493ad6ce13516

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/657a4f4e867493ad6ce13520
        failing since 237 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-12-14T00:44:07.101861  /lava-12264862/1/../bin/lava-test-case

    2023-12-14T00:44:07.113122  <8>[   35.118183] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/657a4f4e867493ad6ce13521
        failing since 237 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-12-14T00:44:06.065644  /lava-12264862/1/../bin/lava-test-case

    2023-12-14T00:44:06.076597  <8>[   34.081481] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
                | regressions
-------------------------+-------+---------------+----------+--------------=
----------------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/657a4d88c5704cb58ce134e6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-473-gc43d7b7bbe83a/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/657a4d88c5704cb58ce134ef
        failing since 109 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4=
c8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-12-14T00:34:28.304291  / # #

    2023-12-14T00:34:29.565111  export SHELL=3D/bin/sh

    2023-12-14T00:34:29.576010  #

    2023-12-14T00:34:29.576495  / # export SHELL=3D/bin/sh

    2023-12-14T00:34:31.320170  / # . /lava-12264688/environment

    2023-12-14T00:34:34.525326  /lava-12264688/bin/lava-test-runner /lava-1=
2264688/1

    2023-12-14T00:34:34.536779  . /lava-12264688/environment

    2023-12-14T00:34:34.537182  / # /lava-12264688/bin/lava-test-runner /la=
va-12264688/1

    2023-12-14T00:34:34.674104  + export 'TESTRUN_ID=3D1_bootrr'

    2023-12-14T00:34:34.674588  + cd /lava-12264688/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

