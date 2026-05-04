Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44C5CD3438
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 06:48:23 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9352.1777877289148751744
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 May 2026 23:48:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 0RUngHdTQuGgTOpJCT/zWQ==
X-CSE-MsgGUID: R8hdHHbtQ2+WtTTUUA3aZg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 May 2026 15:48:13 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2A8654124520;
	Mon,  4 May 2026 15:48:11 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 4/9] arm64: dts: renesas: r9a09g057: Add USB3 PHY/Host nodes
Date: Mon,  4 May 2026 06:47:58 +0000
Message-ID: <20260504064804.7021-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504064804.7021-1-ovidiu.panait.rb@renesas.com>
References: <20260504064804.7021-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 06:48:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22841

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 92279daefc1740961404bca0a7f5149bf6b23dea upstream.

Add USB3 PHY/Host nodes to RZ/V2H(P) ("R9A09G057") SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251119110505.100253-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index df2c6544b784..5ab873a4702e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -1109,6 +1109,66 @@ usb21phyrst: usb21phy-reset@15840000 {
 			status = "disabled";
 		};
 
+		xhci0: usb@15850000 {
+			compatible = "renesas,r9a09g057-xhci", "renesas,r9a09g047-xhci";
+			reg = <0 0x15850000 0 0x10000>;
+			interrupts = <GIC_SPI 759 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 758 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 757 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 756 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 755 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "all", "smi", "hse", "pme", "xhc";
+			clocks = <&cpg CPG_MOD 0xaf>;
+			power-domains = <&cpg>;
+			resets = <&cpg 0xaa>;
+			phys = <&usb3_phy0>, <&usb3_phy0>;
+			phy-names = "usb2-phy", "usb3-phy";
+			status = "disabled";
+		};
+
+		xhci1: usb@15860000 {
+			compatible = "renesas,r9a09g057-xhci", "renesas,r9a09g047-xhci";
+			reg = <0 0x15860000 0 0x10000>;
+			interrupts = <GIC_SPI 764 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 763 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 762 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 761 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 760 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "all", "smi", "hse", "pme", "xhc";
+			clocks = <&cpg CPG_MOD 0xb1>;
+			power-domains = <&cpg>;
+			resets = <&cpg 0xab>;
+			phys = <&usb3_phy1>, <&usb3_phy1>;
+			phy-names = "usb2-phy", "usb3-phy";
+			status = "disabled";
+		};
+
+		usb3_phy0: usb-phy@15870000 {
+			compatible = "renesas,r9a09g057-usb3-phy", "renesas,r9a09g047-usb3-phy";
+			reg = <0 0x15870000 0 0x10000>;
+			clocks = <&cpg CPG_MOD 0xb0>,
+				 <&cpg CPG_CORE R9A09G057_USB3_0_CLKCORE>,
+				 <&cpg CPG_CORE R9A09G057_USB3_0_REF_ALT_CLK_P>;
+			clock-names = "pclk", "core", "ref_alt_clk_p";
+			power-domains = <&cpg>;
+			resets = <&cpg 0xaa>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		usb3_phy1: usb-phy@15880000 {
+			compatible = "renesas,r9a09g057-usb3-phy", "renesas,r9a09g047-usb3-phy";
+			reg = <0 0x15880000 0 0x10000>;
+			clocks = <&cpg CPG_MOD 0xb2>,
+				 <&cpg CPG_CORE R9A09G057_USB3_1_CLKCORE>,
+				 <&cpg CPG_CORE R9A09G057_USB3_1_REF_ALT_CLK_P>;
+			clock-names = "pclk", "core", "ref_alt_clk_p";
+			power-domains = <&cpg>;
+			resets = <&cpg 0xab>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		sdhi0: mmc@15c00000  {
 			compatible = "renesas,sdhi-r9a09g057";
 			reg = <0x0 0x15c00000 0 0x10000>;
-- 
2.34.1


