Return-Path: <SRS0=OaaR=LI=lists.cip-project.org=bounce+64572+6517+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A8CC48BE6
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 15:57:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECA260D07
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 15:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECA260D07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6517+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2hnsYY4521723xg9qfXCtQ8B; Mon, 14 Jun 2021 08:57:07 -0700
X-Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.31978.1623686227202846850
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Jun 2021 08:57:07 -0700
X-Received: by mail-pf1-f182.google.com with SMTP id s14so10847886pfd.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Jun 2021 08:57:07 -0700 (PDT)
X-Gm-Message-State: DJ9NV6YvVjdsDbdjl7iD5gsMx4520388AA=
X-Google-Smtp-Source: ABdhPJz7if73X0wC5Wpnkbg7UG/diGKHk8RpR+QjqHqM9HYdwYyC6HKdVQcbTZkJ1ZFs8gXZi8MX0Q==
X-Received: by 2002:a65:4c46:: with SMTP id l6mr17538414pgr.91.1623686226468;
        Mon, 14 Jun 2021 08:57:06 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b10sm771268pff.14.2021.06.14.08.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:57:06 -0700 (PDT)
Message-ID: <60c77c52.1c69fb81.51bac.1c69@mx.google.com>
Date: Mon, 14 Jun 2021 08:57:06 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.194-cip51
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 213 runs, 5 regressions (v4.19.194-cip51) #kernelci
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
Content-Type: multipart/mixed; boundary="JmqmrUrgfqePUo5sPI4W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623686227;
 bh=tiQONE/NUrwqjIjQRBjUD5YNxzflTyo3VZR8jsKGha4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=ETQvHRme0nXoX3govmd212c8V1e6xQVnkyJFpg7dmzXoJAT7d0dgzKLsMfVSLUfG8dG
 KNKAxnmAGInuZS16fTHVhlacY2Kqir0HgcGFwO55/KZ8Y37oVqzq6rVLjeqQngExponzv
 jiV2XIW4F22bgfVkZp4YGEDJUbwBWDDQRbY=

--JmqmrUrgfqePUo5sPI4W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 213 runs, 5 regressions (v4.19.194-cip51)

Regressions Summary
-------------------

platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g          | 1          =

qemu_arm-versatilepb | arm  | lab-broonie   | gcc-8    | versatile_defconfi=
g          | 1          =

qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g          | 1          =

qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g          | 1          =

rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defc...CO=
NFIG_SMP=3Dn | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.194-cip51/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.194-cip51
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      799855afce97bdbab49f1f4feba52335df7dad8f =



Test Regressions
---------------- =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/60c76ab8dd5ff7465b41f512

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.194=
-cip51/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.194=
-cip51/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-versati=
lepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c76ab8dd5ff7465b41f=
513
        failing since 212 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-broonie   | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/60c76be2745b6b910d41f512

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.194=
-cip51/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-versatil=
epb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.194=
-cip51/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-versatil=
epb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c76be2745b6b910d41f=
513
        failing since 212 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/60c76ab8fc15176c2041f586

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.194=
-cip51/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.194=
-cip51/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-versatilepb.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c76ab8fc15176c2041f=
587
        failing since 212 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/60c76ab6311344218741f51b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.194=
-cip51/arm/versatile_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-versat=
ilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.194=
-cip51/arm/versatile_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-versat=
ilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60c76ab6311344218741f=
51c
        failing since 212 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defc...CO=
NFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60c7767a5872d0ddce41327b

  Results:     65 PASS, 4 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.194=
-cip51/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-r=
k3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.194=
-cip51/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-r=
k3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
60c7767a5872d0ddce413288
        new failure (last pass: v4.19.192-cip50)

    2021-06-14T15:32:04.000599  /lava-4019486/1/../bin/lava-test-case<8>[  =
 15.269153] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Dcros-ec-keyb-probed RESULT=
=3Dfail>   =

 =20

--JmqmrUrgfqePUo5sPI4W
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6517): https://lists.cip-project.org/g/cip-dev/message=
/6517
Mute This Topic: https://lists.cip-project.org/mt/83533785/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--JmqmrUrgfqePUo5sPI4W--
