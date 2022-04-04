Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A96C38A2D
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.34385.1649075759683192518
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Apr 2022 05:36:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,234,1643641200";
   d="scan'208";a="115672014"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Apr 2022 21:36:17 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 025864222E7D;
	Mon,  4 Apr 2022 21:36:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 17/29] arm64: dts: renesas: r9a07g044: Add OSTM
 nodes
Date: Mon,  4 Apr 2022 13:35:41 +0100
Message-Id: <20220404123553.25851-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7980

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 59a7d68b69846ac012c33c1ac425b9388661d1f2 upstream.

Add OSTM{0,1,2} nodes to RZ/G2L SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211118191826.2026-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 741621dcbbf7..26f95ccb4258 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -693,6 +693,39 @@
 			power-domains = <&cpg>;
 			status = "disabled";
 		};
+
+		ostm0: timer@12801000 {
+			compatible = "renesas,r9a07g044-ostm",
+				     "renesas,ostm";
+			reg = <0x0 0x12801000 0x0 0x400>;
+			interrupts = <GIC_SPI 46 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G044_OSTM0_PCLK>;
+			resets = <&cpg R9A07G044_OSTM0_PRESETZ>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm1: timer@12801400 {
+			compatible = "renesas,r9a07g044-ostm",
+				     "renesas,ostm";
+			reg = <0x0 0x12801400 0x0 0x400>;
+			interrupts = <GIC_SPI 47 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G044_OSTM1_PCLK>;
+			resets = <&cpg R9A07G044_OSTM1_PRESETZ>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		ostm2: timer@12801800 {
+			compatible = "renesas,r9a07g044-ostm",
+				     "renesas,ostm";
+			reg = <0x0 0x12801800 0x0 0x400>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&cpg CPG_MOD R9A07G044_OSTM2_PCLK>;
+			resets = <&cpg R9A07G044_OSTM2_PRESETZ>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.17.1


