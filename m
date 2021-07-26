Return-Path: <SRS0=UI70=MS=lists.cip-project.org=bounce+64572+6631+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8ABC4338F
	for <cip-dev@archiver.kernel.org>; Mon, 26 Jul 2021 20:32:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D67C60F6E
	for <cip-dev@archiver.kernel.org>; Mon, 26 Jul 2021 20:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D67C60F6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ra6JYY4521723xQvPZgCfGee; Mon, 26 Jul 2021 13:32:46 -0700
X-Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web08.2323.1627331565455739680
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 26 Jul 2021 13:32:45 -0700
X-Received: by mail-pj1-f42.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so779899pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 26 Jul 2021 13:32:45 -0700 (PDT)
X-Gm-Message-State: 7bSaKRWnQop1dNrRxIUSLLmPx4520388AA=
X-Google-Smtp-Source: ABdhPJy2QM4WCD93R/SBPFFRdlqd9iMRILHeI33RTyIhNL+P5qcBWhNmjAxFk+cfJjRHrgajFtNVqw==
X-Received: by 2002:a17:902:8201:b029:12b:a6a1:57ee with SMTP id x1-20020a1709028201b029012ba6a157eemr15741241pln.0.1627331564825;
        Mon, 26 Jul 2021 13:32:44 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a21sm383011pjo.15.2021.07.26.13.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 13:32:44 -0700 (PDT)
Message-ID: <60ff1bec.1c69fb81.5f167.1c1c@mx.google.com>
Date: Mon, 26 Jul 2021 13:32:44 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.198-cip54
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 41 runs, 1 regressions (v4.19.198-cip54) #kernelci
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
Content-Type: multipart/mixed; boundary="FgWHrtawW31m39DEnNZ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627331566;
 bh=8opn51p3Y57CvWe11iKljTOpT0DXimuoolPBRmyFFAs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=dMK4bigiIxrazPJRJQioCyDbjOvfwBfxNc/ERS/H91EI+PLr/pqZM4SvGiyLnnwNMJb
 /+hnOCI0JUBwtFpUwHW9n2wiFzd1+WEWYXEy8yh0Yoch70j6rIrE7SpWlUMaV92JheMKF
 59MtX7hFGhIj9TyTIu+GBXBh2sTjmfmpkXE=

--FgWHrtawW31m39DEnNZ9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 41 runs, 1 regressions (v4.19.198-cip54)

Regressions Summary
-------------------

platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
dove-cubox | arm  | lab-pengutronix | gcc-8    | multi_v7_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.198-cip54/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.198-cip54
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1c56041c11a8efcd1374588525c096b89c21ce42 =



Test Regressions
---------------- =



platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
dove-cubox | arm  | lab-pengutronix | gcc-8    | multi_v7_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/60ff1222fcb7ea131b3a2fa3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.198=
-cip54/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.198=
-cip54/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0722.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60ff1222fcb7ea131=
b3a2fa4
        failing since 91 days (last pass: v4.19.186-cip47-1-g4c2cb7ba796b, =
first fail: v4.19.188-cip48) =

 =20

--FgWHrtawW31m39DEnNZ9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6631): https://lists.cip-project.org/g/cip-dev/message=
/6631
Mute This Topic: https://lists.cip-project.org/mt/84467973/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--FgWHrtawW31m39DEnNZ9--
