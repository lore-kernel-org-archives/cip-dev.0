Return-Path: <SRS0=7yaO=KM=lists.cip-project.org=bounce+64572+6464+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CE2C433B4
	for <cip-dev@archiver.kernel.org>; Mon, 17 May 2021 07:46:56 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A330560BBB
	for <cip-dev@archiver.kernel.org>; Mon, 17 May 2021 07:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A330560BBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6464+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8Sz4YY4521723xn9dnj4jDZ1; Mon, 17 May 2021 00:46:55 -0700
X-Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web08.16097.1621237614671417115
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 17 May 2021 00:46:54 -0700
X-Received: by mail-pg1-f172.google.com with SMTP id i5so4110154pgm.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 17 May 2021 00:46:54 -0700 (PDT)
X-Gm-Message-State: 9eFFRyCyXsPA9Vdub9kMsWABx4520388AA=
X-Google-Smtp-Source: ABdhPJwFcWcQRP8jVBal3cxOI2fLNeYXE4mCpgmcBl6z1aDJeN0vAZda6DLSVnaBlKGIz5ma9tE5Kw==
X-Received: by 2002:a65:654e:: with SMTP id a14mr13879569pgw.332.1621237614053;
        Mon, 17 May 2021 00:46:54 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 205sm9304479pfc.201.2021.05.17.00.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 00:46:53 -0700 (PDT)
Message-ID: <60a21f6d.1c69fb81.57322.f4f6@mx.google.com>
Date: Mon, 17 May 2021 00:46:53 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.190-cip49
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 14 runs, 4 regressions (v4.19.190-cip49) #kernelci
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
Content-Type: multipart/mixed; boundary="WiOrSUrVwcxLp4ROwJgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1621237615;
 bh=loc4+EbcgP8br7zz+o8ee3BSptvbSxpKHRnUYvEQrSM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=FwUJXQYyX1Z3BbyaL2agPyFR+3B+E5+G4Hotc1t7hrIwX6jJldfLuiVjeHzL+4BJ7Vu
 qiwOFVrWgxcaPs0ORifbDo0tWpje/f75QZZeprW3Dhg00V0DR6ujkd8XLEhIepqGpH7O6
 igdOGGBJm/mjbklnBTJCj06iwQlfNV7Zhhs=

--WiOrSUrVwcxLp4ROwJgK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 14 runs, 4 regressions (v4.19.190-cip49)

Regressions Summary
-------------------

platform                  | arch  | lab             | compiler | defconfig =
         | regressions
--------------------------+-------+-----------------+----------+-----------=
---------+------------
dove-cubox                | arm   | lab-pengutronix | gcc-8    | multi_v7_d=
efconfig | 1          =

meson-gxm-khadas-vim2     | arm64 | lab-baylibre    | gcc-8    | defconfig =
         | 1          =

meson-gxm-q200            | arm64 | lab-baylibre    | gcc-8    | defconfig =
         | 1          =

sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre    | gcc-8    | sunxi_defc=
onfig    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.190-cip49/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.190-cip49
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      71e662f43092838cb809fac8b537b35e484310bf =



Test Regressions
---------------- =



platform                  | arch  | lab             | compiler | defconfig =
         | regressions
--------------------------+-------+-----------------+----------+-----------=
---------+------------
dove-cubox                | arm   | lab-pengutronix | gcc-8    | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60a2198a110a83a4a8b3afb6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60a2198a110a83a4a=
8b3afb7
        failing since 21 days (last pass: v4.19.186-cip47-1-g4c2cb7ba796b, =
first fail: v4.19.188-cip48) =

 =



platform                  | arch  | lab             | compiler | defconfig =
         | regressions
--------------------------+-------+-----------------+----------+-----------=
---------+------------
meson-gxm-khadas-vim2     | arm64 | lab-baylibre    | gcc-8    | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21bbf0a909bfcd4b3afa2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-khadas-vim=
2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-khadas-vim=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60a21bbf0a909bfcd=
4b3afa3
        failing since 56 days (last pass: v4.19.177-cip44, first fail: v4.1=
9.182-cip45) =

 =



platform                  | arch  | lab             | compiler | defconfig =
         | regressions
--------------------------+-------+-----------------+----------+-----------=
---------+------------
meson-gxm-q200            | arm64 | lab-baylibre    | gcc-8    | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21aa2ca5237ce4db3afa2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60a21aa2ca5237ce4=
db3afa3
        failing since 55 days (last pass: v4.19.169-cip42, first fail: v4.1=
9.182-cip45) =

 =



platform                  | arch  | lab             | compiler | defconfig =
         | regressions
--------------------------+-------+-----------------+----------+-----------=
---------+------------
sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre    | gcc-8    | sunxi_defc=
onfig    | 1          =


  Details:     https://kernelci.org/test/plan/id/60a21b6b197e83a246b3afa1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinux=
ino-lime2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.190=
-cip49/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinux=
ino-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60a21b6b197e83a24=
6b3afa2
        failing since 1 day (last pass: v4.19.183-cip46, first fail: v4.19.=
188-cip48-2-g1296cf66cc52) =

 =20

--WiOrSUrVwcxLp4ROwJgK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6464): https://lists.cip-project.org/g/cip-dev/message=
/6464
Mute This Topic: https://lists.cip-project.org/mt/82881574/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WiOrSUrVwcxLp4ROwJgK--
