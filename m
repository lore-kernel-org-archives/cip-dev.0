Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021CFECAAD4
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 18:21:48 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.2418.1661970097789990807
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 11:21:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=hgIgpr+w;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id l5so11029652pjy.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=RjzweiAzfEhsvHZ5T9oR/dKnJ+7Am2gMYQ4zslCWBYY=;
        b=hgIgpr+wDsphAPfNGT7fHdVACmu5yLKp609g879K3FoOe/BcYiZsuVLdVn3I7ymHPZ
         SXluhuGm1voqOh8QhmKzZeNHiImCCRSumJebJgX+TbptGKF8xscS85bQ7W35Pv3mkhXU
         /UeFjJ+I8jqL0+irflNxcQpnAD0XYgMUxxYOqYduRxZERWZzdnSdvdLPaq4ZDw3r6Bio
         YE1aEgfDXatXVYRFUB6dxMfJaPDwihYEzCHwb1t9LSYct8MFl59qpybcToc7eRosPuNw
         SHRT55597IWIWXoZ8Cr0PtkusaCtjE0qQ8QRbFATfggslgFBmnGDtrOpOAZ65XKDkIBO
         2W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=RjzweiAzfEhsvHZ5T9oR/dKnJ+7Am2gMYQ4zslCWBYY=;
        b=beciHHz8fnIn61Dm6KSJzVmk3sRcQQYmbg5MPzUWuK01x7It6XvO2L3ddaFfxYNWUA
         91JdzK67mPElPGGqh7JLYtrbj0GZtq146LQ6WaX+pCG5JeKQeyBxGAwiKLcnj9Dy/QK1
         o476Ba+D26NFZQUBkpCC0FP48RaEhz4MUu0m93MBjZDFxeYq0JTyU7Jf62yCuo1mXrfT
         SYZfiMm0whEmRMQtXlqYOgvKWb5yWKi/1n4HjWpDqqj+AxflimXIzCfREuWDj41akHkw
         lkPE+NNBN2I7wQc8HOP5iHdHBdcUDHH9XR/tqVEwwmZNX19BMYNb9lRzt7YD5RloFQp/
         yMlw==
X-Gm-Message-State: ACgBeo0A7pBk1xhCuW5KgSKddIfvYKoQEDZAyZUCf/tq4jSSaM7xWUzA
	k6wEX9zXnukIpXmkTp27WdThh6FHUgmAR5kqGB0=
X-Google-Smtp-Source: 
 AA6agR5/jB0IizAxVo9/45P/N+UgU7MvOvl6mLWnWSiV/WlbVJSH8wsXugPH5Y/n61m5ghw7PJQK2A==
X-Received: by 2002:a17:90a:be15:b0:1fe:1cb1:1f7 with SMTP id
 a21-20020a17090abe1500b001fe1cb101f7mr4500895pjs.162.1661970096898;
        Wed, 31 Aug 2022 11:21:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 c18-20020a170903235200b0016909be39e5sm2721253plh.177.2022.08.31.11.21.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 11:21:36 -0700 (PDT)
Message-ID: <630fa6b0.170a0220.025c.5c59@mx.google.com>
Date: Wed, 31 Aug 2022 11:21:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15-90-gd4130d0ee3c7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 22 runs,
 3 regressions (v5.10.138-cip15-90-gd4130d0ee3c7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 18:21:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9389

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 22 runs, 3 regress=
ions (v5.10.138-cip15-90-gd4130d0ee3c7)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

meson-gxm-khadas-vim2        | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.138-cip15-90-gd4130d0ee3c7/plan/baseline-=
nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.138-cip15-90-gd4130d0ee3c7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      d4130d0ee3c72fc50c48ae861863e85537802c47 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/630fa43287917f19d8355667

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/630fa43287917f19d=
8355668
        new failure (last pass: v5.10.136-cip14-542-g97767707d3d0) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxm-khadas-vim2        | arm64 | lab-baylibre  | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/630f9f95be57e3b46b355644

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/arm64/defconfig/gcc-10/lab-ba=
ylibre/baseline-nfs-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/630f9f95be57e3b46=
b355645
        failing since 27 days (last pass: v5.10.100-cip2-484-gede5006fb276,=
 first fail: v5.10.131-cip13-431-g420b8f43ddc46) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/630f9ef2781784d59b355680

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.138-cip15-90-gd4130d0ee3c7/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220826.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/630f9ef2781784d59b3556a6
        failing since 175 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-08-31T17:48:28.024305  <4>[   37.732869] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-08-31T17:48:28.034084  <4>[   37.743300] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-08-31T17:48:28.620531  /lava-7153180/1/../bin/lava-test-case
    2022-08-31T17:48:28.653413  <8>[   38.362511] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

