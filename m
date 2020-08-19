Return-Path: <SRS0=Dnj/=B5=lists.cip-project.org=bounce+64572+5151+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1788C433EC
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A152520888
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="o67Eq7d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A152520888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5151+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KFyjYY4521723xeisAiOTEpI; Wed, 19 Aug 2020 09:45:13 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.92110.1597854998224602430
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 09:36:39 -0700
X-IronPort-AV: E=Sophos;i="5.76,332,1592838000"; 
   d="scan'208";a="54984469"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2020 01:36:38 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.200])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7C8D6400967A;
	Thu, 20 Aug 2020 01:36:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 01/12] arm64: dts: renesas: r8a774a1-hihope-rzg2m[-ex/-ex-idk-1110wr]: Rename HiHope RZ/G2M boards
Date: Wed, 19 Aug 2020 17:36:23 +0100
Message-Id: <20200819163634.5430-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ktXx61KfHWror3A3gfaxPHmHx4520388AA=
Content-Type: multipart/mixed; boundary="gXErqE4ijUEEz4zdXXCx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597855513;
 bh=BM3nOx8Z251L+2sPo3ZhlFJT1iOdxVzyr0aiScliJdA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=o67Eq7d/vklHhZyKSgpZrUAzasu1791IO5xuK7MGl5lIvdJS8560PU4vgzjpxNZxt0E
 g0N0krdHf2Y4kBywzeLZSsZOPSg7wOf0uT48zT6yrEctjAXYG1T1RsrrVXlyogphQSBWw
 W7zwZfP29T/ABF8yWuuzLNGKAecZTH3t5Go=

--gXErqE4ijUEEz4zdXXCx

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a80f301ea69e76f10099626986b4674c6f990a15 upstream.

The existing DTS files for HiHope RZ/G2M boards are for Rev.2.0 version
so reflect the same for the DTS file names so that the existing naming
convention can be used for Rev.3.0/4.0 boards.

While at it also added a comment about switch SW43 to be OFF for pciec1
to be activated.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1593004330-5039-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile                       | 6 +++---
 ...wr.dts => r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dts} | 4 ++--
 ...hope-rzg2m-ex.dts => r8a774a1-hihope-rzg2m-rev2-ex.dts} | 7 ++++---
 ...4a1-hihope-rzg2m.dts => r8a774a1-hihope-rzg2m-rev2.dts} | 4 ++--
 4 files changed, 11 insertions(+), 10 deletions(-)
 rename arch/arm64/boot/dts/renesas/{r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts => r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dts} (86%)
 rename arch/arm64/boot/dts/renesas/{r8a774a1-hihope-rzg2m-ex.dts => r8a774a1-hihope-rzg2m-rev2-ex.dts} (51%)
 rename arch/arm64/boot/dts/renesas/{r8a774a1-hihope-rzg2m.dts => r8a774a1-hihope-rzg2m-rev2.dts} (83%)

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index d22ede9e3ee4..5230e1ebdfd3 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m.dtb
-dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex.dtb
-dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex-idk-1110wr.dtb
+dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2.dtb
+dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex.dtb
+dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb \
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dts
similarity index 86%
rename from arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts
rename to arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dts
index 2ab5edd84e9b..3a1dcc914985 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dts
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the HiHope RZ/G2M sub board connected to an
+ * Device Tree Source for the HiHope RZ/G2M Rev.2.0 sub board connected to an
  * Advantech IDK-1110WR 10.1" LVDS panel
  *
  * Copyright (C) 2020 Renesas Electronics Corp.
  */
 
-#include "r8a774a1-hihope-rzg2m-ex.dts"
+#include "r8a774a1-hihope-rzg2m-rev2-ex.dts"
 #include "rzg2-advantech-idk-1110wr-panel.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex.dts
similarity index 51%
rename from arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
rename to arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex.dts
index c754fca239d9..2221cf6aed21 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex.dts
@@ -1,19 +1,20 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the HiHope RZ/G2M sub board
+ * Device Tree Source for the HiHope RZ/G2M Rev.2.0 connected to sub board
  *
  * Copyright (C) 2019 Renesas Electronics Corp.
  */
 
-#include "r8a774a1-hihope-rzg2m.dts"
+#include "r8a774a1-hihope-rzg2m-rev2.dts"
 #include "hihope-rzg2-ex.dtsi"
 
 / {
-	model = "HopeRun HiHope RZ/G2M with sub board";
+	model = "HopeRun HiHope RZ/G2M (Rev.2.0) with sub board";
 	compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2m",
 		     "renesas,r8a774a1";
 };
 
+/* SW43 should be OFF, if in ON state SATA port will be activated */
 &pciec1 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dts
similarity index 83%
rename from arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts
rename to arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dts
index 96f2fb080a1a..276f449ad14e 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the HiHope RZ/G2M main board
+ * Device Tree Source for the HiHope RZ/G2M Rev.2.0 main board
  *
  * Copyright (C) 2019 Renesas Electronics Corp.
  */
@@ -10,7 +10,7 @@
 #include "hihope-common.dtsi"
 
 / {
-	model = "HopeRun HiHope RZ/G2M main board based on r8a774a1";
+	model = "HopeRun HiHope RZ/G2M main board (Rev.2.0) based on r8a774a1";
 	compatible = "hoperun,hihope-rzg2m", "renesas,r8a774a1";
 
 	memory@48000000 {
-- 
2.17.1


--gXErqE4ijUEEz4zdXXCx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5151): https://lists.cip-project.org/g/cip-dev/message=
/5151
Mute This Topic: https://lists.cip-project.org/mt/76290781/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--gXErqE4ijUEEz4zdXXCx--
