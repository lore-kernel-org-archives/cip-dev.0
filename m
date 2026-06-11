Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283BACD98CC
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:46:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.42675.1781174765584504128
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:46:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 64B7440E8A;
	Thu, 11 Jun 2026 10:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAEA1F00893;
	Thu, 11 Jun 2026 10:46:03 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 19/21] arm64: dts: renesas: r9a08g045: Add USB support
Date: Thu, 11 Jun 2026 13:45:29 +0300
Message-ID: <20260611104532.2532863-20-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:46:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23108

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c837ad879e7110227bac0096a32a7c610e430a8e upstream.

Add USB nodes for the Renesas RZ/G3S SoC. This consists of PHY reset,
host and device support.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251023135810.1688415-7-claudiu.beznea.uj=
@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict with the PCIe node by keeping both PCIe
 and USB nodes and moving the PCIe after USB node to maintain the
 sorting by block address]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 118 +++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot=
/dts/renesas/r9a08g045.dtsi
index df17dd219e91..10a0813a9781 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -691,6 +691,124 @@ eth1: ethernet@11c40000 {
 			status =3D "disabled";
 		};
=20
+		phyrst: usbphy-ctrl@11e00000 {
+			compatible =3D "renesas,r9a08g045-usbphy-ctrl";
+			reg =3D <0 0x11e00000 0 0x10000>;
+			clocks =3D <&cpg CPG_MOD R9A08G045_USB_PCLK>;
+			resets =3D <&cpg R9A08G045_USB_PRESETN>;
+			power-domains =3D <&cpg>;
+			#reset-cells =3D <1>;
+			renesas,sysc-pwrrdy =3D <&sysc 0xd70 0x1>;
+			status =3D "disabled";
+
+			usb0_vbus_otg: regulator-vbus {
+				regulator-name =3D "vbus";
+			};
+		};
+
+		ohci0: usb@11e10000 {
+			compatible =3D "generic-ohci";
+			reg =3D <0 0x11e10000 0 0x100>;
+			interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2H0_HCLK>;
+			resets =3D <&phyrst 0>,
+				 <&cpg R9A08G045_USB_U2H0_HRESETN>;
+			phys =3D <&usb2_phy0 1>;
+			phy-names =3D "usb";
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+		};
+
+		ohci1: usb@11e30000 {
+			compatible =3D "generic-ohci";
+			reg =3D <0 0x11e30000 0 0x100>;
+			interrupts =3D <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2H1_HCLK>;
+			resets =3D <&phyrst 1>,
+				 <&cpg R9A08G045_USB_U2H1_HRESETN>;
+			phys =3D <&usb2_phy1 1>;
+			phy-names =3D "usb";
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+		};
+
+		ehci0: usb@11e10100 {
+			compatible =3D "generic-ehci";
+			reg =3D <0 0x11e10100 0 0x100>;
+			interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2H0_HCLK>;
+			resets =3D <&phyrst 0>,
+				 <&cpg R9A08G045_USB_U2H0_HRESETN>;
+			phys =3D <&usb2_phy0 2>;
+			phy-names =3D "usb";
+			companion =3D <&ohci0>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+		};
+
+		ehci1: usb@11e30100 {
+			compatible =3D "generic-ehci";
+			reg =3D <0 0x11e30100 0 0x100>;
+			interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2H1_HCLK>;
+			resets =3D <&phyrst 1>,
+				 <&cpg R9A08G045_USB_U2H1_HRESETN>;
+			phys =3D <&usb2_phy1 2>;
+			phy-names =3D "usb";
+			companion =3D <&ohci1>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+		};
+
+		usb2_phy0: usb-phy@11e10200 {
+			compatible =3D "renesas,usb2-phy-r9a08g045";
+			reg =3D <0 0x11e10200 0 0x700>;
+			interrupts =3D <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2H0_HCLK>;
+			resets =3D <&phyrst 0>,
+				 <&cpg R9A08G045_USB_U2H0_HRESETN>;
+			#phy-cells =3D <1>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+		};
+
+		usb2_phy1: usb-phy@11e30200 {
+			compatible =3D "renesas,usb2-phy-r9a08g045";
+			reg =3D <0 0x11e30200 0 0x700>;
+			interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2H1_HCLK>;
+			resets =3D <&phyrst 1>,
+				 <&cpg R9A08G045_USB_U2H1_HRESETN>;
+			#phy-cells =3D <1>;
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+		};
+
+		hsusb: usb@11e20000 {
+			compatible =3D "renesas,usbhs-r9a08g045",
+				     "renesas,rzg2l-usbhs";
+			reg =3D <0 0x11e20000 0 0x10000>;
+			interrupts =3D <GIC_SPI 85 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&cpg CPG_MOD R9A08G045_USB_PCLK>,
+				 <&cpg CPG_MOD R9A08G045_USB_U2P_EXR_CPUCLK>;
+			resets =3D <&phyrst 0>,
+				 <&cpg R9A08G045_USB_U2P_EXL_SYSRST>;
+			renesas,buswait =3D <7>;
+			phys =3D <&usb2_phy0 3>;
+			phy-names =3D "usb";
+			power-domains =3D <&cpg>;
+			status =3D "disabled";
+		};
+
 		pcie: pcie@11e40000 {
 			compatible =3D "renesas,r9a08g045-pcie";
 			reg =3D <0 0x11e40000 0 0x10000>;
--=20
2.43.0


