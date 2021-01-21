Return-Path: <SRS0=YC2W=GY=lists.cip-project.org=bounce+64572+6133+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB4EC433DB
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 21:48:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019C023A54
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 21:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019C023A54
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6133+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id devrYY4521723xtbFjCOiqQC; Thu, 21 Jan 2021 13:48:27 -0800
X-Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.266.1611265707040939834
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jan 2021 13:48:27 -0800
X-Received: by mail-pl1-f172.google.com with SMTP id s15so2046450plr.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 21 Jan 2021 13:48:27 -0800 (PST)
X-Gm-Message-State: PCIPgo36GVmsA0Bi4HpCTJinx4520388AA=
X-Google-Smtp-Source: ABdhPJzQ6HtAnYiDtPsLMNVyq6L9lX+7XEl2LXgKoE1h3i+d5en87KG59VmJCitsLApOGlBa60yxlA==
X-Received: by 2002:a17:90b:1c0d:: with SMTP id oc13mr1633416pjb.156.1611265705756;
        Thu, 21 Jan 2021 13:48:25 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a141sm6564049pfa.189.2021.01.21.13.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 13:48:25 -0800 (PST)
Message-ID: <6009f6a9.1c69fb81.37be8.ff90@mx.google.com>
Date: Thu, 21 Jan 2021 13:48:25 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.165-cip41-rt18
Subject: [cip-dev] cip/linux-4.19.y-cip-rt baseline: 240 runs, 4 regressions (v4.19.165-cip41-rt18) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="nMC4PlZ38oqfUtjmbmHq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611265707;
 bh=yKn2agCL4CcuCL99n8UVCkxlDlJi4aL5BkqGbnj8dQw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=sfGdB6IQeXTlB00P6+eElEaM1xz+j4MGSKmcVclmH+chBySkFezpLai3BjRyeY8sDRt
 Nkwm3sRK0D+k2n/Coy1PKSYRsZoBV0aLfU8NI0azi0gYqrQCxw3JA2QbcC0ob4bLndcBm
 J2j10VM++LiGHU9ERHqE3IXgfds/TXRkhec=

--nMC4PlZ38oqfUtjmbmHq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip-rt baseline: 240 runs, 4 regressions (v4.19.165-cip41-=
rt18)

Regressions Summary
-------------------

platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g          | 1          =

qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g          | 1          =

qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g          | 1          =

rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defc...CO=
NFIG_SMP=3Dn | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.165-cip41-rt18/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.165-cip41-rt18
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0882431bf2fe2c5ca3410e541b734f2cd5a7d8a6 =



Test Regressions
---------------- =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-baylibre  | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/60098f3b0189155a6dbb5d2a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
165-cip41-rt18/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm=
-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
165-cip41-rt18/arm/versatile_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm=
-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60098f3b0189155a6dbb5=
d2b
        failing since 53 days (last pass: v4.19.152-cip37-rt16, first fail:=
 v4.19.160-cip39-rt17) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-cip       | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/60098f50310794c539bb5d2a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
165-cip41-rt18/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-vers=
atilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
165-cip41-rt18/arm/versatile_defconfig/gcc-8/lab-cip/baseline-qemu_arm-vers=
atilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60098f50310794c539bb5=
d2b
        failing since 53 days (last pass: v4.19.152-cip37-rt16, first fail:=
 v4.19.160-cip39-rt17) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
qemu_arm-versatilepb | arm  | lab-collabora | gcc-8    | versatile_defconfi=
g          | 1          =


  Details:     https://kernelci.org/test/plan/id/60098f06ebca127450bb5d3f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: versatile_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
165-cip41-rt18/arm/versatile_defconfig/gcc-8/lab-collabora/baseline-qemu_ar=
m-versatilepb.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
165-cip41-rt18/arm/versatile_defconfig/gcc-8/lab-collabora/baseline-qemu_ar=
m-versatilepb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/60098f06ebca127450bb5=
d40
        failing since 53 days (last pass: v4.19.152-cip37-rt16, first fail:=
 v4.19.160-cip39-rt17) =

 =



platform             | arch | lab           | compiler | defconfig         =
           | regressions
---------------------+------+---------------+----------+-------------------=
-----------+------------
rk3288-veyron-jaq    | arm  | lab-collabora | gcc-8    | multi_v7_defc...CO=
NFIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/600997700bdd00dbecbb5d26

  Results:     65 PASS, 4 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
165-cip41-rt18/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/ba=
seline-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
165-cip41-rt18/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/ba=
seline-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.bootrr.cros-ec-keyb-probed: https://kernelci.org/test/case/id/=
600997700bdd00dbecbb5d33
        failing since 109 days (last pass: v4.19.147-cip35-870-g1ab90a078b1=
a, first fail: v4.19.148-cip35-rt15) =

 =20

--nMC4PlZ38oqfUtjmbmHq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6133): https://lists.cip-project.org/g/cip-dev/message=
/6133
Mute This Topic: https://lists.cip-project.org/mt/80016139/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--nMC4PlZ38oqfUtjmbmHq--
