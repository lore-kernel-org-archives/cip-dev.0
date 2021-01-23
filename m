Return-Path: <SRS0=5EKH=G4=lists.cip-project.org=bounce+64572+6138+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADF2C433E6
	for <cip-dev@archiver.kernel.org>; Mon, 25 Jan 2021 12:09:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A9922C9E
	for <cip-dev@archiver.kernel.org>; Mon, 25 Jan 2021 12:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A9922C9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6138+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UwNZYY4521723xVLYwncwESn; Mon, 25 Jan 2021 04:09:39 -0800
X-Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.2930.1611377876545841646
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Jan 2021 20:57:56 -0800
X-Received: by mail-pj1-f43.google.com with SMTP id md11so5093258pjb.0
        for <cip-dev@lists.cip-project.org>; Fri, 22 Jan 2021 20:57:56 -0800 (PST)
X-Gm-Message-State: du08XC0hePEVmASpXeqXLz5Ex4520388AA=
X-Google-Smtp-Source: ABdhPJzfodM+Ux2Y0ESep4M3SQvfh4xT5L48nCVcdkima/xkVDr/+nMI3zlJkusDwCRY3cvHEg+GaA==
X-Received: by 2002:a17:90a:1bc4:: with SMTP id r4mr5276967pjr.58.1611377875755;
        Fri, 22 Jan 2021 20:57:55 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x125sm6845154pfd.17.2021.01.22.20.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 20:57:55 -0800 (PST)
Message-ID: <600bacd3.1c69fb81.54759.03f2@mx.google.com>
Date: Fri, 22 Jan 2021 20:57:55 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.169-cip42
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 184 runs, 4 regressions (v4.19.169-cip42)
To: cip-dev@lists.cip-project.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="HRS7ieAV8exDAcqwC9Yt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611576579;
 bh=OazKlrQjglYtKIdXd0s9alznn9rKnZ+mcp/5PsEaloY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LGDAb9uNVXpolJow704uJB54nfUvf6cnKhwXZH49PFeVSDRIvJGtUlCssU5ou95jZNS
 64ZHaZxzilAokB/7J8LDZLKPJezJBKlGnH3agWtmA/uwpk4/WiMaB0GpSZYda+RxTqDQl
 VUcmPR8mVkIKG7OOBHoI/UmRFUa+Giz6sZg=

--HRS7ieAV8exDAcqwC9Yt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 184 runs, 4 regressions (v4.19.169-cip42)

Regressions Summary
-------------------

platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-8    | defconfig         =
  | 1          =

qemu_arm-versatilepb | arm   | lab-baylibre | gcc-8    | versatile_defconfi=
g | 1          =

qemu_arm-versatilepb | arm   | lab-broonie  | gcc-8    | versatile_defconfi=
g | 1          =

qemu_arm-versatilepb | arm   | lab-cip      | gcc-8    | versatile_defconfi=
g | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.169-cip42/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.169-cip42
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596908f7eaf05aec9ec269dd1cf23cfcbde996ee =



Test Regressions
---------------- =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
meson-gxl-s905d-p230 | arm64 | lab-baylibre | gcc-8    | defconfig         =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/600ba17bf4246330d5d3dfe5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.169=
-cip42/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905d-p230.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.169=
-cip42/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxl-s905d-p230.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/600ba17bf4246330d5d3d=
fe6
        new failure (last pass: v4.19.165-cip41) =

 =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm   | lab-baylibre | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/600b9de78b6a769e38d3e005

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.169=
-cip42/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.169=
-cip42/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/600b9de78b6a769e38d3e=
006
        failing since 70 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm   | lab-broonie  | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/600b9e339844cb18cfd3dfe0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.169=
-cip42/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-versatil=
epb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.169=
-cip42/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-versatil=
epb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/600b9e339844cb18cfd3d=
fe1
        failing since 70 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =



platform             | arch  | lab          | compiler | defconfig         =
  | regressions
---------------------+-------+--------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm   | lab-cip      | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/600b9e7e3281f3aa08d3dfc9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.169=
-cip42/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.169=
-cip42/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/600b9e7e3281f3aa08d3d=
fca
        failing since 70 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =20

--HRS7ieAV8exDAcqwC9Yt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6138): https://lists.cip-project.org/g/cip-dev/message=
/6138
Mute This Topic: https://lists.cip-project.org/mt/80101720/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--HRS7ieAV8exDAcqwC9Yt--
