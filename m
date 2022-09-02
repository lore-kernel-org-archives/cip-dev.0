Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031D2C38145
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:44:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.4674.1662111876828858051
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:44:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="131460950"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Sep 2022 18:44:48 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A6010400A11F;
	Fri,  2 Sep 2022 18:44:46 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/25] arm64: dts: renesas: r9a07g043: Add USB2.0
 support
Date: Fri,  2 Sep 2022 10:44:09 +0100
Message-Id: <20220902094427.116227-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:44:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9433

commit f52e14095e56ab6470d959f08e40aa2e45cb85cd upstream.

Add USB2.0 host and device support by filling usb phy control,
phy, device and host stub nodes in RZ/G2UL SoC dtsi.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220425170530.200921-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 90 ++++++++++++++++++++--
 1 file changed, 82 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index ef8550a2de09..8bcda969d130 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -551,43 +551,117 @@ eth1: ethernet@11c30000 {
 		};
 
 		phyrst: usbphy-ctrl@11c40000 {
+			compatible = "renesas,r9a07g043-usbphy-ctrl",
+				     "renesas,rzg2l-usbphy-ctrl";
 			reg = <0 0x11c40000 0 0x10000>;
-			/* place holder */
+			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>;
+			resets = <&cpg R9A07G043_USB_PRESETN>;
+			power-domains = <&cpg>;
+			#reset-cells = <1>;
+			status = "disabled";
 		};
 
 		ohci0: usb@11c50000 {
+			compatible = "generic-ohci";
 			reg = <0 0x11c50000 0 0x100>;
-			/* place holder */
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G043_USB_U2H0_HCLK>;
+			resets = <&phyrst 0>,
+				 <&cpg R9A07G043_USB_U2H0_HRESETN>;
+			phys = <&usb2_phy0 1>;
+			phy-names = "usb";
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		ohci1: usb@11c70000 {
+			compatible = "generic-ohci";
 			reg = <0 0x11c70000 0 0x100>;
-			/* place holder */
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G043_USB_U2H1_HCLK>;
+			resets = <&phyrst 1>,
+				 <&cpg R9A07G043_USB_U2H1_HRESETN>;
+			phys = <&usb2_phy1 1>;
+			phy-names = "usb";
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		ehci0: usb@11c50100 {
+			compatible = "generic-ehci";
 			reg = <0 0x11c50100 0 0x100>;
-			/* place holder */
+			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G043_USB_U2H0_HCLK>;
+			resets = <&phyrst 0>,
+				 <&cpg R9A07G043_USB_U2H0_HRESETN>;
+			phys = <&usb2_phy0 2>;
+			phy-names = "usb";
+			companion = <&ohci0>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		ehci1: usb@11c70100 {
+			compatible = "generic-ehci";
 			reg = <0 0x11c70100 0 0x100>;
-			/* place holder */
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G043_USB_U2H1_HCLK>;
+			resets = <&phyrst 1>,
+				 <&cpg R9A07G043_USB_U2H1_HRESETN>;
+			phys = <&usb2_phy1 2>;
+			phy-names = "usb";
+			companion = <&ohci1>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		usb2_phy0: usb-phy@11c50200 {
+			compatible = "renesas,usb2-phy-r9a07g043",
+				     "renesas,rzg2l-usb2-phy";
 			reg = <0 0x11c50200 0 0x700>;
-			/* place holder */
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G043_USB_U2H0_HCLK>;
+			resets = <&phyrst 0>;
+			#phy-cells = <1>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		usb2_phy1: usb-phy@11c70200 {
+			compatible = "renesas,usb2-phy-r9a07g043",
+				     "renesas,rzg2l-usb2-phy";
 			reg = <0 0x11c70200 0 0x700>;
-			/* place holder */
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G043_USB_U2H1_HCLK>;
+			resets = <&phyrst 1>;
+			#phy-cells = <1>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		hsusb: usb@11c60000 {
+			compatible = "renesas,usbhs-r9a07g043",
+				     "renesas,rza2-usbhs";
 			reg = <0 0x11c60000 0 0x10000>;
-			/* place holder */
+			interrupts = <GIC_SPI 100 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G043_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G043_USB_U2P_EXR_CPUCLK>;
+			resets = <&phyrst 0>,
+				 <&cpg R9A07G043_USB_U2P_EXL_SYSRST>;
+			renesas,buswait = <7>;
+			phys = <&usb2_phy0 3>;
+			phy-names = "usb";
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		wdt0: watchdog@12800800 {
-- 
2.25.1


