Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0627EB64DB
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 12:26:50 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.16803.1686832002866568689
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 05:26:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=eyy87r9D;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-66643830ab3so1769021b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686832002; x=1689424002;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pd29V3PQhYiqZ5obXcNyUjTnyW+/BM0A6gsj2x9E9wo=;
        b=eyy87r9DocvOJo0u9N0bIeXRHuqMueyNkdqC8/mIiNLAoDbrEJBQfSq5F2BZd6cMAA
         3SlSkawa8LK/grknIykIJ7QrEXGQilIj55Ry0eMpiGyWKiPHlgfyXpK8s03ZYXwuhKP+
         Cze+JTo+W+FXumrDGVKKLhPg/n614EJFSJd7UQIt0vIfXNLA8iecTRQr+BwAZ+Ms6cDD
         dOngprvoUrlCEX3jPQt8S6H94H7GX54Bbr+umIMFhlSX9fml+NvKPOBuuvIPU1nB6+7b
         wLTo730QhQ51DcV/3npKlMYIbYNYiVPm1aNXG2AUGAmRFDqBVJzxxC+O3n9S2Nf7UxkT
         EIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686832002; x=1689424002;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pd29V3PQhYiqZ5obXcNyUjTnyW+/BM0A6gsj2x9E9wo=;
        b=jhrCiUgdInodT9AO1a/zEb+o1vXpclLkWMqEwRiTCbKIR+79/kiVlW5mZEk4SGqKcN
         wTw+aCGn5AM45Ioa0c6Bg7f5CD5HSXEtxl6IvkvfhJ9SHB6ty2fmWlLRIpk+M6RGgDgg
         IGoPXR3iPfwQ1/oMgt67N8RR2H09A0pP/Pj16LCezwmZpc1mYH0qz94ZYr4unY8kBiF1
         4IeROaB1VYUbuecBJ2LgUJt44SJOqXl055k4gSJ1XSisypoGrOLY/RyqG6wYBYDopqVr
         GvGWtotCEyFv952gdj29suHdFm8/JpAlKIIyXr77rha7492+zIso+SzXHwzpP71iFa4n
         fYQA==
X-Gm-Message-State: AC+VfDyAfVoRlMRrvixtnXFcQLemxrYCpLgfmRdabMNdvXqN33c32u6x
	GbduQYNnv+MjWJ9LLcyMWXaCJdn8j+9MeRch+kYdVQ==
X-Google-Smtp-Source: ACHHUZ5hg1qjBSm6J4OSdz2FjGLqNA8M5n6yJhS0+raxp2MmHtgQXAaLAhlvAoIXIvl67BDCTeXDZw==
X-Received: by 2002:a05:6a20:3d2a:b0:10f:195f:6556 with SMTP id y42-20020a056a203d2a00b0010f195f6556mr5510263pzi.31.1686832001641;
        Thu, 15 Jun 2023 05:26:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id iw21-20020a170903045500b001b3fb909f73sm3721796plb.112.2023.06.15.05.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 05:26:40 -0700 (PDT)
Message-ID: <648b0380.170a0220.aacac.81c7@mx.google.com>
Date: Thu, 15 Jun 2023 05:26:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.31-53-g486caac40d06
Subject: cip/linux-6.1.y-cip baseline-nfs: 48 runs,
 4 regressions (v6.1.31-53-g486caac40d06)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 12:26:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12058

cip/linux-6.1.y-cip baseline-nfs: 48 runs, 4 regressions (v6.1.31-53-g486ca=
ac40d06)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | omap2plus_d=
efconfig        | 1          =

imx6dl-udoo                  | arm   | lab-broonie | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =

imx6q-udoo                   | arm   | lab-broonie | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.31-53-g486caac40d06/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.31-53-g486caac40d06
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      486caac40d06a2c987e5514b550d341cf6791b17 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
beaglebone-black             | arm   | lab-broonie | gcc-10   | omap2plus_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/648af74871bc3406cf30619d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648af74871bc3406c=
f30619e
        failing since 8 days (last pass: v6.1.26-1314-g1ab0ac1d7e2e3, first=
 fail: v6.1.26-1320-gc38e4a9845945) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
imx6dl-udoo                  | arm   | lab-broonie | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/648afcc5043b924a92306263

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6=
dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6=
dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648afcc5043b924a9=
2306264
        failing since 0 day (last pass: v6.1.31-45-gce658d9231044, first fa=
il: v6.1.31-46-g4cc1cc26e90f) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
imx6q-udoo                   | arm   | lab-broonie | gcc-10   | imx_v6_v7_d=
efconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/648afd51d9a6056f33306147

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6=
q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs-imx6=
q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648afd51d9a6056f3=
3306148
        failing since 5 days (last pass: v6.1.26-1320-gc38e4a9845945, first=
 fail: v6.1.31-45-gce658d9231044) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/648afa2d6253cb291b306157

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline=
-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.31-53=
-g486caac40d06/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/baseline=
-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/648afa2d6253cb291=
b306158
        new failure (last pass: v6.1.31-46-g4cc1cc26e90f) =

 =20

