Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3ACC352A8
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:41 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.34415.1649075760888079755
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Apr 2022 05:36:21 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,234,1643641200";
   d="scan'208";a="116695178"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Apr 2022 21:36:20 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9247C4226B03;
	Mon,  4 Apr 2022 21:36:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 19/29] arm64: dts: renesas: r9a07g044: Add WDT
 nodes
Date: Mon,  4 Apr 2022 13:35:43 +0100
Message-Id: <20220404123553.25851-20-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7982

From: Biju Das <biju.das.jz@bp.renesas.com>

commit eb7621ce3362639025e7db125559e235a76d814f upstream.

Add WDT{0, 1, 2} nodes to RZ/G2L SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211123141420.23529-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 26f95ccb4258..f281d8a55044 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -694,6 +694,51 @@
 			status = "disabled";
 		};
 
+		wdt0: watchdog@12800800 {
+			compatible = "renesas,r9a07g044-wdt",
+				     "renesas,rzg2l-wdt";
+			reg = <0 0x12800800 0 0x400>;
+			clocks = <&cpg CPG_MOD R9A07G044_WDT0_PCLK>,
+				 <&cpg CPG_MOD R9A07G044_WDT0_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A07G044_WDT0_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt1: watchdog@12800c00 {
+			compatible = "renesas,r9a07g044-wdt",
+				     "renesas,rzg2l-wdt";
+			reg = <0 0x12800C00 0 0x400>;
+			clocks = <&cpg CPG_MOD R9A07G044_WDT1_PCLK>,
+				 <&cpg CPG_MOD R9A07G044_WDT1_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A07G044_WDT1_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt2: watchdog@12800400 {
+			compatible = "renesas,r9a07g044-wdt",
+				     "renesas,rzg2l-wdt";
+			reg = <0 0x12800400 0 0x400>;
+			clocks = <&cpg CPG_MOD R9A07G044_WDT2_PCLK>,
+				 <&cpg CPG_MOD R9A07G044_WDT2_CLK>;
+			clock-names = "pclk", "oscclk";
+			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "wdt", "perrout";
+			resets = <&cpg R9A07G044_WDT2_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		ostm0: timer@12801000 {
 			compatible = "renesas,r9a07g044-ostm",
 				     "renesas,ostm";
-- 
2.17.1


