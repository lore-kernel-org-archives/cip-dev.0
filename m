Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4517E92FF7
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 22:39:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53265.1767047973878245967
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 14:39:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: nBqAllsBT6mD+9w41Jumsw==
X-CSE-MsgGUID: kzamhETfSdSOsTlOpyLA3g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Dec 2025 07:39:38 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4354A400A0FF;
	Tue, 30 Dec 2025 07:39:37 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 14/17] arm64: dts: renesas: r9a09g087: Add I2C controller nodes
Date: Mon, 29 Dec 2025 22:39:08 +0000
Message-ID: <20251229223911.8663-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 22:39:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21272

commit 1977f7d0d180621c11af26e96be29cc4e772dcc4 upstream.

The Renesas RZ/N2H ("R9A09G087") SoC includes three I2C (RIIC) channels.
Add device tree nodes for all three I2C controllers to the RZ/N2H SoC
DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250707153533.287832-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 034add1f91a5a..b222f518267e7 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -90,6 +90,51 @@ sci0: serial@80005000 {
 			status = "disabled";
 		};
 
+		i2c0: i2c@80088000 {
+			compatible = "renesas,riic-r9a09g087", "renesas,riic-r9a09g077";
+			reg = <0 0x80088000 0 0x400>;
+			interrupts = <GIC_SPI 614 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 615 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 616 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 617 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eei", "rxi", "txi", "tei";
+			clocks = <&cpg CPG_MOD 100>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@80088400 {
+			compatible = "renesas,riic-r9a09g087", "renesas,riic-r9a09g077";
+			reg = <0 0x80088400 0 0x400>;
+			interrupts = <GIC_SPI 618 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 619 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 620 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 621 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eei", "rxi", "txi", "tei";
+			clocks = <&cpg CPG_MOD 101>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@81008000 {
+			compatible = "renesas,riic-r9a09g087", "renesas,riic-r9a09g077";
+			reg = <0 0x81008000 0 0x400>;
+			interrupts = <GIC_SPI 622 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 623 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 624 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 625 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "eei", "rxi", "txi", "tei";
+			clocks = <&cpg CPG_MOD 601>;
+			power-domains = <&cpg>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@80280000 {
 			compatible = "renesas,r9a09g087-cpg-mssr";
 			reg = <0 0x80280000 0 0x1000>,
-- 
2.43.0


