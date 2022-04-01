Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606CAC64EAE
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.3568.1648842202850727941
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:43:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200";
   d="scan'208";a="115453891"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2022 04:43:42 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 17EE840061B8;
	Sat,  2 Apr 2022 04:43:40 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 38/40] arm64: dts: renesas: r9a07g044: Add
 SDHI nodes
Date: Fri,  1 Apr 2022 20:42:32 +0100
Message-Id: <20220401194234.14057-39-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7949

From: Biju Das <biju.das.jz@bp.renesas.com>

commit a83ad872f4ba6b9fbf81b9f70d6ff6d61d74bf7e upstream.

Add SDHI{0, 1} nodes to RZ/G2L SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20211007155451.10654-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index ebe155ccd721..468a3d8cbd1f 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -460,6 +460,38 @@
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
 		};
 
+		sdhi0: mmc@11c00000  {
+			compatible = "renesas,sdhi-r9a07g044",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x11c00000 0 0x10000>;
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G044_SDHI0_IMCLK>,
+				 <&cpg CPG_MOD R9A07G044_SDHI0_IMCLK2>,
+				 <&cpg CPG_MOD R9A07G044_SDHI0_CLK_HS>,
+				 <&cpg CPG_MOD R9A07G044_SDHI0_ACLK>;
+			clock-names = "imclk", "imclk2", "clk_hs", "aclk";
+			resets = <&cpg R9A07G044_SDHI0_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		sdhi1: mmc@11c10000 {
+			compatible = "renesas,sdhi-r9a07g044",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0x0 0x11c10000 0 0x10000>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G044_SDHI1_IMCLK>,
+				 <&cpg CPG_MOD R9A07G044_SDHI1_IMCLK2>,
+				 <&cpg CPG_MOD R9A07G044_SDHI1_CLK_HS>,
+				 <&cpg CPG_MOD R9A07G044_SDHI1_ACLK>;
+			clock-names = "imclk", "imclk2", "clk_hs", "aclk";
+			resets = <&cpg R9A07G044_SDHI1_IXRST>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		eth0: ethernet@11c20000 {
 			compatible = "renesas,r9a07g044-gbeth",
 				     "renesas,rzg2l-gbeth";
-- 
2.17.1


