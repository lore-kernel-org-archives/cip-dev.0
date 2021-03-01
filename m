Return-Path: <SRS0=FvRO=H7=lists.cip-project.org=bounce+64572+6204+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0378C433E0
	for <cip-dev@archiver.kernel.org>; Mon,  1 Mar 2021 01:54:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111EA60238
	for <cip-dev@archiver.kernel.org>; Mon,  1 Mar 2021 01:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111EA60238
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6204+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3e22YY4521723xRcivsFxtVi; Sun, 28 Feb 2021 17:54:36 -0800
X-Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web12.6750.1614563676294872826
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 28 Feb 2021 17:54:36 -0800
X-Received: by mail-pg1-f175.google.com with SMTP id b21so10512046pgk.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 28 Feb 2021 17:54:36 -0800 (PST)
X-Gm-Message-State: 34pp1RxUMPdR9fGG5ujoOFlHx4520388AA=
X-Google-Smtp-Source: ABdhPJzDF+9K7DaFimUa/svjf91FhKqb3+08EIhzqiZf8YuYEtj5V3S5/c20zRWOoncxLYnj0Y9xJQ==
X-Received: by 2002:a62:b50d:0:b029:1ed:c0d:3778 with SMTP id y13-20020a62b50d0000b02901ed0c0d3778mr13220489pfe.72.1614563675512;
        Sun, 28 Feb 2021 17:54:35 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gg5sm15343753pjb.3.2021.02.28.17.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 17:54:35 -0800 (PST)
Message-ID: <603c495b.1c69fb81.3974c.4bce@mx.google.com>
Date: Sun, 28 Feb 2021 17:54:35 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.177-cip44
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline: 122 runs, 1 regressions (v4.19.177-cip44) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="9Z6iy0hhSq4xauQew670"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614563676;
 bh=cqyWfHrOVa327uUXaJWjCaYudnGzAZm43xZ/vBdzzoU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=RHxyOk/O4cTBcgYZ5hFx7RLg0+UT3TuFVO4dBo1yMYJRTQTpi/EUXuXaIyu+bEuxEg7
 D+wF5dh58oQb9pxAtcL3+J/tjZ61NM/6SuXpwmfl6b96n1f3E51eRUwUorgggZNO8Au7R
 EXB+qjD+HcPxGBAiWN4IvtqOj9//wMMShBo=

--9Z6iy0hhSq4xauQew670
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline: 122 runs, 1 regressions (v4.19.177-cip44)

Regressions Summary
-------------------

platform | arch | lab           | compiler | defconfig           | regressi=
ons
---------+------+---------------+----------+---------------------+---------=
---
panda    | arm  | lab-collabora | gcc-8    | omap2plus_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.177-cip44/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.177-cip44
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e48c182113555669a03ec13050eed01d1dc66e9f =



Test Regressions
---------------- =



platform | arch | lab           | compiler | defconfig           | regressi=
ons
---------+------+---------------+----------+---------------------+---------=
---
panda    | arm  | lab-collabora | gcc-8    | omap2plus_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/603c3b89e92ece7c97addcea

  Results:     4 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.177=
-cip44/arm/omap2plus_defconfig/gcc-8/lab-collabora/baseline-panda.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.177=
-cip44/arm/omap2plus_defconfig/gcc-8/lab-collabora/baseline-panda.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.dmesg.emerg: https://kernelci.org/test/case/id/603c3b89e92ece7=
c97addcef
        failing since 13 days (last pass: v4.19.165-cip41, first fail: v4.1=
9.175-cip43)
        2 lines

    2021-03-01 00:55:32.292000+00:00  kern  :emerg :  lock: emif_lock+0x0/0=
xffffed34 [emif], .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
    2021-03-01 00:55:32.310000+00:00  <8>[   22.909362] <LAVA_SIGNAL_TESTCA=
SE TEST_CASE_ID=3Demerg RESULT=3Dfail UNITS=3Dlines MEASUREMENT=3D2>   =

 =20

--9Z6iy0hhSq4xauQew670
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6204): https://lists.cip-project.org/g/cip-dev/message=
/6204
Mute This Topic: https://lists.cip-project.org/mt/80987469/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9Z6iy0hhSq4xauQew670--
