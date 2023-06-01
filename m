Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CAEC7EE23
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:05:01 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.34590.1685631895345339214
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="161816503"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:54 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DC3F740078AA;
	Fri,  2 Jun 2023 00:04:52 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 16/19] arm64: dts: renesas: r9a09g011: Add USB3 DRD, device and host nodes
Date: Thu,  1 Jun 2023 16:04:07 +0100
Message-Id: <20230601150410.124773-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:05:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11746

commit 670e2a8b9b02ff52c7ca43204459693b3c574b00 upstream.

This patch add usb3 host and peripheral device node as child of usb3 drd
node to RZ/V2M SoC dtsi. The host/device needs to issue reset release on
DRD module before accessing host/device registers.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230121145853.4792-11-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index 4ac8ce594da7..fe9bc7fe1701 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -69,6 +69,51 @@ gic: interrupt-controller@82010000 {
 			clock-names = "clk";
 		};
 
+		usb3drd: usb3drd@85070400 {
+			compatible = "renesas,r9a09g011-usb3drd",
+				     "renesas,rzv2m-usb3drd";
+			reg = <0x0 0x85070400 0x0 0x100>;
+			interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>,
+				      <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "drd", "bc", "gpi";
+			clocks = <&cpg CPG_MOD R9A09G011_USB_ACLK_P>,
+				 <&cpg CPG_MOD R9A09G011_USB_PCLK>;
+			clock-names = "axi", "reg";
+			resets = <&cpg R9A09G011_USB_DRD_RESET>;
+			power-domains = <&cpg>;
+			ranges;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			status = "disabled";
+
+			usb3host: usb@85060000 {
+				compatible = "renesas,r9a09g011-xhci",
+					     "renesas,rzv2m-xhci";
+				reg = <0 0x85060000 0 0x2000>;
+				interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cpg CPG_MOD R9A09G011_USB_ACLK_H>,
+					 <&cpg CPG_MOD R9A09G011_USB_PCLK>;
+				clock-names = "axi", "reg";
+				resets = <&cpg R9A09G011_USB_ARESETN_H>;
+				power-domains = <&cpg>;
+				status = "disabled";
+			};
+
+			usb3peri: usb3peri@85070000 {
+				compatible = "renesas,r9a09g011-usb3-peri",
+					     "renesas,rzv2m-usb3-peri";
+				reg = <0x0 0x85070000 0x0 0x400>;
+				interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cpg CPG_MOD R9A09G011_USB_ACLK_P>,
+					 <&cpg CPG_MOD R9A09G011_USB_PCLK>;
+				clock-names = "axi", "reg";
+				resets = <&cpg R9A09G011_USB_ARESETN_P>;
+				power-domains = <&cpg>;
+				status = "disabled";
+			};
+		};
+
 		avb: ethernet@a3300000 {
 			compatible = "renesas,etheravb-r9a09g011","renesas,etheravb-rzv2m";
 			reg = <0 0xa3300000 0 0x800>;
-- 
2.25.1


