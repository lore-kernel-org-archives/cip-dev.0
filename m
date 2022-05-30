X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.37464.1653921409644914052
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 30 May 2022 07:36:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cMEHlTSD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id v15so10296119pgk.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 30 May 2022 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=GYIg277zNMl7rYGmY0sUq6E09RNo/ypFd3d9+z5kF/E=;
        b=cMEHlTSD8m7s6EX93iLgrwubGVVzdLqJXfeIKHnkKSOhjRatwp4/Glx8g4hb7BN/+G
         WUHTPTbGa1JHj64u9WE/OVHU6Eh+XgMbuNYcajByg9RnK+A5oawaeYy+L4wsfOdsy96K
         mFhqGgII8u7UMdGEDUkf/+ybN4VvunAEKG+QP9NFikRk6tIshJFkV2s3eojb2606Lg9L
         9inu9Mq+g7dztLBfuvGXG9tSBVBc+L2zaZeUDMhxWeOCRoJ/nb7Et3BhBfrbLsEdWM20
         vtsHhHyve5Bl33V3MlwR41lmPYJB6c11WA/eQ/Xjsqvi76g/pzl9REP0SERAvkXszjtb
         +/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=GYIg277zNMl7rYGmY0sUq6E09RNo/ypFd3d9+z5kF/E=;
        b=h6pvQOdwT1AMUuAqfPKxX90QC8RnfGN7n7IKT4+Aq6IFF3NFtFoDFHMKA7h9kKHK8N
         opG2qvdADLVpgShfzwiHUb3svXNQdrgz3WY2Fehb+GI8cX87knVPfx9XwTem3CDdm9Fn
         metnsbL+LdIrRuaRhtHL3R1aD0+CeZiaRxD8s7NGndzKvXM+OdnSACKrjIVfYZSVB173
         lyo3ks4GJaESHIpNXxR1MAoRNfy1eQzNxXNJ7Oxf68grRGyyrPYdFoLVnK6sccEOmdhV
         NCXhpgRe7CPUD7pMv5xeQVqFI/Can+lE4lyYMEoHdcnPwfX6fOUCEFr6AWPRL1y2CvQg
         8hYw==
X-Gm-Message-State: AOAM532Av9wT6yh33RCu6etRBWaVTgmslhAtH3w3b0oZNyKT6oAImZA2
	jOv1wiSosN2dO2OG/GcwOIY9m2iGt8b4dmzxPGI=
X-Google-Smtp-Source: ABdhPJzuQdAPOHrQ/IbmrQjH1ggy7xHi/prGiqTQHQsl2ken/9PNbmEsMkCecsDQ3NJvOd6eNq4FUQ==
X-Received: by 2002:a63:2107:0:b0:3fb:ac79:50ed with SMTP id h7-20020a632107000000b003fbac7950edmr14071524pgh.105.1653921409021;
        Mon, 30 May 2022 07:36:49 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jj19-20020a170903049300b00163fbb1eec5sm445057plb.229.2022.05.30.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 07:36:48 -0700 (PDT)
Message-ID: <6294d680.1c69fb81.28472.0ea6@mx.google.com>
Date: Mon, 30 May 2022 07:36:48 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.245-cip74
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip baseline-nfs: 38 runs, 3 regressions (v4.19.245-cip74) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip baseline-nfs: 38 runs, 3 regressions (v4.19.245-cip74)

Regressions Summary
-------------------

platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
beaglebone-black | arm  | lab-cip      | gcc-10   | multi_v7_defconfig | 1 =
         =

jetson-tk1       | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =

jetson-tk1       | arm  | lab-baylibre | gcc-10   | tegra_defconfig    | 1 =
         =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.245-cip74/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.245-cip74
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0be9d6774be9b192bcea6fddada917ae3d22f22e =



Test Regressions
---------------- =



platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
beaglebone-black | arm  | lab-cip      | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6294c9000d8e59c85fa39be2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.245=
-cip74/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.245=
-cip74/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6294c9000d8e59c85=
fa39be3
        new failure (last pass: v4.19.235-cip70) =

 =



platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
jetson-tk1       | arm  | lab-baylibre | gcc-10   | multi_v7_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6294c7b06fbd188811a39bed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.245=
-cip74/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.245=
-cip74/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6294c7b06fbd18881=
1a39bee
        new failure (last pass: v4.19.235-cip70) =

 =



platform         | arch | lab          | compiler | defconfig          | re=
gressions
-----------------+------+--------------+----------+--------------------+---=
---------
jetson-tk1       | arm  | lab-baylibre | gcc-10   | tegra_defconfig    | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/6294ca31c74f426f41a39bdc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.245=
-cip74/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.245=
-cip74/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6294ca31c74f426f4=
1a39bdd
        new failure (last pass: v4.19.237-cip71) =

 =20

