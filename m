Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BBEC6FD1F
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 10:08:33 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.38955.1679479707460743637
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 03:08:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=QnhKPryt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so18611462pjt.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679479707;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gs0BFdPIRj05d4jfKDcrY5nR4W/ZYW7cVc1JWqydMEE=;
        b=QnhKPryt/a9BaBm8cb4ObBAtwFO2pD2uE1kOY2RnwDZ6tLwAUaj6BhqGFvZn0n8hsg
         Ncgr53FZhRmUrOfa7aRzmEIe/PX2BSwRdUnuZlx+IFpQi2VzV+x38YaLH3pfeF28dCVS
         au+CJIyHvspYqftToWlBSHw+Ja40EJFtoLcxnuVX7uo9dFxlqx7oBtnCB3w7eMdBzRBy
         wTxVCEdWxtcmFrhstpzjkIrZZBIVrmm+1xyrcyPXZmbcpjQtXNhiKlEbmnA5WZwaTv8y
         9ZH/DHNtr5hCX8cjvcgQDdxUBXf5/TQZLZh6/G/UBPavK2hobmxsMBcFcl8LITUnegUR
         WdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679479707;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gs0BFdPIRj05d4jfKDcrY5nR4W/ZYW7cVc1JWqydMEE=;
        b=YfF+S3ti4wucLDM04Q17qlVOiGkh83jTJGaX3u/YWN46iw2yks1ym/1Dy6L1x2zeFL
         hWihPcM7Ps8RIpJzQQ3eWBTjUqBzFPvjAPL/DY6s5H0VPIg1r7odIF4nuMMTB6QsDCaw
         qnOUaHLBPNLhZRCNQUZdLVdqOmbDI+usxuZ+qxyg5YAj+/1x6dos3ih9XmOv8PUex+b1
         8FBs803EVtJTIps+Q01a5FbgsPOj2gFFhpaVCEXZSALk6HWJWqHw9+dutQ2jjCwzg1HZ
         K0YfM+v8zDCJNpGwMzOcFFOC5FzinsujMHy+ot7VSYkjoQhVDZbSsqYuEjKovId1/jz8
         exfQ==
X-Gm-Message-State: AO0yUKV2fpxjICmkp1YM7odR+KCYfv4zpUzDpXPa69Hf60BjsIS0fqEh
	IrVpGtOASrG6spT9ZfpdHRBlkVX5URce1snYgEWwaQ==
X-Google-Smtp-Source: AK7set8YwHGlG8ew5B9aQy0IM4nZ1sjRIEdEfiE8aNbXil0HzGl55iwshAHM5+JAOcWFtmtoCzdlKA==
X-Received: by 2002:a17:902:fac3:b0:1a1:cefd:aa1f with SMTP id ld3-20020a170902fac300b001a1cefdaa1fmr1741429plb.52.1679479705938;
        Wed, 22 Mar 2023 03:08:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902b58e00b001a1cd6c5a88sm5986951pls.73.2023.03.22.03.08.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 03:08:25 -0700 (PDT)
Message-ID: <641ad399.170a0220.1e3ce.ae55@mx.google.com>
Date: Wed, 22 Mar 2023 03:08:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94-1098-g26d9f86d942d
Subject: cip-gitlab/ci/pavel/linux-test baseline: 95 runs,
 39 regressions (v4.19.277-cip94-1098-g26d9f86d942d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 10:08:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11063

cip-gitlab/ci/pavel/linux-test baseline: 95 runs, 39 regressions (v4.19.277=
-cip94-1098-g26d9f86d942d)

Regressions Summary
-------------------

platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C436FA-Flip-hatch     | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-cx9400-volteer        | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =

beaglebone-black           | arm    | lab-cip         | gcc-10   | omap2plu=
s_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =

imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =

imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =

juno-uboot                 | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-broonie     | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-broonie     | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

qemu_x86_64-uefi-mixed     | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efconfig             | 1          =

r8a7743-iwg20d-q7          | arm    | lab-cip         | gcc-10   | shmobile=
_defconfig           | 1          =

rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 5          =

rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =

sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =

tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | tegra_de=
fconfig              | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.277-cip94-1098-g26d9f86d942d/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.277-cip94-1098-g26d9f86d942d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      26d9f86d942d1c22bb7542618e47ea5c0e6b4026 =



Test Regressions
---------------- =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
acer-cb317-1h-c3z6-dedede  | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641ac9ac455c4470339c9520

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-acer-cb317-1h-c3z6-dedede.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641ac9ad455c4470339c9=
521
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch     | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aca9b6acaa849de9c9543

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641aca9b6acaa849de9c9=
544
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
asus-cx9400-volteer        | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641ac9aa361cbf21d29c9529

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/baseline-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641ac9aa361cbf21d29c9=
52a
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-broonie     | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641ac94e89eb5841429c953d

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/641ac94e89eb5841=
429c9542
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)
        1 lines

    2023-03-22T09:23:42.642897  / # =

    2023-03-22T09:23:42.652578  =

    2023-03-22T09:23:42.785102  / # #
    2023-03-22T09:23:42.793391  #
    2023-03-22T09:23:42.903391  / # export SHELL=3D/bin/sh
    2023-03-22T09:23:42.911636  export SHELL=3D/bin/sh
    2023-03-22T09:23:43.019870  / # . /lava-205856/environment
    2023-03-22T09:23:43.029828  . /lava-205856/environment
    2023-03-22T09:23:43.137698  / # /lava-205856/bin/lava-test-runner /lava=
-205856/0
    2023-03-22T09:23:43.150862  /lava-205856/bin/lava-test-runner /lava-205=
856/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641acb61899a43d5ca9c9522

  Results:     24 PASS, 20 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-cip/b=
aseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/641acb61899a43d5=
ca9c9525
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)
        1 lines

    2023-03-22T09:32:29.903830  / # =

    2023-03-22T09:32:29.906820  =

    2023-03-22T09:32:30.011229  / # #
    2023-03-22T09:32:30.014315  #
    2023-03-22T09:32:30.116035  / # export SHELL=3D/bin/sh
    2023-03-22T09:32:30.118986  export SHELL=3D/bin/sh
    2023-03-22T09:32:30.220446  / # . /lava-883349/environment
    2023-03-22T09:32:30.223554  . /lava-883349/environment
    2023-03-22T09:32:30.325031  / # /lava-883349/bin/lava-test-runner /lava=
-883349/0
    2023-03-22T09:32:30.327417  /lava-883349/bin/lava-test-runner /lava-883=
349/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
beaglebone-black           | arm    | lab-cip         | gcc-10   | omap2plu=
s_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641acf91ece3df8f389c954a

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/omap2plus_defconfig/gcc-10/lab-cip/=
baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.crit: https://kernelci.org/test/case/id/641acf91ece3df8f=
389c954d
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)
        1 lines

    2023-03-22T09:50:52.834776  / # =

    2023-03-22T09:50:52.846278  =

    2023-03-22T09:50:52.950074  / # #
    2023-03-22T09:50:52.958983  #
    2023-03-22T09:50:53.060865  / # export SHELL=3D/bin/sh
    2023-03-22T09:50:53.070430  export SHELL=3D/bin/sh
    2023-03-22T09:50:53.171844  / # . /lava-883360/environment
    2023-03-22T09:50:53.181120  . /lava-883360/environment
    2023-03-22T09:50:53.282719  / # /lava-883360/bin/lava-test-runner /lava=
-883360/0
    2023-03-22T09:50:53.289914  /lava-883360/bin/lava-test-runner /lava-883=
360/0 =

    ... (9 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | imx_v6_v=
7_defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/641ac7684304ae96389c9548

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/imx_v6_v7_defconfig/gcc-10/lab-peng=
utronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641ac7684304ae96389c9551
        failing since 62 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-03-22T09:16:16.700202  + set +x[    7.098504] <LAVA_SIGNAL_ENDRUN =
0_dmesg 921697_1.5.2.3.1>
    2023-03-22T09:16:16.700490  =

    2023-03-22T09:16:16.807773  / # #
    2023-03-22T09:16:16.909575  export SHELL=3D/bin/sh
    2023-03-22T09:16:16.910009  #
    2023-03-22T09:16:17.011493  / # export SHELL=3D/bin/sh. /lava-921697/en=
vironment
    2023-03-22T09:16:17.012026  =

    2023-03-22T09:16:17.113423  / # . /lava-921697/environment/lava-921697/=
bin/lava-test-runner /lava-921697/1
    2023-03-22T09:16:17.114168  =

    2023-03-22T09:16:17.121130  / # /lava-921697/bin/lava-test-runner /lava=
-921697/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6qp-wandboard-revd1     | arm    | lab-pengutronix | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641ac830431e1c80da9c9547

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-pengu=
tronix/baseline-imx6qp-wandboard-revd1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641ac830431e1c80da9c9550
        failing since 62 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-03-22T09:19:32.993214  + set +x
    2023-03-22T09:19:32.993412  [    4.875657] <LAVA_SIGNAL_ENDRUN 0_dmesg =
921700_1.5.2.3.1>
    2023-03-22T09:19:33.100066  / # #
    2023-03-22T09:19:33.201969  export SHELL=3D/bin/sh
    2023-03-22T09:19:33.202494  #
    2023-03-22T09:19:33.303761  / # export SHELL=3D/bin/sh. /lava-921700/en=
vironment
    2023-03-22T09:19:33.304269  =

    2023-03-22T09:19:33.405575  / # . /lava-921700/environment/lava-921700/=
bin/lava-test-runner /lava-921700/1
    2023-03-22T09:19:33.406241  =

    2023-03-22T09:19:33.408466  / # /lava-921700/bin/lava-test-runner /lava=
-921700/1 =

    ... (12 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
imx6ul-14x14-evk           | arm    | lab-nxp         | gcc-10   | multi_v7=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641aca4f90a48144459c952e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx6ul-14x14-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-nxp/b=
aseline-imx6ul-14x14-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641aca4f90a48144459c9537
        new failure (last pass: v5.10.147-cip18-15-gef247a3cd0ad)

    2023-03-22T09:28:16.148280  + set +x<8>[   22.594449] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 1181519_1.5.2.4.1>
    2023-03-22T09:28:16.148587  =

    2023-03-22T09:28:16.257198  =

    2023-03-22T09:28:17.417095  / # #export SHELL=3D/bin/sh
    2023-03-22T09:28:17.422862  =

    2023-03-22T09:28:17.423263  / # export SHELL=3D/bin/sh
    2023-03-22T09:28:18.970686  . /lava-1181519/environment
    2023-03-22T09:28:18.976383  / # . /lava-1181519/environment
    2023-03-22T09:28:21.798635  /lava-1181519/bin/lava-test-runner /lava-11=
81519/1
    2023-03-22T09:28:21.804712  / # /lava-1181519/bin/lava-test-runner /lav=
a-1181519/1 =

    ... (15 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
juno-uboot                 | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641ace6a4420f30e679c9516

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641ace6a4420f30e679c9=
517
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641accc2345487145c9c9512

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641accc2345487145c9c9=
513
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641ace514420f30e679c9511

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641ace514420f30e679c9=
512
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641acc9ad4a7d2c86b9c950a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641acc9ad4a7d2c86b9c9=
50b
        new failure (last pass: v5.10.167-cip26-2-g28bb49f7179b) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641ace53309105e6139c9573

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641ace53309105e6139c9=
574
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641acc1ecde03ac8e19c950e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641acc1ecde03ac8e19c9=
50f
        new failure (last pass: v5.10.167-cip26-2-g28bb49f7179b) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv2-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641acdea4faa7428029c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv2-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv2-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641acdea4faa7428029c9=
506
        new failure (last pass: v5.10.162-cip24-443-g1f8fb81fe752) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641accad8dfe43eca29c9565

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641accad8dfe43eca29c9=
566
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3      | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641ace54686a7e25409c9541

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641ace54686a7e25409c9=
542
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641acc9b8dfe43eca29c9507

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-broonie/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641acc9b8dfe43eca29c9=
508
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-broonie     | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641ace29bd10c261119c9506

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-broonie/base=
line-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641ace29bd10c261119c9=
507
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641acc1f483a173ae49c957c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641acc1f483a173ae49c9=
57d
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3-uefi | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641acdd603de0652369c9551

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv3-uefi.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-qemu_arm64-virt-gicv3-uefi.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641acdd603de0652369c9=
552
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-broonie     | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/641ac8c56263cc9b849c9522

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig/gcc-10/lab-broo=
nie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig/gcc-10/lab-broo=
nie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641ac8c56263cc9b849c9=
523
        failing since 43 days (last pass: v5.10.162-cip24-443-g1f8fb81fe752=
, first fail: v4.4.302-cip72-rt42) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-broonie     | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aca4190a48144459c950f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-broonie/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641aca4190a48144459c9=
510
        failing since 43 days (last pass: v5.10.162-cip24-443-g1f8fb81fe752=
, first fail: v4.4.302-cip72-rt42) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
qemu_x86_64-uefi-mixed     | x86_64 | lab-collabora   | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/641ac901f33e2ca1fd9c951a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig/gcc-10/lab-coll=
abora/baseline-qemu_x86_64-uefi-mixed.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/x86_64/x86_64_defconfig/gcc-10/lab-coll=
abora/baseline-qemu_x86_64-uefi-mixed.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641ac901f33e2ca1fd9c9=
51b
        failing since 43 days (last pass: v5.10.162-cip24-443-g1f8fb81fe752=
, first fail: v4.4.302-cip72-rt42) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
r8a7743-iwg20d-q7          | arm    | lab-cip         | gcc-10   | shmobile=
_defconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/641acbdbe37a5dad7b9c956d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/shmobile_defconfig/gcc-10/lab-cip/b=
aseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/shmobile_defconfig/gcc-10/lab-cip/b=
aseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/641acbdbe37a5dad7b9c9=
56e
        failing since 28 days (last pass: v4.4.302-cip72-rt42, first fail: =
v5.10.167-cip26-2-g28bb49f7179b) =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3288-veyron-jaq          | arm    | lab-collabora   | gcc-10   | multi_v7=
_defconfig           | 5          =


  Details:     https://kernelci.org/test/plan/id/641ac84e2b51f27c309c9588

  Results:     61 PASS, 8 FAIL, 1 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/multi_v7_defconfig/gcc-10/lab-colla=
bora/baseline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-dev-driver-present: https://kernelci.org/test/c=
ase/id/641ac84e2b51f27c309c95a1
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:19:42.793874  <8>[   10.925601] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-03-22T09:19:43.817845  /lava-9727639/1/../bin/lava-test-case<8>[  =
 11.949868] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dcros-ec-dev-driver-present=
 RESULT=3Dfail>
   =


  * baseline.bootrr.rk_iommu-vpu_mmu-probed: https://kernelci.org/test/case=
/id/641ac84e2b51f27c309c95ae
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:19:47.483828  =


    2023-03-22T09:19:48.493627  /lava-9727639/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/test/=
case/id/641ac84e2b51f27c309c95be
        failing since 28 days (last pass: v4.4.302-cip72-rt42, first fail: =
v5.10.167-cip26-2-g28bb49f7179b)

    2023-03-22T09:19:45.187134  ox v1.31.1 (2023-03-10 17:51:43 UTC) multi-=
call binary.

    2023-03-22T09:19:45.187367  =


    2023-03-22T09:19:45.191462  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-03-22T09:19:45.191980  =


    2023-03-22T09:19:45.197007  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-03-22T09:19:45.199253  FIRST, INC default to 1.

    2023-03-22T09:19:45.199800  =


    2023-03-22T09:19:45.203103  	-w	Pad to last with leading zeros

    2023-03-22T09:19:45.205719  	-s SEP	String separator

    2023-03-22T09:19:45.209130  /lava-9727639/1/../bin/lava-test-case
 =

    ... (3 line(s) more)  =


  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/641ac84e2b51f27c309c95c0
        failing since 60 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-03-22T09:19:45.134691  BusyBox v1.31.1 (2023-03-10 17:51:43 UTC)<8=
>[   13.264845] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver=
-audio-present RESULT=3Dfail>

    2023-03-22T09:19:45.137514   multi-call binary.

    2023-03-22T09:19:45.138015  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/641ac84e2b51f27c309c95c1
        failing since 60 days (last pass: v5.10.158-cip22-435-g2c52868ae1cb=
c, first fail: v4.19.269-rt119-1495-gc851fb1e222f)

    2023-03-22T09:19:45.115849  /lava-9727639/1/../bin/lava-test-case<8>[  =
 13.247503] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-probed RES=
ULT=3Dpass>

    2023-03-22T09:19:45.116084  =

   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
rk3399-gru-kevin           | arm64  | lab-collabora   | gcc-10   | defconfi=
g+arm64-chromebook   | 5          =


  Details:     https://kernelci.org/test/plan/id/641acc170cdbf7a8739c950e

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/641acc180cdbf7a8739c9518
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:36:07.956116  /lava-9728047/1/../bin/lava-test-case
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/641acc180cdbf7a8739c9519
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:36:05.917848  <8>[   35.688190] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-03-22T09:36:06.931134  /lava-9728047/1/../bin/lava-test-case

    2023-03-22T09:36:06.940003  <8>[   36.712256] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =


  * baseline.bootrr.cros-ec-sysfs-driver-present: https://kernelci.org/test=
/case/id/641acc180cdbf7a8739c9550
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:36:03.715999  /lava-9728047/1/../bin/lava-test-case
   =


  * baseline.bootrr.cros-ec-lightbar-driver-present: https://kernelci.org/t=
est/case/id/641acc180cdbf7a8739c9559
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:36:02.514263  /lava-9728047/1/../bin/lava-test-case<8>[  =
 32.285484] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dcros-ec-lightbar-driver-pr=
esent RESULT=3Dfail>

    2023-03-22T09:36:02.514440  =

   =


  * baseline.bootrr.cros-ec-debugfs-driver-present: https://kernelci.org/te=
st/case/id/641acc180cdbf7a8739c9562
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:35:59.250852  <8>[   29.023275] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dtpm-chip-is-online RESULT=3Dskip>

    2023-03-22T09:36:00.268263  /lava-9728047/1/../bin/lava-test-case

    2023-03-22T09:36:00.277830  <8>[   30.049002] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-debugfs-driver-present RESULT=3Dfail>
   =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64         | arm64  | lab-collabora   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641accfa3eaf9ba7c39c9507

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm64/defconfig/gcc-10/lab-collabora/ba=
seline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/641accfa3eaf9ba7c39c9510
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)

    2023-03-22T09:39:57.587759  / # #

    2023-03-22T09:39:57.690886  export SHELL=3D/bin/sh

    2023-03-22T09:39:57.691566  #

    2023-03-22T09:39:57.793174  / # export SHELL=3D/bin/sh. /lava-9728230/e=
nvironment

    2023-03-22T09:39:57.793945  =


    2023-03-22T09:39:57.895999  / # . /lava-9728230/environment/lava-972823=
0/bin/lava-test-runner /lava-9728230/1

    2023-03-22T09:39:57.897280  =


    2023-03-22T09:39:57.910274  / # /lava-9728230/bin/lava-test-runner /lav=
a-9728230/1

    2023-03-22T09:39:57.968881  + export 'TESTRUN_ID=3D1_bootrr'

    2023-03-22T09:39:57.969404  + cd /lava-9728230<8>[   15.628966] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 9728230_1.5.2.4.5>
 =

    ... (11 line(s) more)  =

 =



platform                   | arch   | lab             | compiler | defconfi=
g                    | regressions
---------------------------+--------+-----------------+----------+---------=
---------------------+------------
tegra124-nyan-big          | arm    | lab-collabora   | gcc-10   | tegra_de=
fconfig              | 2          =


  Details:     https://kernelci.org/test/plan/id/641acbe3e37a5dad7b9c9570

  Results:     3 PASS, 3 FAIL, 1 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/tegra_defconfig/gcc-10/lab-collabor=
a/baseline-tegra124-nyan-big.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.277-cip94-1098-g26d9f86d942d/arm/tegra_defconfig/gcc-10/lab-collabor=
a/baseline-tegra124-nyan-big.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/armel/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/641acbe3e37a5da=
d7b9c9573
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)
        11 lines

    2023-03-22T09:35:21.063164  : pgd =3D (ptrval)

    2023-03-22T09:35:21.066237  kern  :alert : [b77758c4] *pgd=3D00000000

    2023-03-22T09:35:21.077463  kern  :emerg : Internal error: Oops: 5 [#1]=
 SMP ARM
   =


  * baseline.dmesg.alert: https://kernelci.org/test/case/id/641acbe3e37a5da=
d7b9c9574
        new failure (last pass: v5.10.168-cip27-456-g42a59c4e5329)
        3 lines

    2023-03-22T09:35:21.059309  <8>[   18.157875] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcrit RESULT=3Dpass UNITS=3Dlines MEASUREMENT=3D0>

    2023-03-22T09:35:21.059807  kern  :alert : Unable to handle kernel pagi=
ng request at virtual address b77758c4

    2023-03-22T09:35:21.060880  kern  :alert <8>[   18.183176] <LAVA_SIGNAL=
_TESTCASE TEST_CASE_ID=3Dalert RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D3>
   =

 =20

