Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F5C4332F
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 19:50:25 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.25027.1670788216582580133
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 11 Dec 2022 11:50:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=4XM1ak3d;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id g10so9966512plo.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 11 Dec 2022 11:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dulok9/1N2hn6RJaaV7J/m3l5shVUN0uB1dOZJcatp4=;
        b=4XM1ak3dhllAzY6X/mH/bf/fkS42c6vyQkENjzQHDCfs/PzV4P0YAlMFXh2fJqVPKj
         UugKrkCdPyQRxrwJ/gunISQwI4GzEuzZtJ90CKHzgBjWXynvJdTlHD+jB41Xcbcq1C+Z
         kV3LEIqFfClaMGAUsX4SKD4TZlQKJ47T4U2WbFQ6yYa+l2UbxPno8maB0EWFIF3wVMFZ
         b8A71S/bgxhnLH3pcQ9qEQuQMQa7zuFrkhkeZP77qqygnxQ4NjV/2RUeClNDKMlG1dBy
         D97uTBqUSKojxm1vPeuCp08DA/WfmMuDJUXGPMGrOPZZXFHwraWc3awb0qvUXmyRLefs
         p3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dulok9/1N2hn6RJaaV7J/m3l5shVUN0uB1dOZJcatp4=;
        b=ungcpfOxiysbdO9sUhKlontPO5P9eneQwcU1WCaXr6UbAlkEHQRQhLoYTvoxFKjN/K
         CdTA9WpUt3LHXXUFQ4ej6jUZRldz034s+0AcwTA0v7J+UZY+nt6tV3NI+TWABCzXdQ6F
         HSkDLhRlMgJPCiHNyBIYJ+oJqessllPZz9ZGC7056t7qktvvatjCWCnunx/+uvUMkzQ+
         mSZ0YTwzMISFCHVxisOruRDC0ORh8N2gNQrzcPBsRwGfmVxFI5EojYRN0nJ5MvTSMmH3
         L6lzagai4KgZbrFkBFFIduymzTgjJx0qWWAwAyEHqzA9B7uIxgaF7HukCb1+rkY1nNl1
         TUSg==
X-Gm-Message-State: ANoB5pkW5silMynyiYlpzNOfS3asBmvEXx612ICfLauKkbZpQmTgKGA/
	AAiV8tUDewMb0z2UokEU+jS8zaG/pz1JU7lP9sA=
X-Google-Smtp-Source: AA0mqf5z/kc+Xy1428G0fgDjtREExUjBH+1fz3P8PRd9tqfvLLxn2VQmsgaVfU/kvizQxqU5EM+E3g==
X-Received: by 2002:a17:902:820b:b0:189:66dc:41c9 with SMTP id x11-20020a170902820b00b0018966dc41c9mr12253646pln.57.1670788215392;
        Sun, 11 Dec 2022 11:50:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902e8c300b00176dc67df44sm4678897plg.132.2022.12.11.11.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 11:50:14 -0800 (PST)
Message-ID: <63963476.170a0220.2a25c.7cc8@mx.google.com>
Date: Sun, 11 Dec 2022 11:50:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.158-cip22-rt9
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip-rt baseline-nfs: 76 runs,
 3 regressions (v5.10.158-cip22-rt9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 11 Dec 2022 19:50:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10204

cip/linux-5.10.y-cip-rt baseline-nfs: 76 runs, 3 regressions (v5.10.158-cip=
22-rt9)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
           | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------+------------
jetson-tk1                   | arm   | lab-baylibre | gcc-10   | defconfig =
           | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
preempt_rt | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie  | gcc-10   | defconfig =
           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.158-cip22-rt9/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.158-cip22-rt9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2c52868ae1cbccd8bfb24f6b41a5fd024c1ca7e8 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
           | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------+------------
jetson-tk1                   | arm   | lab-baylibre | gcc-10   | defconfig =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/63962be967b5e57b8a2abd10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm/defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm/defconfig/gcc-10/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221202.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63962be967b5e57b8=
a2abd11
        new failure (last pass: v5.10.153-cip19-rt8) =

 =



platform                     | arch  | lab          | compiler | defconfig =
           | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig+=
preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63962a3423c5797aae2abd1d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm64/defconfig+preempt_rt/gcc-10/lab-baylibre/baseline-nfs-m=
eson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm64/defconfig+preempt_rt/gcc-10/lab-baylibre/baseline-nfs-m=
eson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221202.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63962a3423c5797aa=
e2abd1e
        new failure (last pass: v5.10.153-cip19-rt8) =

 =



platform                     | arch  | lab          | compiler | defconfig =
           | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie  | gcc-10   | defconfig =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/639627fca55f13e1b32abcfd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s90=
5x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
158-cip22-rt9/arm64/defconfig/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s90=
5x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221202.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/639627fca55f13e1b=
32abcfe
        new failure (last pass: v5.10.145-cip17-rt7) =

 =20

