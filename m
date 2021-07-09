Return-Path: <SRS0=WZQW=MB=lists.cip-project.org=bounce+64572+6615+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F678C07E9B
	for <cip-dev@archiver.kernel.org>; Fri,  9 Jul 2021 05:27:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7756861002
	for <cip-dev@archiver.kernel.org>; Fri,  9 Jul 2021 05:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7756861002
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6615+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3QmcYY4521723xKbyJg0mvn8; Thu, 08 Jul 2021 22:27:33 -0700
X-Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web11.7241.1625808452548022818
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 08 Jul 2021 22:27:32 -0700
X-Received: by mail-pg1-f177.google.com with SMTP id u14so8799539pga.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 08 Jul 2021 22:27:32 -0700 (PDT)
X-Gm-Message-State: fX7QVrR1nIYhMCA5wxosWh5wx4520388AA=
X-Google-Smtp-Source: ABdhPJxrzsJeSVFvoItwg6VH++jdGd/MExQ+gm98YF8L+FVXE38oMfFG37cDPp76MaQTyWeBFDeA3Q==
X-Received: by 2002:a62:2cce:0:b029:327:6418:abc7 with SMTP id s197-20020a622cce0000b02903276418abc7mr8385246pfs.27.1625808451886;
        Thu, 08 Jul 2021 22:27:31 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e21sm4735326pfc.172.2021.07.08.22.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 22:27:31 -0700 (PDT)
Message-ID: <60e7de43.1c69fb81.e189c.f79f@mx.google.com>
Date: Thu, 08 Jul 2021 22:27:31 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.196-cip53
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 37 runs, 4 regressions (v4.19.196-cip53) #kernelci
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
Content-Type: multipart/mixed; boundary="5awuebuAXfHYAsHmnMUe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625808453;
 bh=SWdRsF3qcmWnuyy7JIHsa8TzBxIK5r5lthQgs0KZAxU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=hlBJB0o2qpT+1EYZ4vgybaqDtrQ2fyIWL/rhtDgax1iaUjiDyRWayH4HZBXJSBbgjLz
 v4wisUJI7ywddR/7ptWLmE7xxzW14k7Sls7rX9EXGgUwfovSIeBXqSrqjmpZeQOsIo8p8
 wzDEfCv7NZCtVsUHeDoIpu8mu3kBY93fhsk=

--5awuebuAXfHYAsHmnMUe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 37 runs, 4 regressions (v4.19.196-cip53)

Regressions Summary
-------------------

platform                  | arch  | lab             | compiler | defconfig =
                   | regressions
--------------------------+-------+-----------------+----------+-----------=
-------------------+------------
beaglebone-black          | arm   | lab-cip         | gcc-8    | multi_v7_d=
efc...CONFIG_SMP=3Dn | 1          =

dove-cubox                | arm   | lab-pengutronix | gcc-8    | multi_v7_d=
efconfig           | 1          =

meson-gxm-q200            | arm64 | lab-baylibre    | gcc-8    | defconfig =
                   | 1          =

sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre    | gcc-8    | sunxi_defc=
onfig              | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.196-cip53/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.196-cip53
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      355ca6a3e3d66cf7f6b53dbe0e5042e035577b3e =



Test Regressions
---------------- =



platform                  | arch  | lab             | compiler | defconfig =
                   | regressions
--------------------------+-------+-----------------+----------+-----------=
-------------------+------------
beaglebone-black          | arm   | lab-cip         | gcc-8    | multi_v7_d=
efc...CONFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/60e7d635a14193ac51117973

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.196=
-cip53/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-nfs-bea=
glebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.196=
-cip53/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-nfs-bea=
glebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60e7d635a14193ac5=
1117974
        new failure (last pass: v4.19.195-cip52) =

 =



platform                  | arch  | lab             | compiler | defconfig =
                   | regressions
--------------------------+-------+-----------------+----------+-----------=
-------------------+------------
dove-cubox                | arm   | lab-pengutronix | gcc-8    | multi_v7_d=
efconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/60e7d6ecb91e0bf4a1117976

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.196=
-cip53/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.196=
-cip53/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60e7d6ecb91e0bf4a=
1117977
        failing since 74 days (last pass: v4.19.186-cip47-1-g4c2cb7ba796b, =
first fail: v4.19.188-cip48) =

 =



platform                  | arch  | lab             | compiler | defconfig =
                   | regressions
--------------------------+-------+-----------------+----------+-----------=
-------------------+------------
meson-gxm-q200            | arm64 | lab-baylibre    | gcc-8    | defconfig =
                   | 1          =


  Details:     https://kernelci.org/test/plan/id/60e7d91b8c5520425c117a20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.196=
-cip53/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.196=
-cip53/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60e7d91b8c5520425=
c117a21
        failing since 108 days (last pass: v4.19.169-cip42, first fail: v4.=
19.182-cip45) =

 =



platform                  | arch  | lab             | compiler | defconfig =
                   | regressions
--------------------------+-------+-----------------+----------+-----------=
-------------------+------------
sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre    | gcc-8    | sunxi_defc=
onfig              | 1          =


  Details:     https://kernelci.org/test/plan/id/60e7da33977108b7e6117971

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.196=
-cip53/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinux=
ino-lime2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.196=
-cip53/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinux=
ino-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60e7da33977108b7e=
6117972
        failing since 54 days (last pass: v4.19.183-cip46, first fail: v4.1=
9.188-cip48-2-g1296cf66cc52) =

 =20

--5awuebuAXfHYAsHmnMUe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6615): https://lists.cip-project.org/g/cip-dev/message=
/6615
Mute This Topic: https://lists.cip-project.org/mt/84085503/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5awuebuAXfHYAsHmnMUe--
