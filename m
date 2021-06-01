Return-Path: <SRS0=qB0g=K3=lists.cip-project.org=bounce+64572+6488+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC98AC4708F
	for <cip-dev@archiver.kernel.org>; Tue,  1 Jun 2021 10:19:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AC226139A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Jun 2021 10:19:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC226139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6488+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7ZkgYY4521723xEuGaWEGmlI; Tue, 01 Jun 2021 03:19:36 -0700
X-Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.55884.1622542775776741725
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 01 Jun 2021 03:19:35 -0700
X-Received: by mail-pl1-f181.google.com with SMTP id 69so6614675plc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 01 Jun 2021 03:19:35 -0700 (PDT)
X-Gm-Message-State: ZiP35mSD1gxVKcLiO7xzJb1Dx4520388AA=
X-Google-Smtp-Source: ABdhPJxAfXjE2Si9BJB6ofQn8ASC3GPiMskgPJ2XLhM6oZPnt2iVuwSvnmfN9I1g3ClFD474iQ4ynA==
X-Received: by 2002:a17:90a:8416:: with SMTP id j22mr24215277pjn.73.1622542775164;
        Tue, 01 Jun 2021 03:19:35 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m191sm13853668pga.88.2021.06.01.03.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 03:19:34 -0700 (PDT)
Message-ID: <60b609b6.1c69fb81.c06da.b53d@mx.google.com>
Date: Tue, 01 Jun 2021 03:19:34 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.192-cip50
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 196 runs, 5 regressions (v4.19.192-cip50) #kernelci
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
Content-Type: multipart/mixed; boundary="Cu3JPS84CEVSMQN34z0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622542776;
 bh=LzHR/XszSdHMQHtsayDu7CjPAT/ulFDRAqNfC5XxUvU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=c6CbtzD6KsHfAjkuRc/mPG9Y0G2+OLLTOO59uN800WWfDAf/+xCKust+Ng0cIHeC1MP
 VT4mZTQrIOdmDma3UF2owmtTdUnuvQ9YBy3ltPHawKPuqD0MGRnkZ+BfqXjzdcsUlKVWu
 XFQn/dYz3idweYbYgwoDxPB4jwtk3oLn930=

--Cu3JPS84CEVSMQN34z0B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 196 runs, 5 regressions (v4.19.192-cip50)

Regressions Summary
-------------------

platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
beaglebone-black     | arm  | lab-cip       | gcc-8    | multi_v7_defconfig=
  | 1          =

qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g | 1          =

qemu_arm-versatilepb | arm  | lab-broonie   | gcc-8    | versatile_defconfi=
g | 1          =

qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g | 1          =

qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.192-cip50/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.192-cip50
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b07208f6cd5664fa3a2e5c7403dfd3a27ef5daac =



Test Regressions
---------------- =



platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
beaglebone-black     | arm  | lab-cip       | gcc-8    | multi_v7_defconfig=
  | 1          =


  Details:     https://kernelci.org/test/plan/id/60b5fd08f415127feab3af99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60b5fd08f415127feab3a=
f9a
        new failure (last pass: v4.19.190-cip49) =

 =



platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/60b5f94c4794526d80b3afaa

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60b5f94c4794526d80b3a=
fab
        failing since 199 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm  | lab-broonie   | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/60b5f94fd868d53219b3af97

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-versatil=
epb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-versatil=
epb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60b5f94fd868d53219b3a=
f98
        failing since 199 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/60b5f9474794526d80b3afa5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60b5f9474794526d80b3a=
fa6
        failing since 199 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/60b5f902266b901468b3af99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/versatile_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-versat=
ilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/versatile_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-versat=
ilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60b5f902266b901468b3a=
f9a
        failing since 199 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =20

--Cu3JPS84CEVSMQN34z0B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6488): https://lists.cip-project.org/g/cip-dev/message=
/6488
Mute This Topic: https://lists.cip-project.org/mt/83228831/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Cu3JPS84CEVSMQN34z0B--
