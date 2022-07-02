Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30296C43334
	for <webhook@archiver.kernel.org>; Sat,  2 Jul 2022 20:42:49 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web08.54084.1656794567572937002
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 13:42:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Aota/hNi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id l6so5293485plg.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Jul 2022 13:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=iGDN6ylRkYtQQ6EVc7aatqKx8xXha8PPxHNEV+GCfiA=;
        b=Aota/hNi/JnUNMKbwplvfAsryMMkrpFcXXrtB108FVPmXuMVVdTA8GsFg2z+B5BtXj
         3gCcEvQMSIPbAnmmJ4iq/ZGXtychrNowadfqo5Fvw/gNiN3sMNQhcOyS9epDLADbeF6c
         nqkO/uzl30CtWhhD+lDjahueJkHBZzIJZMTtkA17epMm2qGV837xPeBrWA7PMTeNuEci
         8CCLaPlc2teBX4QXhu0onN9mEe6F+38Gs9A2xEKOO1y2boXHnv0rb37VPvrc4qSCy6Uy
         fv4U8e2jmFVORMZ18VHtfCrLxIUiNmwmypHwcS8y3RQ2K/v6IL6sMSGjSCgEgdu3cm87
         bipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=iGDN6ylRkYtQQ6EVc7aatqKx8xXha8PPxHNEV+GCfiA=;
        b=P1fVtz24jNedbE/o8eXU09B+XvvlLlbdXfGIWbLr7ezrsqOoRt2RoOB2J2s7G+aHza
         4tsMcAyYLowXpsyFvx2In9MBQ3PyXfb5nSmWOn0oUZVLzaZFJnS2W0PPOGcqY+DQgW/7
         xhrh51e2GGffnRSpXBbGUqeLgmb6Ts9EGuAdJWrnX3sHYn9GYHVraYI34WFzOBZUGSAi
         7QuXOtV46e+5HZm81DvDj8RJ/Xfllj9v7BD0z+ZsXH8LPI5M2naof67QH6ZNoKFSTMyL
         tNFkJ4yfpJpFiS9zZwe+tN+4Se9/AUTQj0v+7nKPzwFHjI2e9k+B4Ku3Vfw4/yS2XZnI
         ZTBw==
X-Gm-Message-State: AJIora8DuSZMzwKR59cmf7ue0W0qSuA8FD+GqMip6qj+frxlbEammisW
	o72TdJR3uvFpjZC4h5mazv49Inft0o0lW5sr
X-Google-Smtp-Source: 
 AGRyM1ujC8ADAKSnwqkG4Mb0010mSRE3M0vcfzg8/+oqYFNGD1R0utpHBmBLDPNF+3cQFf8SCjwn1g==
X-Received: by 2002:a17:90b:3b85:b0:1ec:d979:ca42 with SMTP id
 pc5-20020a17090b3b8500b001ecd979ca42mr25996418pjb.209.1656794566469;
        Sat, 02 Jul 2022 13:42:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 bf3-20020a170902b90300b0015f2b3bc97asm17890876plb.13.2022.07.02.13.42.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 13:42:45 -0700 (PDT)
Message-ID: <62c0adc5.1c69fb81.f92ea.9d30@mx.google.com>
Date: Sat, 02 Jul 2022 13:42:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-118-gb03e159be974
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 44 runs,
 6 regressions (v5.10.125-cip10-118-gb03e159be974)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Jul 2022 20:42:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8635

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 44 runs, 6 regress=
ions (v5.10.125-cip10-118-gb03e159be974)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
bcm2711-rpi-4-b              | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =

jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | tegra_def=
config            | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-118-gb03e159be974/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-118-gb03e159be974
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b03e159be9746a2cba92777632dfc469e7cdecf3 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
bcm2711-rpi-4-b              | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c0a3349c1a74aa73a39bce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-nfs-bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-nfs-bcm2711-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c0a3349c1a74aa7=
3a39bcf
        failing since 8 days (last pass: v5.10.118-465-g0af29783a3c9, first=
 fail: v5.10.121-cip9-272-g3fb28d4c623b) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62c0a511534a013e37a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c0a511534a013e3=
7a39bce
        failing since 33 days (last pass: v5.10.112-cip6-289-g2969e096d186,=
 first fail: v5.10.118-465-g0af29783a3c9) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | tegra_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/62c0a281f67b739dd4a39ced

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c0a281f67b739dd=
4a39cee
        failing since 33 days (last pass: v5.10.112-cip6-289-g2969e096d186,=
 first fail: v5.10.118-465-g0af29783a3c9) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c0a3d910d3833a0da39be5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c0a3d910d3833a0=
da39be6
        failing since 4 days (last pass: v5.10.121-cip9-272-g3fb28d4c623b, =
first fail: v5.10.121-cip9-287-ge9094c8446fc) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c0a4b764e7f3e621a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c0a4b764e7f3e62=
1a39bce
        failing since 4 days (last pass: v5.10.121-cip9-272-g3fb28d4c623b, =
first fail: v5.10.121-cip9-287-ge9094c8446fc) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c0a1e20054105833a39bd2

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-118-gb03e159be974/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62c0a1e20054105833a39bf4
        failing since 115 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-07-02T19:51:40.320109  /lava-6734694/1/../bin/lava-test-case
    2022-07-02T19:51:40.355002  <8>[   38.825474] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

