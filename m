Return-Path: <SRS0=RDy7=HR=lists.cip-project.org=bounce+64572+6178+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C516C433E6
	for <cip-dev@archiver.kernel.org>; Mon, 15 Feb 2021 10:30:53 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973A564DFF
	for <cip-dev@archiver.kernel.org>; Mon, 15 Feb 2021 10:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973A564DFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6178+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ctpiYY4521723xQcTKd4s8oE; Mon, 15 Feb 2021 02:30:50 -0800
X-Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.29534.1613385050285363327
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 15 Feb 2021 02:30:50 -0800
X-Received: by mail-pg1-f173.google.com with SMTP id b21so3965942pgk.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 15 Feb 2021 02:30:50 -0800 (PST)
X-Gm-Message-State: pmUHH9bQiQ4Ab4AmaQmDQb7tx4520388AA=
X-Google-Smtp-Source: ABdhPJxeoeE90iH8PcoCqry/td7hXqHQRjtpib/mn+aLKeeYuzOhTvKlw1BH2UlHTgpnUr8Jqx9PQg==
X-Received: by 2002:a62:528c:0:b029:19e:4a39:d9ea with SMTP id g134-20020a62528c0000b029019e4a39d9eamr15034943pfb.20.1613385049406;
        Mon, 15 Feb 2021 02:30:49 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 17sm17780168pgy.53.2021.02.15.02.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 02:30:49 -0800 (PST)
Message-ID: <602a4d59.1c69fb81.66db0.5b3e@mx.google.com>
Date: Mon, 15 Feb 2021 02:30:49 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.175-cip43
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 117 runs, 3 regressions (v4.19.175-cip43) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="WJQsCZfX31KDxg8UnCzb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613385050;
 bh=rnu3tvAEkmfhbvaZ4Zhuio9+6z678cNxP2ilDQ5w8Y4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Za7LW60Mc3YuTJwyfQcJ8qJMStLnTk1FAUuAi58S+DoOHkM1UFcpm4Csf4tVOOhYeqI
 Yan1oZP5r5P6O859xW7shtYrU1ExpRdQDksmBbm/WB6uFEicqNh/GVw/XCVMTl6NhLiAE
 X8XHCfZzqAxrnN1/QAwnUd2AVBTYtbgrfiI=

--WJQsCZfX31KDxg8UnCzb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 117 runs, 3 regressions (v4.19.175-cip43)

Regressions Summary
-------------------

platform       | arch  | lab           | compiler | defconfig              =
      | regressions
---------------+-------+---------------+----------+------------------------=
------+------------
meson-gxm-q200 | arm64 | lab-baylibre  | gcc-8    | defconfig+CON...BIG_END=
IAN=3Dy | 1          =

meson-gxm-q200 | arm64 | lab-baylibre  | gcc-8    | defconfig              =
      | 1          =

panda          | arm   | lab-collabora | gcc-8    | omap2plus_defconfig    =
      | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.175-cip43/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.175-cip43
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9b31f372ed011b190606ed6823a4361630440613 =



Test Regressions
---------------- =



platform       | arch  | lab           | compiler | defconfig              =
      | regressions
---------------+-------+---------------+----------+------------------------=
------+------------
meson-gxm-q200 | arm64 | lab-baylibre  | gcc-8    | defconfig+CON...BIG_END=
IAN=3Dy | 1          =


  Details:     https://kernelci.org/test/plan/id/602a448ac8bff9e7923abe75

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.175=
-cip43/arm64/defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy/gcc-8/lab-baylibre/baselin=
e-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.175=
-cip43/arm64/defconfig+CONFIG_CPU_BIG_ENDIAN=3Dy/gcc-8/lab-baylibre/baselin=
e-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64be/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/602a448bc8bff9e7923ab=
e76
        new failure (last pass: v4.19.169-cip42) =

 =



platform       | arch  | lab           | compiler | defconfig              =
      | regressions
---------------+-------+---------------+----------+------------------------=
------+------------
meson-gxm-q200 | arm64 | lab-baylibre  | gcc-8    | defconfig              =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/602a45efe86ae4529f3abebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.175=
-cip43/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.175=
-cip43/arm64/defconfig/gcc-8/lab-baylibre/baseline-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/arm64/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/602a45efe86ae4529f3ab=
ebc
        new failure (last pass: v4.19.169-cip42) =

 =



platform       | arch  | lab           | compiler | defconfig              =
      | regressions
---------------+-------+---------------+----------+------------------------=
------+------------
panda          | arm   | lab-collabora | gcc-8    | omap2plus_defconfig    =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/602a43ed402de6fccd3abe8b

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.175=
-cip43/arm/omap2plus_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.175=
-cip43/arm/omap2plus_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/602a43ee402de6f=
ccd3abe92
        new failure (last pass: v4.19.165-cip41)
        2 lines

    2021-02-15 09:50:33.295000+00:00  kern  :emerg :  lock: emif_lock+0x0/0=
xffffed34 [emif], .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
    2021-02-15 09:50:33.310000+00:00  <8>[   22.596618] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>   =

 =20

--WJQsCZfX31KDxg8UnCzb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6178): https://lists.cip-project.org/g/cip-dev/message=
/6178
Mute This Topic: https://lists.cip-project.org/mt/80650563/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WJQsCZfX31KDxg8UnCzb--
