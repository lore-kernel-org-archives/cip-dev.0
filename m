Return-Path: <SRS0=y4DM=MB=lists.cip-project.org=bounce+64572+6612+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26C8C07E99
	for <cip-dev@archiver.kernel.org>; Fri,  9 Jul 2021 04:39:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A40C6141A
	for <cip-dev@archiver.kernel.org>; Fri,  9 Jul 2021 04:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A40C6141A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6612+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HFk5YY4521723xpQ6Yw5nRuC; Thu, 08 Jul 2021 21:39:32 -0700
X-Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.6944.1625805572455209747
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 08 Jul 2021 21:39:32 -0700
X-Received: by mail-pj1-f51.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so5369580pjo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 08 Jul 2021 21:39:32 -0700 (PDT)
X-Gm-Message-State: GOklavqt6tJ4EVARA9Z5ZTSVx4520388AA=
X-Google-Smtp-Source: ABdhPJwSC/rSyTCKaF3sGMnttoqfX/j0Z4BGnAiz0fCOvZ1L5tNLBcPs48Ecj4rGuhRke8tjyhZppg==
X-Received: by 2002:a17:902:9308:b029:129:7c79:e53d with SMTP id bc8-20020a1709029308b02901297c79e53dmr23988879plb.50.1625805571743;
        Thu, 08 Jul 2021 21:39:31 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m21sm4847876pfa.99.2021.07.08.21.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 21:39:31 -0700 (PDT)
Message-ID: <60e7d303.1c69fb81.61811.f981@mx.google.com>
Date: Thu, 08 Jul 2021 21:39:31 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.4.274-cip59
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
Subject: [cip-dev] cip/linux-4.4.y-cip baseline-nfs: 22 runs, 2 regressions (v4.4.274-cip59) #kernelci
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
Content-Type: multipart/mixed; boundary="4ky2MtCzo3ukUWUpa7pf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625805572;
 bh=nT+6Pij+A6Y3LpMxIMRW8+XutPWNhOcYZfKXOCevocU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Wj6BVNI4cGdE2N5zF+yQzXiqOzj/vK08e0oNfu8GeVMCUqPukf3XSefeqSAKa3Cp5/w
 mlLINzCHendVFIjR0b9K+hwD4u40eOSeyv5xwfJ0MPpcJcPANGftsjSizQK12/aj2GOSV
 4rYPgtHDzehj+9jW5fkQ423xItSpa3pfxmM=

--4ky2MtCzo3ukUWUpa7pf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline-nfs: 22 runs, 2 regressions (v4.4.274-cip59)

Regressions Summary
-------------------

platform                  | arch | lab             | compiler | defconfig  =
        | regressions
--------------------------+------+-----------------+----------+------------=
--------+------------
dove-cubox                | arm  | lab-pengutronix | gcc-8    | multi_v7_de=
fconfig | 1          =

sun7i-a20-olinuxino-lime2 | arm  | lab-baylibre    | gcc-8    | sunxi_defco=
nfig    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.274-cip59/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.274-cip59
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c55ad377e5140d299ac5f6e436642e9734534748 =



Test Regressions
---------------- =



platform                  | arch | lab             | compiler | defconfig  =
        | regressions
--------------------------+------+-----------------+----------+------------=
--------+------------
dove-cubox                | arm  | lab-pengutronix | gcc-8    | multi_v7_de=
fconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60e7c7085eb2b7bb89117981

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.274-c=
ip59/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.274-c=
ip59/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60e7c7085eb2b7bb8=
9117982
        failing since 52 days (last pass: v4.4.266-cip56, first fail: v4.4.=
268-cip57) =

 =



platform                  | arch | lab             | compiler | defconfig  =
        | regressions
--------------------------+------+-----------------+----------+------------=
--------+------------
sun7i-a20-olinuxino-lime2 | arm  | lab-baylibre    | gcc-8    | sunxi_defco=
nfig    | 1          =


  Details:     https://kernelci.org/test/plan/id/60e7d223a238755ead117985

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: sunxi_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.274-c=
ip59/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinuxin=
o-lime2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.274-c=
ip59/arm/sunxi_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-olinuxin=
o-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60e7d223a238755ea=
d117986
        failing since 52 days (last pass: v4.4.262-cip55, first fail: v4.4.=
268-cip57) =

 =20

--4ky2MtCzo3ukUWUpa7pf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6612): https://lists.cip-project.org/g/cip-dev/message=
/6612
Mute This Topic: https://lists.cip-project.org/mt/84085072/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--4ky2MtCzo3ukUWUpa7pf--
