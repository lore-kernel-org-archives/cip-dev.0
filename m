Return-Path: <SRS0=GCB1=LI=lists.cip-project.org=bounce+64572+6516+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA49C2B9F4
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 15:57:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153476120E
	for <cip-dev@archiver.kernel.org>; Mon, 14 Jun 2021 15:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153476120E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6516+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BPOOYY4521723x9LDyWgIq1q; Mon, 14 Jun 2021 08:57:06 -0700
X-Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web08.31909.1623686226348141386
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 14 Jun 2021 08:57:06 -0700
X-Received: by mail-pf1-f174.google.com with SMTP id d16so10840220pfn.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 14 Jun 2021 08:57:06 -0700 (PDT)
X-Gm-Message-State: YlODcUN1Cijvrz9lZBMdwCFjx4520388AA=
X-Google-Smtp-Source: ABdhPJx1R/aiJXKnJRS6msx9VRRPBrgpIUYZ6NqxyRPYxWDhqf65GsbZmCQ/qxtrrCtkP4CrESTmFg==
X-Received: by 2002:a63:4d0:: with SMTP id 199mr18144068pge.423.1623686225597;
        Mon, 14 Jun 2021 08:57:05 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k70sm13511462pgd.41.2021.06.14.08.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 08:57:05 -0700 (PDT)
Message-ID: <60c77c51.1c69fb81.ac32c.7184@mx.google.com>
Date: Mon, 14 Jun 2021 08:57:05 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.194-cip51
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 37 runs, 1 regressions (v4.19.194-cip51) #kernelci
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
Content-Type: multipart/mixed; boundary="B87bSQ3vENP5ROsxgMcy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623686226;
 bh=hnHSbFaan15/lAT1+o720k6oQ50TEa6IHrLztCiqW/M=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=UgchMSUiFQaRgtPHiEsQlL8cF19af6mjmpihr76MCO8+iL7BG14oGICXvdZspxeIAQ0
 Zk1KVG66A+7jrJ9R89L6zzxvzwimTbAaKSZMwt9fcsiuUOMjrxDCasMdm5bCXucXEyOdd
 7zRlnShYpZBgrd71OtBKLHgIw7c0iwV/ntA=

--B87bSQ3vENP5ROsxgMcy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 37 runs, 1 regressions (v4.19.194-cip51)

Regressions Summary
-------------------

platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
dove-cubox | arm  | lab-pengutronix | gcc-8    | multi_v7_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.194-cip51/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.194-cip51
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      799855afce97bdbab49f1f4feba52335df7dad8f =



Test Regressions
---------------- =



platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
dove-cubox | arm  | lab-pengutronix | gcc-8    | multi_v7_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/60c76bf6b9fe2ff1c941f527

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.194=
-cip51/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.194=
-cip51/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60c76bf6b9fe2ff1c=
941f528
        failing since 49 days (last pass: v4.19.186-cip47-1-g4c2cb7ba796b, =
first fail: v4.19.188-cip48) =

 =20

--B87bSQ3vENP5ROsxgMcy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6516): https://lists.cip-project.org/g/cip-dev/message=
/6516
Mute This Topic: https://lists.cip-project.org/mt/83533782/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--B87bSQ3vENP5ROsxgMcy--
