Return-Path: <SRS0=/U0T=GK=lists.cip-project.org=bounce+64572+6050+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B821C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  7 Jan 2021 01:12:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFBD12311E
	for <cip-dev@archiver.kernel.org>; Thu,  7 Jan 2021 01:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBD12311E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6050+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id CgptYY4521723xqcceCixz1S; Wed, 06 Jan 2021 17:12:21 -0800
X-Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web08.2139.1609981882744886841
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jan 2021 17:11:22 -0800
X-Received: by mail-pl1-f181.google.com with SMTP id be12so2520833plb.4
        for <cip-dev@lists.cip-project.org>; Wed, 06 Jan 2021 17:11:22 -0800 (PST)
X-Gm-Message-State: XKQzIGIxmJEhPWnKXVCQg9rDx4520388AA=
X-Google-Smtp-Source: ABdhPJy5NgJ67W4oqaP9gdetUaLvZPYfbkMi5dJefZDxLFksAllvT1FTr4NOO7IoRxE8tA5hJBL+zw==
X-Received: by 2002:a17:90a:eacf:: with SMTP id ev15mr7029663pjb.174.1609981881732;
        Wed, 06 Jan 2021 17:11:21 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h16sm4174155pgd.62.2021.01.06.17.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 17:11:21 -0800 (PST)
Message-ID: <5ff65fb9.1c69fb81.3d5de.aa27@mx.google.com>
Date: Wed, 06 Jan 2021 17:11:21 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.163-cip40-34-g2f3a6d08a3bd
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 264 runs, 7 regressions (v4.19.163-cip40-34-g2f3a6d08a3bd)
To: cip-dev@lists.cip-project.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="D010tAMl784bYNKmY400"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609981941;
 bh=omzEPexeO9j29csfaV9Oo7UHIKowl627nQXTZNJp7Os=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=DTLKQF7TKJirsDIWgviZBN4GXpe+BthRsd/w8ZYOA51qJFEtokMrrMwPDKUIflgjp99
 7XjkrzmGTwrh29ApuP08gflsfch+q4EvUI5MHBdvNSbX06ts12bsQQzCs3e0o9LIr6U79
 wEiRIyGOb3U14APwxt2eJXANYvzwpZZ6iz4=

--D010tAMl784bYNKmY400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 264 runs, 7 regressions (v4.19.163-cip40-34-=
g2f3a6d08a3bd)

Regressions Summary
-------------------

platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
meson-gxl-s905x-khadas-vim | arm64  | lab-baylibre  | gcc-8    | defconfig =
                   | 1          =

panda                      | arm    | lab-collabora | gcc-8    | omap2plus_=
defconfig          | 1          =

qemu_arm-versatilepb       | arm    | lab-baylibre  | gcc-8    | versatile_=
defconfig          | 1          =

qemu_arm-versatilepb       | arm    | lab-broonie   | gcc-8    | versatile_=
defconfig          | 1          =

qemu_arm-versatilepb       | arm    | lab-cip       | gcc-8    | versatile_=
defconfig          | 1          =

qemu_arm-versatilepb       | arm    | lab-collabora | gcc-8    | versatile_=
defconfig          | 1          =

qemu_x86_64                | x86_64 | lab-baylibre  | gcc-8    | x86_64_def=
con...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.163-cip40-34-g2f3a6d08a3bd/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.163-cip40-34-g2f3a6d08a3bd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2f3a6d08a3bdbf69ef164a95911e32e37b89c0d2 =



Test Regressions
---------------- =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
meson-gxl-s905x-khadas-vim | arm64  | lab-baylibre  | gcc-8    | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff655a5478173e267c94cc3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-g=
xl-s905x-khadas-vim.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-g=
xl-s905x-khadas-vim.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff655a5478173e267c94=
cc4
        new failure (last pass: v4.19.163-cip40-5-g95fea62f9f453) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
panda                      | arm    | lab-collabora | gcc-8    | omap2plus_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff6567e60643d5910c94cba

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm/omap2plus_defconfig/gcc-8/lab-collabora/baselin=
e-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm/omap2plus_defconfig/gcc-8/lab-collabora/baselin=
e-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/5ff6567e60643d5=
910c94cbf
        failing since 40 days (last pass: v4.19.160-cip39, first fail: v4.1=
9.160-cip39-1-g00b5977d73363)
        2 lines

    2021-01-07 00:31:51.905000+00:00  kern  :emerg :  lock: emif_lock+0x0/0=
xffffed34 [emif], .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1   =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-versatilepb       | arm    | lab-baylibre  | gcc-8    | versatile_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff654d10fa6bc33d8c94cf2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline=
-qemu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline=
-qemu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff654d10fa6bc33d8c94=
cf3
        failing since 53 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-versatilepb       | arm    | lab-broonie   | gcc-8    | versatile_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff654c5763c2728b7c94d0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-=
qemu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-=
qemu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff654c5763c2728b7c94=
d0c
        failing since 53 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-versatilepb       | arm    | lab-cip       | gcc-8    | versatile_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff654c4763c2728b7c94d08

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu=
_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu=
_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff654c4763c2728b7c94=
d09
        failing since 53 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_arm-versatilepb       | arm    | lab-collabora | gcc-8    | versatile_=
defconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff6547ee19dcd9f2fc94cd8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm/versatile_defconfig/gcc-8/lab-collabora/baselin=
e-qemu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/arm/versatile_defconfig/gcc-8/lab-collabora/baselin=
e-qemu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff6547ee19dcd9f2fc94=
cd9
        failing since 53 days (last pass: v4.19.152-cip37-37-g18852869b06b,=
 first fail: v4.19.157-cip38) =

 =



platform                   | arch   | lab           | compiler | defconfig =
                   | regressions
---------------------------+--------+---------------+----------+-----------=
-------------------+------------
qemu_x86_64                | x86_64 | lab-baylibre  | gcc-8    | x86_64_def=
con...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/5ff6558a489ffb8213c94d29

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-8 (gcc (Debian 8.3.0-6) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-8/lab-ba=
ylibre/baseline-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.163=
-cip40-34-g2f3a6d08a3bd/x86_64/x86_64_defconfig+x86-chromebook/gcc-8/lab-ba=
ylibre/baseline-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/x86/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5ff6558a489ffb8213c94=
d2a
        new failure (last pass: v4.19.163-cip40-5-g95fea62f9f453) =

 =20

--D010tAMl784bYNKmY400
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6050): https://lists.cip-project.org/g/cip-dev/message=
/6050
Mute This Topic: https://lists.cip-project.org/mt/79489621/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--D010tAMl784bYNKmY400--
