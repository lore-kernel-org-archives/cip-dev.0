Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034C5C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:32:07 +0000 (UTC)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
 by mx.groups.io with SMTP id smtpd.web10.84017.1701955917695160173
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:31:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=pfSyFT7t;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.173, mailfrom: bot@kernelci.org)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-35d624b0415so2930825ab.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 05:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701955916; x=1702560716; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J8csHfJo566qzAYvZflBETgjbdENAMiTRwH6k2Kz64U=;
        b=pfSyFT7tQryrGAtQU/kQeHCdGhvUh0OHh5UAIoQP3EDatsEwM2MjNYOQwtPa6AqVhh
         S3W7I/b2MkPebHSRV40m21HVbAn6h24o9GePbOTPauI+wTFnQ+QgFVyC/qAWnMnVgKyW
         lLen6ULKiMq4DmNl9JCHbjCZdk82XXJ78CYIt/JbqVpmgwZTnXPZKfpe3pCeSH5LPfBX
         IzwydU4JvfQ2wfS4cCXzuLu37SR0x7YusUFq9Jc86LQpet6OY2u6iwdhtgAQUoV6YFJz
         tc0mEEyKczgE0zBzpBwpKc+WskO6XeW9ftdTwHj0H4iYDbTlYuRQSWjFD7BddUr7Svdm
         vFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955916; x=1702560716;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8csHfJo566qzAYvZflBETgjbdENAMiTRwH6k2Kz64U=;
        b=Lg8oBVOCGXrZ7xm9o7QZ+0cqeU5lwIoCqofGFJaVPbLvlJA4uuJ4ODb9Utu6GZEUue
         ry8JDKChqfXTPq0cesiqaCyn0hBNYsqkhBAkSp6ELDq4eNe6SFafG5QuDXFGxJ4ffz5i
         0NTaiJ1ywsv62hcWIri+w7jDDpA00niL6PzyIws4C4hCNQVoZZwV1KSTLfjRxv7U/OXn
         zSSqP+qPbSP+Rx1SeLBhUpDFzElfBw6AUj6y4BUuQqetJgRhHBIaPlPpTHP1RVbO3MFq
         zmBz06mbaXA79YogpZqPkpNUjRV3UbQdnvEKl+MYB5OW21cfxKwz86nIm77JTt6zDEMW
         87lQ==
X-Gm-Message-State: AOJu0YyrcBFEBcVy0Y32dFnU2Kp9f0JvUSTJcN+rx5tRZXutPZqwimEV
	kz5NjHmVkONKL4t07PdJ12S/GGhyJTgDPP9f2tH0JA==
X-Google-Smtp-Source: AGHT+IE4ZgI+O312Xjzt0iA4e2PLVrCll3ypLWF8QbXjUXozebfOVr84aINbQ0TU2Euh1pWDMnkFPA==
X-Received: by 2002:a05:6e02:802:b0:35d:6078:c9c1 with SMTP id u2-20020a056e02080200b0035d6078c9c1mr2686526ilm.28.1701955916158;
        Thu, 07 Dec 2023 05:31:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k14-20020a63ab4e000000b005c680643676sm1301082pgp.35.2023.12.07.05.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:31:55 -0800 (PST)
Message-ID: <6571c94b.630a0220.52b35.2eff@mx.google.com>
Date: Thu, 07 Dec 2023 05:31:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-16-g3c85fba3b6e5d
Subject: cip/linux-5.10.y-cip baseline-nfs: 51 runs,
 8 regressions (v5.10.201-cip41-16-g3c85fba3b6e5d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:32:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13841

cip/linux-5.10.y-cip baseline-nfs: 51 runs, 8 regressions (v5.10.201-cip41-=
16-g3c85fba3b6e5d)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig  | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
       | 1          =

juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
       | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =

rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest | 1          =

sun50i-a64-pine64-plus   | arm64 | lab-broonie   | gcc-10   | defconfig    =
       | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-16-g3c85fba3b6e5d/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-16-g3c85fba3b6e5d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3c85fba3b6e5da8b112e7ecd142649674648028f =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
imx6q-sabrelite          | arm   | lab-collabora | gcc-10   | multi_v7_defc=
onfig  | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bfc71ec814c8b1e13484

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseli=
ne-nfs-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6571bfc71ec814c8b1e13489
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T12:51:22.013368  / # #

    2023-12-07T12:51:22.115345  export SHELL=3D/bin/sh

    2023-12-07T12:51:22.115999  #

    2023-12-07T12:51:22.217252  / # export SHELL=3D/bin/sh. /lava-12207398/=
environment

    2023-12-07T12:51:22.217882  =


    2023-12-07T12:51:22.319257  / # . /lava-12207398/environment/lava-12207=
398/bin/lava-test-runner /lava-12207398/1

    2023-12-07T12:51:22.320302  =


    2023-12-07T12:51:22.322398  / # /lava-12207398/bin/lava-test-runner /la=
va-12207398/1

    2023-12-07T12:51:22.511670  + export TESTRUN_ID=3D1_bootrr

    2023-12-07T12:51:22.511824  + cd /lava-12207398/1/tests/1_bootrr
 =

    ... (14 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/6571ba93509206ce01e13492

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-ju=
no-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-ju=
no-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6571ba93509206ce01e134ce
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-07T12:28:32.977491  / # #
    2023-12-07T12:28:33.080313  export SHELL=3D/bin/sh
    2023-12-07T12:28:33.081087  #
    2023-12-07T12:28:33.183004  / # export SHELL=3D/bin/sh. /lava-318158/en=
vironment
    2023-12-07T12:28:33.183804  =

    2023-12-07T12:28:33.285765  / # . /lava-318158/environment/lava-318158/=
bin/lava-test-runner /lava-318158/1
    2023-12-07T12:28:33.287094  =

    2023-12-07T12:28:33.306503  / # /lava-318158/bin/lava-test-runner /lava=
-318158/1
    2023-12-07T12:28:33.476249  + export TESTRUN_ID=3D1_bootrr
    2023-12-07T12:28:33.476864  + cd /lava-318158/1/tests/1_bootrr =

    ... (9 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
juno-uboot               | arm64 | lab-broonie   | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6571c1c46c8e8844a6e134af

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-broonie/basel=
ine-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6571c1c46c8e8844a6e134ea
        failing since 13 days (last pass: v5.10.200-cip40, first fail: v5.1=
0.201-cip41-11-ga539098fe70dd)

    2023-12-07T12:59:02.048844  <8>[   53.317995] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 318299_1.6.2.4.1>
    2023-12-07T12:59:02.169641  / # #
    2023-12-07T12:59:02.272536  export SHELL=3D/bin/sh
    2023-12-07T12:59:02.273257  #
    2023-12-07T12:59:02.375170  / # export SHELL=3D/bin/sh. /lava-318299/en=
vironment
    2023-12-07T12:59:02.375871  =

    2023-12-07T12:59:02.477812  / # . /lava-318299/environment/lava-318299/=
bin/lava-test-runner /lava-318299/1
    2023-12-07T12:59:02.479095  =

    2023-12-07T12:59:02.496137  / # /lava-318299/bin/lava-test-runner /lava=
-318299/1
    2023-12-07T12:59:02.863810  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b90815e21ac74ee134e4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-r8a774=
a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6571b90815e21ac74=
ee134e5
        failing since 64 days (last pass: v5.10.194-cip39, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6571be4b9adaf2a103e13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-cip/baseline-=
nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6571be4b9adaf2a10=
3e13477
        failing since 113 days (last pass: v5.10.186-cip37-13-g260094841fe1=
a, first fail: v5.10.186-cip37-14-gc9b5a049d8ea) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/6571b8ec8fba8e0cfde134ad

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6571b8ec8fba8e0cfde134b2
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-07T12:21:34.529263  / # #

    2023-12-07T12:21:35.790291  export SHELL=3D/bin/sh

    2023-12-07T12:21:35.801248  #

    2023-12-07T12:21:35.801746  / # export SHELL=3D/bin/sh

    2023-12-07T12:21:37.545561  / # . /lava-12207173/environment

    2023-12-07T12:21:40.751280  /lava-12207173/bin/lava-test-runner /lava-1=
2207173/1

    2023-12-07T12:21:40.762672  . /lava-12207173/environment

    2023-12-07T12:21:40.766604  / # /lava-12207173/bin/lava-test-runner /la=
va-12207173/1

    2023-12-07T12:21:40.950383  + export TESTRUN_ID=3D1_bootrr

    2023-12-07T12:21:40.950838  + cd /lava-12207173/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
rk3399-rock-pi-4b        | arm64 | lab-collabora | gcc-10   | defconfig+kse=
lftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6571bd0b8911562148e13489

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig+kselftest/gcc-10/lab-collabora/bas=
eline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6571bd0b8911562148e1348e
        failing since 64 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff)

    2023-12-07T12:39:36.676000  / # #

    2023-12-07T12:39:37.936698  export SHELL=3D/bin/sh

    2023-12-07T12:39:37.947627  #

    2023-12-07T12:39:37.948093  / # export SHELL=3D/bin/sh

    2023-12-07T12:39:39.691530  . /lava-12207319/environment

    2023-12-07T12:39:39.702469  / # . /lava-12207319/environment

    2023-12-07T12:39:42.896416  /lava-12207319/bin/lava-test-runner /lava-1=
2207319/1

    2023-12-07T12:39:42.909513  / # /lava-12207319/bin/lava-test-runner /la=
va-12207319/1

    2023-12-07T12:39:43.336768  + export TESTRUN_ID=3D1_bootrr

    2023-12-07T12:39:43.337220  + cd /lava-12207319/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                 | arch  | lab           | compiler | defconfig    =
       | regressions
-------------------------+-------+---------------+----------+--------------=
-------+------------
sun50i-a64-pine64-plus   | arm64 | lab-broonie   | gcc-10   | defconfig    =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/6571c86168834ca9eae1347d

  Results:     36 PASS, 9 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-su=
n50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-16-g3c85fba3b6e5d/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-su=
n50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6571c86168834ca9eae134a9
        failing since 327 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-12-07T13:27:32.219646  + set +x
    2023-12-07T13:27:32.223617  <8>[   84.418749] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 318197_1.6.2.4.1>
    2023-12-07T13:27:32.367875  / # #
    2023-12-07T13:27:32.469584  export SHELL=3D/bin/sh
    2023-12-07T13:27:32.470108  #
    2023-12-07T13:27:32.571558  / # export SHELL=3D/bin/sh. /lava-318197/en=
vironment
    2023-12-07T13:27:32.572114  =

    2023-12-07T13:27:32.673484  / # . /lava-318197/environment/lava-318197/=
bin/lava-test-runner /lava-318197/1
    2023-12-07T13:27:32.674043  =

    2023-12-07T13:27:32.678291  / # /lava-318197/bin/lava-test-runner /lava=
-318197/1 =

    ... (12 line(s) more)  =

 =20

