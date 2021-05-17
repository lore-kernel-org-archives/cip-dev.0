Return-Path: <SRS0=eH2W=KM=lists.cip-project.org=bounce+64572+6465+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1D1C433ED
	for <cip-dev@archiver.kernel.org>; Mon, 17 May 2021 07:46:56 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D739C60249
	for <cip-dev@archiver.kernel.org>; Mon, 17 May 2021 07:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D739C60249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6465+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 75ZzYY4521723x7HfsS2t5Pk; Mon, 17 May 2021 00:46:55 -0700
X-Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.15869.1621237614904143146
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 17 May 2021 00:46:54 -0700
X-Received: by mail-pl1-f177.google.com with SMTP id v12so2646156plo.10
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 17 May 2021 00:46:54 -0700 (PDT)
X-Gm-Message-State: 1RIneok8gSjbXTVV86aVgNJ9x4520388AA=
X-Google-Smtp-Source: ABdhPJzn/vEwztwtADk/9x1ZmupwZiMZczHrv6tmQH89pbNvWTIDQBwE4F4dlIOTAFLY/NVbV46bng==
X-Received: by 2002:a17:902:e890:b029:ef:3db8:24e6 with SMTP id w16-20020a170902e890b02900ef3db824e6mr37967064plg.61.1621237614304;
        Mon, 17 May 2021 00:46:54 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id mj6sm628445pjb.8.2021.05.17.00.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 00:46:54 -0700 (PDT)
Message-ID: <60a21f6e.1c69fb81.63a7c.1682@mx.google.com>
Date: Mon, 17 May 2021 00:46:54 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.190-cip49
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 185 runs, 4 regressions (v4.19.190-cip49) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="6U8GFgBMFpvADsW2z9uS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1621237615;
 bh=tNsc/rz3A9b//sZJujEnWZvz9viiMqaL0urOmgYYRyA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=o7eOkQNaSvhIOcr/TiL0wxujv+E4HJZynVFd+/+IfXyuGITZcEEhywaCiUesrXIXErh
 cz4gVwkzjTm2unyIAYA2DDzHlJTv22Wh0qz70FEw54unEivjxm4C9HidgkvE8DXZMFfOM
 0I9KoeHwRbLbugFpo3FunnKaCeUgSY/dBEw=

--6U8GFgBMFpvADsW2z9uS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 185 runs, 4 regressions (v4.19.190-cip49)

Regressions Summary
-------------------

platform                   | arch  | lab          | compiler | defconfig   =
                 | regressions
---------------------------+-------+--------------+----------+-------------=
-----------------+------------
meson-gxl-s905x-khadas-vim | arm64 | lab-baylibre | gcc-8    | defconfig+CO=
N...BIG_ENDIAN=3Dy | 1          =

qemu_arm-versatilepb       | arm   | lab-baylibre | gcc-8    | versatile_de=
fconfig          | 1          =

qemu_arm-versatilepb       | arm   | lab-broonie  | gcc-8    | versatile_de=
fconfig          | 1          =

qemu_arm-versatilepb       | arm   | lab-cip      | gcc-8    | versatile_de=
fconfig          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.190-cip49/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.190-cip49
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      71e662f43092838cb809fac8b537b35e484310bf =



Test Regressions
---------------- =



platform                   | arch  | lab          | compiler | defconfig   =
                 | regressions
---------------------------+-------+--------------+----------+-------------=
-----------------+------------
meson-gxl-s905x-khadas-vim | arm64 | lab-baylibre | gcc-8    | defconfig+CO=
N...BIG_ENDIAN=3Dy | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21a7c68efa2ce29b3afc6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm64/defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy/gcc-8/lab-baylibre/baselin=
e-meson-gxl-s905x-khadas-vim.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm64/defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy/gcc-8/lab-baylibre/baselin=
e-meson-gxl-s905x-khadas-vim.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/arm64be/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a21a7c68efa2ce29b3a=
fc7
        new failure (last pass: v4.19.188-cip48-2-g1296cf66cc52) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
                 | regressions
---------------------------+-------+--------------+----------+-------------=
-----------------+------------
qemu_arm-versatilepb       | arm   | lab-baylibre | gcc-8    | versatile_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/60a2153bb1fc55dee9b3afb1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a2153bb1fc55dee9b3a=
fb2
        failing since 184 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
                 | regressions
---------------------------+-------+--------------+----------+-------------=
-----------------+------------
qemu_arm-versatilepb       | arm   | lab-broonie  | gcc-8    | versatile_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21557cbf1cbf7ccb3afdd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-versatil=
epb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-versatil=
epb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a21557cbf1cbf7ccb3a=
fde
        failing since 184 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform                   | arch  | lab          | compiler | defconfig   =
                 | regressions
---------------------------+-------+--------------+----------+-------------=
-----------------+------------
qemu_arm-versatilepb       | arm   | lab-cip      | gcc-8    | versatile_de=
fconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/60a215b686a552142fb3afc4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60a215b686a552142fb3a=
fc5
        failing since 184 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =20

--6U8GFgBMFpvADsW2z9uS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6465): https://lists.cip-project.org/g/cip-dev/message=
/6465
Mute This Topic: https://lists.cip-project.org/mt/82881576/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6U8GFgBMFpvADsW2z9uS--
