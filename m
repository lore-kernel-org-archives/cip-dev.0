Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E0CC433EF
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 20:40:41 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web10.89445.1657053636723297541
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Jul 2022 13:40:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=57TuKx9/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id
 v4-20020a17090abb8400b001ef966652a3so3728150pjr.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 05 Jul 2022 13:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=wJi0SBVGhFcQMQh/haNxEpegdDI6PCRarxlKxg6G5NM=;
        b=57TuKx9/rcjIbzN7AC04rzgRR1aIkhDhOojdCDip4fx03cKYuGcVTw0qCkGU1vlPOk
         f3xdSvxlYl9VuKuN4/RhsOsOQWr9W6VBAx2NKM8H85qt8K+VTzcnOp8wBXeH5jpfOa3e
         C0oJovlZSipdkNKpc21ZemIproQU1pM8540oLMCuEwmPFA82b1JlUCK3HQAiS9beVjAv
         GpEWHm8iBZ8bjWBEM9rsYwFMyUoHUHJyOdl7MfYeVQmWN8+rXOaO/80spbahvx5qNq2u
         opkRSCLuHDysd1neSfsNDgU0KDVgfL9BUsigdrOBKkSYJXCHWBB+Wkgt6ej+VT07zeby
         YA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=wJi0SBVGhFcQMQh/haNxEpegdDI6PCRarxlKxg6G5NM=;
        b=IpICju3wR4RDDM3VjTQzjfmRiR5ZeJ/HSinJqHSJvM3oX49TdTyPnuXeOyh5nq0ZQr
         pnI004FxvZWn7Au/n+nkwl+Jd/09AtXfU0diLhd/BN4VyH7ZqtEdgj9H2yKTzKXopMMz
         lIlRI1/S3rjvY/LXXw52tMLTOrYsFVuwhwH8zL9GaVLBnptA3h54qQR4PlUFQ6DVCIPm
         L14jFvz3J6kIosbPh9RcpHNfa5pUOnkwZHG4o3gi/95lQT/aiHLWiyOlVRk7EkAPZpaA
         ci0ncgexOse3wn0Lv2DJ70XZUe4Lu5wnS6BxBJ861FdfUXC1ZVHqK7y832yKzKlKh5CJ
         OvPw==
X-Gm-Message-State: AJIora/QGie01gCOh3jn86kqZHRpLfgG9D4DKt0UwVsXa1I3hpvG/UUB
	9mWkyia4zvPGcM824Bb3XU5FQ7ixjfmXAa5+
X-Google-Smtp-Source: 
 AGRyM1uO5kW1QohA7xg6Pcjo+BUlOhbsfXqqi5CH+nfRYb4F9FsdjbpPnLdOqEKFeqJlnGjfbNDxWA==
X-Received: by 2002:a17:90b:38c1:b0:1ec:f991:bad0 with SMTP id
 nn1-20020a17090b38c100b001ecf991bad0mr45041219pjb.178.1657053635517;
        Tue, 05 Jul 2022 13:40:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 m22-20020a62a216000000b005289753448fsm1822530pff.123.2022.07.05.13.40.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:40:34 -0700 (PDT)
Message-ID: <62c4a1c2.1c69fb81.d53a0.2c87@mx.google.com>
Date: Tue, 05 Jul 2022 13:40:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.126-cip11-1-gc5218dc69ff1
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 44 runs,
 5 regressions (v5.10.126-cip11-1-gc5218dc69ff1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 20:40:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8688

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 44 runs, 5 regress=
ions (v5.10.126-cip11-1-gc5218dc69ff1)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =

jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | tegra_def=
config            | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.126-cip11-1-gc5218dc69ff1/plan/baseline-n=
fs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.126-cip11-1-gc5218dc69ff1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c5218dc69ff1f0703b893c079a21669841b479e1 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/62c4970f181f738093a39bd7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm/multi_v7_defconfig/gcc-10/=
lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm/multi_v7_defconfig/gcc-10/=
lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c4970f181f73809=
3a39bd8
        failing since 36 days (last pass: v5.10.112-cip6-289-g2969e096d186,=
 first fail: v5.10.118-465-g0af29783a3c9) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | tegra_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/62c49919efe300891ca39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm/tegra_defconfig/gcc-10/lab=
-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm/tegra_defconfig/gcc-10/lab=
-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c49919efe300891=
ca39bce
        failing since 36 days (last pass: v5.10.112-cip6-289-g2969e096d186,=
 first fail: v5.10.118-465-g0af29783a3c9) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/62c4954edc689a0fc4a39c05

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig/gcc-10/lab-bay=
libre/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig/gcc-10/lab-bay=
libre/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c4954edc689a0fc=
4a39c06
        failing since 7 days (last pass: v5.10.121-cip9-272-g3fb28d4c623b, =
first fail: v5.10.121-cip9-287-ge9094c8446fc) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c49f2fed2eb83fe3a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62c49f2fed2eb83fe=
3a39bce
        new failure (last pass: v5.10.125-cip10-119-g603acbe1aceb) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c49d1c2725c26783a39bdc

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.126-cip11-1-gc5218dc69ff1/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62c49d1c2725c26783a39bfe
        failing since 118 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-07-05T20:20:38.530667  <4>[   37.230119] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-07-05T20:20:38.539932  <4>[   37.240545] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-07-05T20:20:38.665255  /lava-6756739/1/../bin/lava-test-case
    2022-07-05T20:20:38.693765  <8>[   37.394996] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

