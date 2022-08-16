Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B4AC32773
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 12:35:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.14837.1660653273153913362
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 05:35:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,240,1654527600";
   d="scan'208";a="129665756"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 21:35:01 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A4995402D0AB;
	Tue, 16 Aug 2022 21:34:59 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 27/31] arm64: dts: renesas: r9a07g054: Add USB2.0
 phy and host support
Date: Tue, 16 Aug 2022 13:34:02 +0100
Message-Id: <20220816123406.27553-28-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 12:35:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9246

commit a8e2a77b644ac23319f0e7c3e8d9dcd6dc9aebd1 upstream.

Add USB2.0 phy and host support to RZ/V2L (R9A07G054) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220227203744.18355-11-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 74 ++++++++++++++++++++--
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index e3a9f78b7fb8..7d9ea17352a4 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -652,38 +652,98 @@
 		};
 
 		phyrst: usbphy-ctrl@11c40000 {
+			compatible = "renesas,r9a07g054-usbphy-ctrl",
+				     "renesas,rzg2l-usbphy-ctrl";
 			reg = <0 0x11c40000 0 0x10000>;
-			/* place holder */
+			clocks = <&cpg CPG_MOD R9A07G054_USB_PCLK>;
+			resets = <&cpg R9A07G054_USB_PRESETN>;
+			power-domains = <&cpg>;
+			#reset-cells = <1>;
+			status = "disabled";
 		};
 
 		ohci0: usb@11c50000 {
+			compatible = "generic-ohci";
 			reg = <0 0x11c50000 0 0x100>;
-			/* place holder */
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G054_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_USB_U2H0_HCLK>;
+			resets = <&phyrst 0>,
+				 <&cpg R9A07G054_USB_U2H0_HRESETN>;
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
+			clocks = <&cpg CPG_MOD R9A07G054_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_USB_U2H1_HCLK>;
+			resets = <&phyrst 1>,
+				 <&cpg R9A07G054_USB_U2H1_HRESETN>;
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
+			clocks = <&cpg CPG_MOD R9A07G054_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_USB_U2H0_HCLK>;
+			resets = <&phyrst 0>,
+				 <&cpg R9A07G054_USB_U2H0_HRESETN>;
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
+			clocks = <&cpg CPG_MOD R9A07G054_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_USB_U2H1_HCLK>;
+			resets = <&phyrst 1>,
+				 <&cpg R9A07G054_USB_U2H1_HRESETN>;
+			phys = <&usb2_phy1 2>;
+			phy-names = "usb";
+			companion = <&ohci1>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		usb2_phy0: usb-phy@11c50200 {
+			compatible = "renesas,usb2-phy-r9a07g054",
+				     "renesas,rzg2l-usb2-phy";
 			reg = <0 0x11c50200 0 0x700>;
-			/* place holder */
+			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G054_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_USB_U2H0_HCLK>;
+			resets = <&phyrst 0>;
+			#phy-cells = <1>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		usb2_phy1: usb-phy@11c70200 {
+			compatible = "renesas,usb2-phy-r9a07g054",
+				     "renesas,rzg2l-usb2-phy";
 			reg = <0 0x11c70200 0 0x700>;
-			/* place holder */
+			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G054_USB_PCLK>,
+				 <&cpg CPG_MOD R9A07G054_USB_U2H1_HCLK>;
+			resets = <&phyrst 1>;
+			#phy-cells = <1>;
+			power-domains = <&cpg>;
+			status = "disabled";
 		};
 
 		hsusb: usb@11c60000 {
-- 
2.17.1


