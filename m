Return-Path: <SRS0=kpFO=CG=lists.cip-project.org=bounce+64572+5298+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B1AC433E7
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55F0020872
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="V5U71WkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55F0020872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5298+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hQ7fYY4521723xcMFc63Gmgp; Fri, 28 Aug 2020 09:07:46 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.45837.1598629320009468924
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:15 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55587852"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:15 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 87AD8400C4F0;
	Sat, 29 Aug 2020 00:42:13 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 08/30] clk: shmobile: Compile clk-rcar-gen2.c when using the r8a7742
Date: Fri, 28 Aug 2020 16:41:33 +0100
Message-Id: <20200828154155.5827-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sfm5GSahw3vyU6VzOwWaEwY4x4520388AA=
Content-Type: multipart/mixed; boundary="aUSP67Gqu72a4JiBFOcf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630866;
 bh=Ib4cUGRzOhdpGw6X6ONztxKMFtYdRWFE2f+atG1TcQ0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=V5U71WkF/3QCRJ7PqVbJd9rqdBMaskIQr1CIYgsGKVogYtvvTmT5IebAJKsu+mIN+Ee
 TqYfMth2GYnzt9uG/n6DOWF/6U3qKjWPNYerX6GrV7yorGi1RE/qGDl/DHz6X5Iuz6MvM
 B5WRnP0az7C4LnFq/alIIarumrl+WoQYKes=

--aUSP67Gqu72a4JiBFOcf

This patch makes sure clk-rcar-gen2,c gets compiled when
CONFIG_ARCH_R8A7742 is selected, similarly to what done by
commit:
7bac4ad3e40f ("CIP: Build essential clock driver for Renesas
RZ/G1 platforms")

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/shmobile/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 6badac598707..2f9fb407aa32 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
 obj-$(CONFIG_ARCH_R7S72100)		+= clk-rz.o
 obj-$(CONFIG_ARCH_R8A73A4)		+= clk-r8a73a4.o
 obj-$(CONFIG_ARCH_R8A7740)		+= clk-r8a7740.o
+obj-$(CONFIG_ARCH_R8A7742)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7743)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7744)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7745)		+= clk-rcar-gen2.o
-- 
2.17.1


--aUSP67Gqu72a4JiBFOcf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5298): https://lists.cip-project.org/g/cip-dev/message=
/5298
Mute This Topic: https://lists.cip-project.org/mt/76477081/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--aUSP67Gqu72a4JiBFOcf--
