Return-Path: <SRS0=2IP/=B5=lists.cip-project.org=bounce+64572+5152+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D450C433E3
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CE420882
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VF5qMEm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CE420882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5152+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EqeGYY4521723xwq8ueXkMaZ; Wed, 19 Aug 2020 09:45:13 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.92110.1597854998224602430
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 09:36:41 -0700
X-IronPort-AV: E=Sophos;i="5.76,332,1592838000"; 
   d="scan'208";a="54984473"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2020 01:36:40 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.200])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4BACD400967A;
	Thu, 20 Aug 2020 01:36:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 02/12] arm64: dts: renesas: r8a774b1-hihope-rzg2n[-ex]: Rename HiHope RZ/G2N boards
Date: Wed, 19 Aug 2020 17:36:24 +0100
Message-Id: <20200819163634.5430-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ypidEbCB889o7FBWevla14lSx4520388AA=
Content-Type: multipart/mixed; boundary="m92760l5inklNfxWaNF6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597855513;
 bh=5EHnC0vPC4df11uLcq1b8/rcMjEdVy0ypg8ZQj+998s=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VF5qMEm+zMHbG6j/xe1Dye3ZEOC2jNxsJhCZ+ZbuckDM+q648eOFcWy8XfwkF0fRBwx
 tFU0vpeIJ1XAvgu6/VS5CzkXBY9KUCkzv4Rld8kSMJwIslo1Nsa4vRLkQwTpibx080cmS
 U9zk4w6i/ZrYSJHhWhgEzNyts0MtRe2QAuY=

--m92760l5inklNfxWaNF6

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 59d8eee863ab5936e8fbb9b9b6a26e21d5078229 upstream.

The existing DTS files for HiHope RZ/G2N boards are for Rev.2.0 version
so reflect the same for the DTS file names so that the existing naming
convention can be used for Rev.3.0/4.0 boards.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1593004330-5039-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile                        | 4 ++--
 ...ihope-rzg2n-ex.dts => r8a774b1-hihope-rzg2n-rev2-ex.dts} | 6 +++---
 ...74b1-hihope-rzg2n.dts => r8a774b1-hihope-rzg2n-rev2.dts} | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm64/boot/dts/renesas/{r8a774b1-hihope-rzg2n-ex.dts => r8a774b1-hihope-rzg2n-rev2-ex.dts} (56%)
 rename arch/arm64/boot/dts/renesas/{r8a774b1-hihope-rzg2n.dts => r8a774b1-hihope-rzg2n-rev2.dts} (84%)

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 5230e1ebdfd3..e77140d382ac 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -2,8 +2,8 @@
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
-dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n.dtb
-dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex.dtb
+dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-rev2.dtb
+dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-rev2-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb \
 			       r8a774c0-ek874-idk-2121wr.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dts
similarity index 56%
rename from arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts
rename to arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dts
index ab47c0bd9c19..2e5e1de04049 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex.dts
@@ -1,15 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the HiHope RZ/G2N sub board
+ * Device Tree Source for the HiHope RZ/G2N Rev.2.0 connected to sub board
  *
  * Copyright (C) 2019 Renesas Electronics Corp.
  */
 
-#include "r8a774b1-hihope-rzg2n.dts"
+#include "r8a774b1-hihope-rzg2n-rev2.dts"
 #include "hihope-rzg2-ex.dtsi"
 
 / {
-	model = "HopeRun HiHope RZ/G2N with sub board";
+	model = "HopeRun HiHope RZ/G2N (Rev.2.0) with sub board";
 	compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2n",
 		     "renesas,r8a774b1";
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dts
similarity index 84%
rename from arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts
rename to arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dts
index 9910c1aa0a61..eb1206b2d97a 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the HiHope RZ/G2N main board
+ * Device Tree Source for the HiHope RZ/G2N Rev.2.0 main board
  *
  * Copyright (C) 2019 Renesas Electronics Corp.
  */
@@ -10,7 +10,7 @@
 #include "hihope-common.dtsi"
 
 / {
-	model = "HopeRun HiHope RZ/G2N main board based on r8a774b1";
+	model = "HopeRun HiHope RZ/G2N main board (Rev.2.0) based on r8a774b1";
 	compatible = "hoperun,hihope-rzg2n", "renesas,r8a774b1";
 
 	memory@48000000 {
-- 
2.17.1


--m92760l5inklNfxWaNF6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5152): https://lists.cip-project.org/g/cip-dev/message=
/5152
Mute This Topic: https://lists.cip-project.org/mt/76290782/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--m92760l5inklNfxWaNF6--
