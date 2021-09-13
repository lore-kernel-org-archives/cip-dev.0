Return-Path: <SRS0=Jrg2=OD=lists.cip-project.org=bounce+64572+6731+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644FDC433F5
	for <cip-dev@archiver.kernel.org>; Mon, 13 Sep 2021 01:25:23 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCD316108C
	for <cip-dev@archiver.kernel.org>; Mon, 13 Sep 2021 01:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DCD316108C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nsbrYY4521723xsm4MKOTRou; Sun, 12 Sep 2021 18:25:22 -0700
X-Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web09.23532.1631496322021957809
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 12 Sep 2021 18:25:22 -0700
X-Received: by mail-pg1-f177.google.com with SMTP id u18so7938880pgf.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 12 Sep 2021 18:25:21 -0700 (PDT)
X-Gm-Message-State: E6IqpXq29EF09LObnSIWFbEvx4520388AA=
X-Google-Smtp-Source: ABdhPJya1dsdGXKkI3i/Vv0ofkFlnlBwI3NGsOCItpMYH2QOhq8zElm9jL7cGsUiVte4ptcVzOEE9Q==
X-Received: by 2002:a05:6a00:1742:b0:438:b04b:4b57 with SMTP id j2-20020a056a00174200b00438b04b4b57mr8748080pfc.47.1631496321164;
        Sun, 12 Sep 2021 18:25:21 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a7sm4655399pja.21.2021.09.12.18.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 18:25:20 -0700 (PDT)
Message-ID: <613ea880.1c69fb81.f81f1.ce2f@mx.google.com>
Date: Sun, 12 Sep 2021 18:25:20 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.206-cip57
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 43 runs, 3 regressions (v4.19.206-cip57) #kernelci
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
Content-Type: multipart/mixed; boundary="jwO7CxkukuVEraYegs7Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631496322;
 bh=p1/mOz7vmDgmQMwwMrx4IuVFu0PbNgDHE+F0Y9lbahc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=MdCTCwbKfqGHp3REqn9dF1rWyfcxL1Y1d/sFMmjjWXo8QW0gZlDBxmdKr7Cv689jXmW
 Dw+5ATaKoDjbQjNDeBinruT1GlKDDmKIrw5ickMLZ9wReR0rQZ63EzZJYMm+oZyn8oxEZ
 TJKDrQ950j9G4Wa6MUzCptKUEKIspGOWlYE=

--jwO7CxkukuVEraYegs7Z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 43 runs, 3 regressions (v4.19.206-cip57)

Regressions Summary
-------------------

platform                  | arch  | lab           | compiler | defconfig   =
           | regressions
--------------------------+-------+---------------+----------+-------------=
-----------+------------
meson-gxm-khadas-vim2     | arm64 | lab-baylibre  | gcc-8    | defconfig   =
           | 1          =

odroid-xu3                | arm   | lab-collabora | gcc-8    | multi_v7_def=
config+ima | 1          =

sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre  | gcc-8    | sunxi_defcon=
fig        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.206-cip57/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.206-cip57
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      425e38cc5d37221e1e058adba114721516ac16d1 =



Test Regressions
---------------- =



platform                  | arch  | lab           | compiler | defconfig   =
           | regressions
--------------------------+-------+---------------+----------+-------------=
-----------+------------
meson-gxm-khadas-vim2     | arm64 | lab-baylibre  | gcc-8    | defconfig   =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/613ea41d7bfa20b5d0d59682

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.206=
-cip57/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-khadas-vim=
2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.206=
-cip57/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-khadas-vim=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0827.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/613ea41d7bfa20b5d=
0d59683
        new failure (last pass: v4.19.205-cip56) =

 =



platform                  | arch  | lab           | compiler | defconfig   =
           | regressions
--------------------------+-------+---------------+----------+-------------=
-----------+------------
odroid-xu3                | arm   | lab-collabora | gcc-8    | multi_v7_def=
config+ima | 1          =


  Details:     https://kernelci.org/test/plan/id/613ea579186495b91bd59720

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+ima
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.206=
-cip57/arm/multi_v7_defconfig+ima/gcc-8/lab-collabora/baseline-nfs-odroid-x=
u3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.206=
-cip57/arm/multi_v7_defconfig+ima/gcc-8/lab-collabora/baseline-nfs-odroid-x=
u3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0827.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/613ea579186495b91=
bd59721
        failing since 25 days (last pass: v4.19.198-cip54, first fail: v4.1=
9.204-cip55) =

 =



platform                  | arch  | lab           | compiler | defconfig   =
           | regressions
--------------------------+-------+---------------+----------+-------------=
-----------+------------
sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre  | gcc-8    | sunxi_defcon=
fig        | 1          =


  Details:     https://kernelci.org/test/plan/id/613ea22c04e919fc78d5968a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.206=
-cip57/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinux=
ino-lime2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.206=
-cip57/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinux=
ino-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0827.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/613ea22c04e919fc7=
8d5968b
        failing since 120 days (last pass: v4.19.183-cip46, first fail: v4.=
19.188-cip48-2-g1296cf66cc52) =

 =20

--jwO7CxkukuVEraYegs7Z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6731): https://lists.cip-project.org/g/cip-dev/message/=
6731
Mute This Topic: https://lists.cip-project.org/mt/85565407/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--jwO7CxkukuVEraYegs7Z--
