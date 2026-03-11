Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BD61062891
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 12:36:54 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19921.1773232604814425154
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 05:36:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: NoYZxMA2Soy3qbs7F150FA==
X-CSE-MsgGUID: FjaSXMwESPW1uYK6PMXU9A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Mar 2026 21:36:43 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.227])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A6E6A400F2D4;
	Wed, 11 Mar 2026 21:36:42 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/2] arm64: dts: renesas: r9a09g087: Add DT nodes for SCI channels 1-5
Date: Wed, 11 Mar 2026 12:36:38 +0000
Message-ID: <20260311123638.25773-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311123638.25773-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260311123638.25773-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 12:36:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22342

commit 41e194978510a9910be2ed7b4d8b4edb61671a90 upstream.

The RZ/N2H SoC exposes six SCI controllers; sci0 was already present in
the SoC DTSI. Add the remaining SCI nodes (sci1-sci5).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250812200344.3253781-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually fixed merge conflicts]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index c056c476e0d7f..47a9888e227dc 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -90,6 +90,76 @@ sci0: serial@80005000 {
 			status = "disabled";
 		};
 
+		sci1: serial@80005400 {
+			compatible = "renesas,r9a09g087-rsci", "renesas,r9a09g077-rsci";
+			reg = <0 0x80005400 0 0x400>;
+			interrupts = <GIC_SPI 594 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 595 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 596 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 597 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei";
+			clocks = <&cpg CPG_MOD 9>, <&cpg CPG_CORE R9A09G087_CLK_PCLKM>;
+			clock-names = "operation", "bus";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		sci2: serial@80005800 {
+			compatible = "renesas,r9a09g087-rsci", "renesas,r9a09g077-rsci";
+			reg = <0 0x80005800 0 0x400>;
+			interrupts = <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 599 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 600 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei";
+			clocks = <&cpg CPG_MOD 10>, <&cpg CPG_CORE R9A09G087_CLK_PCLKM>;
+			clock-names = "operation", "bus";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		sci3: serial@80005c00 {
+			compatible = "renesas,r9a09g087-rsci", "renesas,r9a09g077-rsci";
+			reg = <0 0x80005c00 0 0x400>;
+			interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 603 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 604 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei";
+			clocks = <&cpg CPG_MOD 11>, <&cpg CPG_CORE R9A09G087_CLK_PCLKM>;
+			clock-names = "operation", "bus";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		sci4: serial@80006000 {
+			compatible = "renesas,r9a09g087-rsci", "renesas,r9a09g077-rsci";
+			reg = <0 0x80006000 0 0x400>;
+			interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 607 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 608 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 609 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei";
+			clocks = <&cpg CPG_MOD 12>, <&cpg CPG_CORE R9A09G087_CLK_PCLKM>;
+			clock-names = "operation", "bus";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		sci5: serial@81005000 {
+			compatible = "renesas,r9a09g087-rsci", "renesas,r9a09g077-rsci";
+			reg = <0 0x81005000 0 0x400>;
+			interrupts = <GIC_SPI 610 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 611 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 612 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 613 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eri", "rxi", "txi", "tei";
+			clocks = <&cpg CPG_MOD 600>, <&cpg CPG_CORE R9A09G087_CLK_PCLKM>;
+			clock-names = "operation", "bus";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		rspi0: spi@80007000 {
 			compatible = "renesas,r9a09g087-rspi", "renesas,r9a09g077-rspi";
 			reg = <0x0 0x80007000 0x0 0x400>;
-- 
2.43.0


