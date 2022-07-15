Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2839CCA47F
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 12:21:15 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web09.5814.1657887673111541068
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 15 Jul 2022 05:21:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=4XefHE41;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id
 i8-20020a17090a4b8800b001ef8a65bfbdso5908719pjh.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 15 Jul 2022 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Iutvq5BkNOY31z8cTx1n1cNIDgjpLuLK1JezEvaOCIc=;
        b=4XefHE41jnow1TuhjCYyrrxYNwXHFpZ0yecQSbwZxaBabL3gO5dpH2TDG/5wiYR8Y4
         eZYE7O9mzZ7PWCS43mmJJ764yKDOSk8PoQq4+zc07HNQyg2RZ1I9ZwnzZMST5ORZd1ib
         saHkgNtkGOwWb44g2ERrP9CwHiRwV+8++wENyiXey6f7Njh1apRZbqUaJFL5DnKzY4/j
         BV1//X3vrzVOO75PNseOy/RiEcXoiIzHUP4GCDI61uhJ9T4HktEEQvw7zL4ukXAn2rXF
         /74Pq+ojxz2sItY0RztVQucE3m8u1diX5/LS7nljoFFtFec9yZ/7w1hpCebpVJFcy0Jn
         Pduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Iutvq5BkNOY31z8cTx1n1cNIDgjpLuLK1JezEvaOCIc=;
        b=7K8LtwJL09drvBKulo9zca6y58+DA8MF3x+S8MXvyMYYy7k8g2b/lbXqMSHwwlXoJg
         pGTbetrNu/p0yVT7heq7YopBgqpvw9WMw2z7DNzJ7/uy2WKAKIPaoZ0xuA1IzLC9EoPA
         iewq287Tf3KjdNNAduHKuwYC6Oqhea69YEgP3n3A94gmar65+Jzqezt9VvClEGFQKTki
         1nmrJu/DCiiBwLwR5w2ealxkVrYBhiuY4IObyyDRlcmUIlZcyzB0GSNqXHXr7M4gFw9v
         uLK111P6jPlerqd2mHVkRPjuyUTX2c6kxKQhBR1mDAmh7G415pTHQ81rQ24/Oug+nkuk
         FZng==
X-Gm-Message-State: AJIora87f9FhqV6J2o3bXVt7Kx5p4+UERbnMcSXXKiVFikoK5ihcto4J
	pE2iEkxBEyYpz10jkXDyRFwJdHrRmSFTNcB3
X-Google-Smtp-Source: 
 AGRyM1sgybqT9UYBjdQ3Hyk3QzDGfwRoqpaupVTW2eN1c/icWJG7x7MnjWBDMpSrI8hmfObCNeqEjg==
X-Received: by 2002:a17:902:cf06:b0:16b:cc33:5bce with SMTP id
 i6-20020a170902cf0600b0016bcc335bcemr13541736plg.152.1657887672338;
        Fri, 15 Jul 2022 05:21:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 w22-20020a1709026f1600b0016a581f9ac2sm3347530plk.234.2022.07.15.05.21.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 05:21:12 -0700 (PDT)
Message-ID: <62d15bb8.1c69fb81.49622.507a@mx.google.com>
Date: Fri, 15 Jul 2022 05:21:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-59-ge5b19636ca9c4
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 29 runs,
 4 regressions (v5.10.129-cip12-59-ge5b19636ca9c4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 12:21:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8829

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 29 runs, 4 regress=
ions (v5.10.129-cip12-59-ge5b19636ca9c4)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
jetson-tk1                   | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =

jetson-tk1                   | arm   | lab-baylibre | gcc-10   | tegra_defc=
onfig    | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie  | gcc-10   | defconfig =
         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-59-ge5b19636ca9c4/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-59-ge5b19636ca9c4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e5b19636ca9c43e262a365d756d491479adb3884 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
jetson-tk1                   | arm   | lab-baylibre | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62d150f28576ff3528a39c17

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm/multi_v7_defconfig/gcc-1=
0/lab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220708.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62d150f28576ff352=
8a39c18
        failing since 45 days (last pass: v5.10.112-cip6-289-g2969e096d186,=
 first fail: v5.10.118-465-g0af29783a3c9) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
jetson-tk1                   | arm   | lab-baylibre | gcc-10   | tegra_defc=
onfig    | 1          =


  Details:     https://kernelci.org/test/plan/id/62d14f8a840fa33995a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm/tegra_defconfig/gcc-10/l=
ab-baylibre/baseline-nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220708.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62d14f8a840fa3399=
5a39bce
        failing since 45 days (last pass: v5.10.112-cip6-289-g2969e096d186,=
 first fail: v5.10.118-465-g0af29783a3c9) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62d154080e15c7f588a39bdd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
aylibre/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220708.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62d154080e15c7f58=
8a39bde
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie  | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62d1529a5ab888b902a39bf8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-59-ge5b19636ca9c4/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220708.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62d1529a5ab888b90=
2a39bf9
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =20

