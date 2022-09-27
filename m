Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75F5C07E9D
	for <webhook@archiver.kernel.org>; Tue, 27 Sep 2022 09:09:42 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web09.8693.1664269773466359071
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 02:09:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=PnazvEQf;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 78so8816745pgb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 27 Sep 2022 02:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=55xIgafzm/YiqA8+XvdzJeiICdqLUwTiR1n5CVqTrh8=;
        b=PnazvEQfLVbE6nAqhf2zLCbTJtQ1vrlDQz13fHx4g8x5rKwRcJ9ELpOBOPNH+ppMVV
         6ramv8ob3aXlHWHTyQ1YHCRMpfETUrqu3DzrEWM3b42IJs90C/RN7Z6rMQ6mp0zrlNo7
         dzaM1vy9jJ6B4Z0+G5+wPGcxMEwed6r7cFUjDOjg/9h+ejskWtCgjGgL9phs3N0MEsjH
         gQf3EIlnfvLOoE6bvpvUDpsE3zZESs3TWnQcxl6xW45nFxu8IsTpMl6WFkmEYy71TAAy
         XUbAumGKlVASE750XxxuMs0X9qxDeM4PWCP/WZArQnLDZi5fDHUJDEtrdMp3bErc8HuZ
         Dnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=55xIgafzm/YiqA8+XvdzJeiICdqLUwTiR1n5CVqTrh8=;
        b=6/jj6Pq6Wsp5+3TeP58rBsLUmr9exK1DYqExFJS0Mn/LF15AlNpTc4G/p0mN9Q3vkb
         ORgu/k/MRWwT1I1iIFTjHfIJzQJRY3a4cMSene+gCc7i2pCeW79zdtc+uGOomorzWbsQ
         P5+KPHVra1nMXIsmkG74ubWDJ0nezHnujY2U6L1QOZgCEFMO4oalIzW3simjc0B8K/yl
         zCuVdJ/yCHX5TtG+LQdt6OWbgeAt+837drS1xdMJqscFbhaxhNKHbgEBPgHWRlvNxora
         lgjN8s4VOCqLMAP2FVkKThrYhVAe8LzzfxxtwEkxjwE62Qti6689505/yp6PfAw2TDak
         folw==
X-Gm-Message-State: ACrzQf087SkjGtg3h+zW4U2JV8wQw1EuusO9goSzaqUXhzFzbbeMB5lG
	uchDOmIYjjt5HjvyKGRoWmwY3PY1N7GjBDKt
X-Google-Smtp-Source: 
 AMsMyM6zU+URaO6BJgZgAzdo8DU/k0TgQ4LC4RnIvlQWk9n0TQYn3ix1wez1CfamFpWW0+GTJ1MVvg==
X-Received: by 2002:a63:1a4c:0:b0:43b:e648:a7a4 with SMTP id
 a12-20020a631a4c000000b0043be648a7a4mr23883132pgm.7.1664269772462;
        Tue, 27 Sep 2022 02:09:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 x3-20020a628603000000b00528a097aeffsm1143357pfd.118.2022.09.27.02.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 02:09:32 -0700 (PDT)
Message-ID: <6332bdcc.620a0220.12f3f.1bbe@mx.google.com>
Date: Tue, 27 Sep 2022 02:09:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-cip17
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline-nfs: 34 runs,
 4 regressions (v5.10.145-cip17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Sep 2022 09:09:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9548

cip/linux-5.10.y-cip baseline-nfs: 34 runs, 4 regressions (v5.10.145-cip17)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | tegra_def=
config            | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

meson-gxm-khadas-vim2        | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93a53e86925ce8c2e0608e173e2c7b952ee61cdd =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | tegra_def=
config            | 1          =


  Details:     https://kernelci.org/test/plan/id/6332b2ee57353b26bdec4ea6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6332b2ee57353b26b=
dec4ea7
        new failure (last pass: v5.10.138-cip15) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6332b447f34b7de480ec4eab

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libr=
etech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libr=
etech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6332b447f34b7de48=
0ec4eac
        new failure (last pass: v5.10.138-cip15) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxm-khadas-vim2        | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/6332b14dfe7b7f1ce1ec4f13

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6332b14dfe7b7f1ce=
1ec4f14
        failing since 280 days (last pass: v5.10.8-8301-g3d6168cb89f6, firs=
t fail: v5.10.83-cip1-31-gdcbef6602957) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6332bbc31bdf78d966ec4eba

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220923.1/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/6332bbc31bdf78d966ec4ee0
        failing since 181 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-09-27T09:00:30.798665  [   37.596998] cdn-dp fec00000.dp: Direct f=
irmware load for rockchip/dptx.bin failed with error -2
    2022-09-27T09:00:30.807550  [   37.607024] cdn-dp fec00000.dp: Falling =
back to sysfs fallback for: rockchip/dptx.bin
    2022-09-27T09:00:31.482140  /lava-7419192/1/../bin/lava-test-case   =

 =20

