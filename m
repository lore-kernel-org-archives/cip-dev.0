Return-Path: <SRS0=8NTW=JK=lists.cip-project.org=bounce+64572+6373+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D42C433ED
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 15:17:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D36C611CE
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 15:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D36C611CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6373+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QyYTYY4521723xDVnKxqkn0R; Tue, 13 Apr 2021 08:17:16 -0700
X-Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.145.1618327036190938404
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Apr 2021 08:17:16 -0700
X-Received: by mail-pl1-f171.google.com with SMTP id z22so3267271plo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Apr 2021 08:17:16 -0700 (PDT)
X-Gm-Message-State: LGvXi0Ss2LUelHbO8NSJSkpMx4520388AA=
X-Google-Smtp-Source: ABdhPJzgMjB7f5+YRUey1Zo2YRt0jGplRaL+gKE4+oHblArsmo0Shr6cLo5Dtbb8vzcd5bhQaO6zDw==
X-Received: by 2002:a17:902:e74f:b029:ea:f2b5:1add with SMTP id p15-20020a170902e74fb02900eaf2b51addmr3963049plf.29.1618327035533;
        Tue, 13 Apr 2021 08:17:15 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x6sm7154506pfr.59.2021.04.13.08.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:17:15 -0700 (PDT)
Message-ID: <6075b5fb.1c69fb81.fc267.0a9f@mx.google.com>
Date: Tue, 13 Apr 2021 08:17:15 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.186-cip47-1-g4c2cb7ba796b
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 136 runs, 3 regressions (v4.19.186-cip47-1-g4c2cb7ba796b) #kernelci
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
Content-Type: multipart/mixed; boundary="lVjskiIFjKv3L3ZrAL0J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618327036;
 bh=NRKS8XWBpMeRewWzRDwzB0AkMf5ETn8nSDO6CyxWZxw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=X1DfoRnNgsp/WkQp13BspXaxerUpuNFbyB3ceIvYD+xflZ91DYVewy7RrUmDA0lia1A
 RIKeu0039DaLLD5Z+PJGg5g9jZ0TIJlJ2Aoaay77gkVAEqYmdMc9im7LjTsLHJoDOpQIU
 960PlCa1pjI2ZFphcLh+SaM7k4hlc6LW6As=

--lVjskiIFjKv3L3ZrAL0J
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 136 runs, 3 regressions (v4.19.186-cip47-1-g=
4c2cb7ba796b)

Regressions Summary
-------------------

platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g | 1          =

qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g | 1          =

qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.186-cip47-1-g4c2cb7ba796b/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.186-cip47-1-g4c2cb7ba796b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      4c2cb7ba796b4f3ff79d51be8980b1e148581d8c =



Test Regressions
---------------- =



platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/6075a5cb490b343c78dac6bf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.186=
-cip47-1-g4c2cb7ba796b/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-=
qemu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.186=
-cip47-1-g4c2cb7ba796b/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-=
qemu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6075a5cb490b343c78dac=
6c0
        failing since 150 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/6075a5c2490b343c78dac6b8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.186=
-cip47-1-g4c2cb7ba796b/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_=
arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.186=
-cip47-1-g4c2cb7ba796b/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_=
arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6075a5c2490b343c78dac=
6b9
        failing since 150 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/6075a56e31f0de20a3dac6ca

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.186=
-cip47-1-g4c2cb7ba796b/arm/versatile_defconfig/gcc-8/lab-collabora/baseline=
-qemu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.186=
-cip47-1-g4c2cb7ba796b/arm/versatile_defconfig/gcc-8/lab-collabora/baseline=
-qemu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6075a56e31f0de20a3dac=
6cb
        failing since 150 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =20

--lVjskiIFjKv3L3ZrAL0J
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6373): https://lists.cip-project.org/g/cip-dev/message=
/6373
Mute This Topic: https://lists.cip-project.org/mt/82067514/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--lVjskiIFjKv3L3ZrAL0J--
