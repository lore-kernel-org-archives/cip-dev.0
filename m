Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4EEC25B0E
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 00:38:11 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web09.23567.1660696690314235026
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 17:38:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=7kziPODs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id
 r14-20020a17090a4dce00b001faa76931beso424084pjl.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 17:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=Cbprrr1RoNyk3bbp9SHzzHjOyaPcjMkmX52aDMmHHQI=;
        b=7kziPODsbemZRqrzMaY1boCXkchh8cPRNZXlvEKaP2Y5dqQPYrqgQYJaePB0nwrqex
         5M9mnGiYp22CFXk8cSO1IrFM+8jHO3bJUEPBWBnCt/ks4evyXn6QgZ5slejVt2JssDp3
         Z4Bt/FXI5eg7MJi6RyyNH0gbMRI3KOoaDrmt4n5EkjEranHG8Wfs0nrqTWS6/KftyENs
         gHSeIDTST4uZjwnig4F0ZmPCFNwT0ajmSqOQy7bZ445B9w0fHSAd3mHqWeBsK8cZLmPn
         X4ML+lSXYQoij8bkIxr02iYMTwCUNKZYhSmJ1ZBwHfRzp89tmuaDKj6xcosLPWBuoA63
         Vy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Cbprrr1RoNyk3bbp9SHzzHjOyaPcjMkmX52aDMmHHQI=;
        b=Y4t5VIZXReYJ6bSM+s7J/dZvnqybMgfdTJPRMmvAZ1BG4RVAdn3POB0fIINFMEcYwd
         inHYXj5duCc1FtDL1Nrlpt4UehM6WbJHgpSXgxuEJN6bJHOrYH6TmfYdMFTO72VctKGX
         FePmMXKYx4FhXYXwfzhCB2Ry8AvdUblMWxSY33GexsFdheN5qgyCr9dEIRvJY765JSIK
         7Cega2jD8juEDdh0ymtilEXgATe47kuELk7BX4G0fNMDC8a24xAI6im2eVNXHOnv+kb7
         Cbc8PpMD0rmPrOCW6zKk/Dyvz4pD60Ys0OTRmQJCcf1A1P1m4lQzRWOAos0Z2DcZbnke
         QeXg==
X-Gm-Message-State: ACgBeo31Qw5c8cw+eT6l+tPdmS32QsN+wFUMY5y/nHlZLmLA1qh2MZbM
	e9CHSWy9Ln6kfKWtQt8RvhWKqohGipcXOQa6
X-Google-Smtp-Source: 
 AA6agR5G9GHNE6mK3eVmtyxyZ2mJBaDpzV2sPhL6xZ8ebsjUEJRZ0Vs8wvMKPLwG91tzknAuft4nHw==
X-Received: by 2002:a17:902:e848:b0:16d:ccea:3259 with SMTP id
 t8-20020a170902e84800b0016dccea3259mr23834761plg.146.1660696689435;
        Tue, 16 Aug 2022 17:38:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 b12-20020a621b0c000000b005255f5d8f9fsm9046315pfb.112.2022.08.16.17.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 17:38:09 -0700 (PDT)
Message-ID: <62fc3871.620a0220.b8413.f781@mx.google.com>
Date: Tue, 16 Aug 2022 17:38:09 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-49-g1145e9c6352e6
Subject: cip/linux-5.10.y-cip baseline-nfs: 39 runs,
 6 regressions (v5.10.131-cip13-49-g1145e9c6352e6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 00:38:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9260

cip/linux-5.10.y-cip baseline-nfs: 39 runs, 6 regressions (v5.10.131-cip13-=
49-g1145e9c6352e6)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
bcm2711-rpi-4-b              | arm64 | lab-collabora | gcc-10   | defconfig=
          | 1          =

jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig | 1          =

jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | tegra_def=
config    | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
          | 1          =

meson-gxm-khadas-vim2        | arm64 | lab-baylibre  | gcc-10   | defconfig=
          | 1          =

r8a77950-salvator-x          | arm64 | lab-baylibre  | gcc-10   | defconfig=
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-49-g1145e9c6352e6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-49-g1145e9c6352e6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1145e9c6352e68c31b58d1035f4f1ff07b2f9c89 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
bcm2711-rpi-4-b              | arm64 | lab-collabora | gcc-10   | defconfig=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc28b8ee5af732ad355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
bcm2711-rpi-4-b.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-collabora/baseline-nfs-=
bcm2711-rpi-4-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fc28b8ee5af732a=
d355643
        new failure (last pass: v5.10.131-cip13-37-ge3a52725ce96) =

 =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | multi_v7_=
defconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc36e9e55810e5a1355646

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baselin=
e-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baselin=
e-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fc36e9e55810e5a=
1355647
        failing since 67 days (last pass: v5.10.106-cip4, first fail: v5.10=
.121-cip9) =

 =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
jetson-tk1                   | arm   | lab-baylibre  | gcc-10   | tegra_def=
config    | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc2f28558cb2c6d135564e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-n=
fs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-n=
fs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fc2f29558cb2c6d=
135564f
        failing since 67 days (last pass: v5.10.109-cip5, first fail: v5.10=
.121-cip9) =

 =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc28e0baf265f55b355663

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-m=
eson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-m=
eson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fc28e0baf265f55=
b355664
        failing since 21 days (last pass: v5.10.129-cip12, first fail: v5.1=
0.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
meson-gxm-khadas-vim2        | arm64 | lab-baylibre  | gcc-10   | defconfig=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc291b1156d5f1ca355663

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-m=
eson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-m=
eson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fc291b1156d5f1c=
a355664
        failing since 239 days (last pass: v5.10.8-8301-g3d6168cb89f6, firs=
t fail: v5.10.83-cip1-31-gdcbef6602957) =

 =



platform                     | arch  | lab           | compiler | defconfig=
          | regressions
-----------------------------+-------+---------------+----------+----------=
----------+------------
r8a77950-salvator-x          | arm64 | lab-baylibre  | gcc-10   | defconfig=
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc3306b30670273035566f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-r=
8a77950-salvator-x.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-r=
8a77950-salvator-x.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fc3306b30670273=
0355670
        new failure (last pass: v5.10.131-cip13-37-ge3a52725ce96) =

 =20

