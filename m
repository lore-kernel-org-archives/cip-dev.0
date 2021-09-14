Return-Path: <SRS0=vaTL=OE=lists.cip-project.org=bounce+64572+6735+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29DEC433F5
	for <cip-dev@archiver.kernel.org>; Tue, 14 Sep 2021 01:12:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5792561108
	for <cip-dev@archiver.kernel.org>; Tue, 14 Sep 2021 01:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5792561108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id mGynYY4521723xvymia8uFmB; Mon, 13 Sep 2021 18:12:48 -0700
X-Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.3762.1631581967306849600
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Sep 2021 18:12:47 -0700
X-Received: by mail-pj1-f41.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso831101pji.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Sep 2021 18:12:47 -0700 (PDT)
X-Gm-Message-State: DBKdNEL6vlc2oXcokVVnHAWAx4520388AA=
X-Google-Smtp-Source: ABdhPJxUbOFVHRm/yO/McrrEnrklbCTr2FYte8Xen/a4zhCIcnwQy5JPYwqxdQBGuN+m6tgfshY0Rw==
X-Received: by 2002:a17:90a:c302:: with SMTP id g2mr2555056pjt.136.1631581966600;
        Mon, 13 Sep 2021 18:12:46 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q3sm9679485pgf.18.2021.09.13.18.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 18:12:46 -0700 (PDT)
Message-ID: <613ff70e.1c69fb81.ebefd.e494@mx.google.com>
Date: Mon, 13 Sep 2021 18:12:46 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.206-cip57-rt22
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip-rt
Subject: [cip-dev] cip/linux-4.19.y-cip-rt baseline: 312 runs, 3 regressions (v4.19.206-cip57-rt22) #kernelci
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
Content-Type: multipart/mixed; boundary="5Ta2Wq34rlDWJW20dIx5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631581968;
 bh=lwvn2Vx8DicQ8tzIGUpQtb/+aSA8Dzk/eHAqu+zWI2o=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=FhY5FVAWSo326+qGjbJBSX8+bgBiM22A5hjbvQo4MB/BNpIFEdAk6oEZ+oz3+Qg2PIq
 hOK1sbKQkA91Eb+QrqgQEbLIVhmXpA2EdbzN3+1Hq7jwEgcamaNohxlXZ/edwnjZKnnq3
 9XG+GGb8WZ8DWXXo0LuNdBkvvWZI2Fc0nmU=

--5Ta2Wq34rlDWJW20dIx5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip-rt baseline: 312 runs, 3 regressions (v4.19.206-cip57-=
rt22)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.206-cip57-rt22/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.206-cip57-rt22
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      41594e91e88c903aea7138a695749aca94eb697f =



Test Regressions
---------------- =



platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/613fe9313bb919534c99a332

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
206-cip57-rt22/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm=
-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
206-cip57-rt22/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm=
-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613fe9313bb919534c99a=
333
        failing since 289 days (last pass: v4.19.152-cip37-rt16, first fail=
: v4.19.160-cip39-rt17) =

 =



platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/613fe879e9c4b2a9e499a2da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
206-cip57-rt22/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-vers=
atilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
206-cip57-rt22/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-vers=
atilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613fe879e9c4b2a9e499a=
2db
        failing since 289 days (last pass: v4.19.152-cip37-rt16, first fail=
: v4.19.160-cip39-rt17) =

 =



platform             | arch | lab           | compiler | defconfig         =
  | regressions
---------------------+------+---------------+----------+-------------------=
--+------------
qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/613fe90a874814d2f399a2f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
206-cip57-rt22/arm/versatile_defconfig/gcc-8/lab-collabora/baseline-qemu_ar=
m-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
206-cip57-rt22/arm/versatile_defconfig/gcc-8/lab-collabora/baseline-qemu_ar=
m-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613fe90a874814d2f399a=
2f5
        failing since 289 days (last pass: v4.19.152-cip37-rt16, first fail=
: v4.19.160-cip39-rt17) =

 =20

--5Ta2Wq34rlDWJW20dIx5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6735): https://lists.cip-project.org/g/cip-dev/message/=
6735
Mute This Topic: https://lists.cip-project.org/mt/85592125/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5Ta2Wq34rlDWJW20dIx5--
