Return-Path: <SRS0=IT2s=NW=lists.cip-project.org=bounce+64572+6711+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98267C432BE
	for <cip-dev@archiver.kernel.org>; Tue, 31 Aug 2021 03:22:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0676B60E90
	for <cip-dev@archiver.kernel.org>; Tue, 31 Aug 2021 03:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0676B60E90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rZ54YY4521723xg8umXaup7o; Mon, 30 Aug 2021 20:22:07 -0700
X-Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web12.766.1630380127160491938
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 30 Aug 2021 20:22:07 -0700
X-Received: by mail-pj1-f45.google.com with SMTP id d5so5061855pjx.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 30 Aug 2021 20:22:07 -0700 (PDT)
X-Gm-Message-State: bMIPRbuVCY6o7LtXXnoyc6Asx4520388AA=
X-Google-Smtp-Source: ABdhPJzWvanM7JifEWERumCvTmeUK8SaonH0UpOR+AUhQUAGxVjRbyvkHLlkp80IYL0+TMh2OuZb4w==
X-Received: by 2002:a17:90a:5583:: with SMTP id c3mr2580115pji.133.1630380126476;
        Mon, 30 Aug 2021 20:22:06 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 141sm18907935pgf.46.2021.08.30.20.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 20:22:06 -0700 (PDT)
Message-ID: <612da05e.1c69fb81.adb41.1def@mx.google.com>
Date: Mon, 30 Aug 2021 20:22:06 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.205-cip56
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 42 runs, 1 regressions (v4.19.205-cip56) #kernelci
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
Content-Type: multipart/mixed; boundary="iY5sG05fNvLcOZx3f4Hp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1630380127;
 bh=/NQgvzJ+wHb5xxSIN5VbaTq2nUQ0Go4sdZj0Fb1RXGY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=DiNxWTCM2q4jYZCJEhbh28SHHY1h8+K8JbefZkoWCfuvmwT6a41tk5Ojd+RjQKbmREx
 3ActqiROyTINZNwmThbYyNpvl4/au/MUwOoDQNGtPOYtMP2FUX0NWnyPtMGtAgbRJnCMo
 hVxg7EjEY08CTHOSbjY6ZwJe0iS1fyt5nw4=

--iY5sG05fNvLcOZx3f4Hp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 42 runs, 1 regressions (v4.19.205-cip56)

Regressions Summary
-------------------

platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
dove-cubox | arm  | lab-pengutronix | gcc-8    | multi_v7_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.205-cip56/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.205-cip56
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ad19e133aebcec558066ea338f896ec0b7338254 =



Test Regressions
---------------- =



platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
dove-cubox | arm  | lab-pengutronix | gcc-8    | multi_v7_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/612d91bb905996aa128e2c8c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.205=
-cip56/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.205=
-cip56/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0730.6/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/612d91bb905996aa1=
28e2c8d
        failing since 127 days (last pass: v4.19.186-cip47-1-g4c2cb7ba796b,=
 first fail: v4.19.188-cip48) =

 =20

--iY5sG05fNvLcOZx3f4Hp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6711): https://lists.cip-project.org/g/cip-dev/message/=
6711
Mute This Topic: https://lists.cip-project.org/mt/85268758/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--iY5sG05fNvLcOZx3f4Hp--
