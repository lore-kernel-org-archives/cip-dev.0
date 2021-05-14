Return-Path: <SRS0=goaK=KJ=lists.cip-project.org=bounce+64572+6460+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C18C433B4
	for <cip-dev@archiver.kernel.org>; Fri, 14 May 2021 15:51:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D231E6143F
	for <cip-dev@archiver.kernel.org>; Fri, 14 May 2021 15:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D231E6143F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6460+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wrGiYY4521723xkSFOblees2; Fri, 14 May 2021 08:51:18 -0700
X-Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.10692.1621007477991421784
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 May 2021 08:51:18 -0700
X-Received: by mail-pg1-f171.google.com with SMTP id q15so20164501pgg.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 May 2021 08:51:17 -0700 (PDT)
X-Gm-Message-State: BQmHrpPiAegPzbmzmiD4BzDNx4520388AA=
X-Google-Smtp-Source: ABdhPJz4nq9ZhCLhe5Du2bUOEgNqR1+xckAebpDo2AF5MA/YKXl18f3pHfHhcnPeH1E8/wMMhik5QA==
X-Received: by 2002:a63:5b08:: with SMTP id p8mr906587pgb.193.1621007477431;
        Fri, 14 May 2021 08:51:17 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y26sm4459104pge.94.2021.05.14.08.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 08:51:17 -0700 (PDT)
Message-ID: <609e9c75.1c69fb81.eeca5.f48f@mx.google.com>
Date: Fri, 14 May 2021 08:51:17 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.188-cip48-2-g1296cf66cc52
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 169 runs, 3 regressions (v4.19.188-cip48-2-g1296cf66cc52) #kernelci
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
Content-Type: multipart/mixed; boundary="gpxj0SCSWeHloeC4lBcK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1621007478;
 bh=eQymowt/YW1LloFrmfn96Q8Dl9vMR1/W6rkvhnC/TiM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BB4/UbltTKi3X43LWwv18Q/cvJaCu2ZZC2Ih+OEJA0jxfGa8yKbpNY2UVK8UXWbNVw8
 JG0JiLy3IecF7YnN0j4K3/GBcSu/LSyxZKTAIp2JBOgjMtFUrM6PbHbDde08HdkHjF2zQ
 Fjlsv+KtHSl9T90Im+uygKRn+LZE1DUgfGw=

--gpxj0SCSWeHloeC4lBcK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 169 runs, 3 regressions (v4.19.188-cip48-2-g=
1296cf66cc52)

Regressions Summary
-------------------

platform             | arch | lab          | compiler | defconfig          =
 | regressions
---------------------+------+--------------+----------+--------------------=
-+------------
qemu_arm-versatilepb | arm  | lab-baylibre | gcc-8    | versatile_defconfig=
 | 1          =

qemu_arm-versatilepb | arm  | lab-broonie  | gcc-8    | versatile_defconfig=
 | 1          =

qemu_arm-versatilepb | arm  | lab-cip      | gcc-8    | versatile_defconfig=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.188-cip48-2-g1296cf66cc52/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.188-cip48-2-g1296cf66cc52
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1296cf66cc5254f1ef6bfe19945e0bc2d81b65a7 =



Test Regressions
---------------- =



platform             | arch | lab          | compiler | defconfig          =
 | regressions
---------------------+------+--------------+----------+--------------------=
-+------------
qemu_arm-versatilepb | arm  | lab-baylibre | gcc-8    | versatile_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/609e9388f5117e4164b3af9c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48-2-g1296cf66cc52/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-=
qemu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48-2-g1296cf66cc52/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-=
qemu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/609e9388f5117e4164b3a=
f9d
        failing since 181 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab          | compiler | defconfig          =
 | regressions
---------------------+------+--------------+----------+--------------------=
-+------------
qemu_arm-versatilepb | arm  | lab-broonie  | gcc-8    | versatile_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/609e932ca8c6512e08b3afc5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48-2-g1296cf66cc52/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-q=
emu_arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48-2-g1296cf66cc52/arm/versatile_defconfig/gcc-8/lab-broonie/baseline-q=
emu_arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/609e932ca8c6512e08b3a=
fc6
        failing since 181 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =



platform             | arch | lab          | compiler | defconfig          =
 | regressions
---------------------+------+--------------+----------+--------------------=
-+------------
qemu_arm-versatilepb | arm  | lab-cip      | gcc-8    | versatile_defconfig=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/609e92d13df22332bcb3afc0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48-2-g1296cf66cc52/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_=
arm-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48-2-g1296cf66cc52/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_=
arm-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-5-g2f114cc7102b/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/609e92d13df22332bcb3a=
fc1
        failing since 181 days (last pass: v4.19.152-cip37-37-g18852869b06b=
, first fail: v4.19.157-cip38) =

 =20

--gpxj0SCSWeHloeC4lBcK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6460): https://lists.cip-project.org/g/cip-dev/message=
/6460
Mute This Topic: https://lists.cip-project.org/mt/82827668/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--gpxj0SCSWeHloeC4lBcK--
