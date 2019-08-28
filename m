From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:34 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 16/17] ARM: dts: r8a77470: Add HSUSB
	device nodes
In-Reply-To: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1566982115-11148-17-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 307ca5cf4778b6bf0d2a025b0e4f653742214de8 upstream.

Define the r8a77470 generic part of the HSUSB0/1 device nodes.

Currently the renesas_usbhs driver doesn't handle multiple phys and we
don't have a proper hardware to validate such driver changes.

So for hsusb1 it is assumed that usbphy0 will be enabled by either
channel0 host or device.

In future, if any boards support hsusb1, we will need to add multiple phy
support in the renesas_usbhs driver and override the board dts to enable
the same.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[Reworked clocks and power-domains properties. Removed resets properties]
---
 arch/arm/boot/dts/r8a77470.dtsi | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 36538c8..568f650 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -279,6 +279,22 @@
 			status = "disabled";
 		};
 
+		hsusb0: hsusb at e6590000 {
+			compatible = "renesas,usbhs-r8a77470",
+				     "renesas,rcar-gen2-usbhs";
+			reg = <0 0xe6590000 0 0x100>;
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A77470_CLK_USBHS0>;
+			dmas = <&usb_dmac00 0>, <&usb_dmac00 1>,
+			       <&usb_dmac10 0>, <&usb_dmac10 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
+			renesas,buswait = <4>;
+			phys = <&usb0 1>;
+			phy-names = "usb";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		usbphy0: usb-phy at e6590100 {
 			compatible = "renesas,usb-phy-r8a77470",
 				     "renesas,rcar-gen2-usb-phy";
@@ -296,6 +312,23 @@
 			};
 		};
 
+		hsusb1: hsusb at e6598000 {
+			compatible = "renesas,usbhs-r8a77470",
+				     "renesas,rcar-gen2-usbhs";
+			reg = <0 0xe6598000 0 0x100>;
+			interrupts = <GIC_SPI 291 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A77470_CLK_USBHS1>;
+			dmas = <&usb_dmac01 0>, <&usb_dmac01 1>,
+			       <&usb_dmac11 0>, <&usb_dmac11 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
+			renesas,buswait = <4>;
+			/* We need to turn on usbphy0 to make usbphy1 to work */
+			phys = <&usb1 1>;
+			phy-names = "usb";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		usbphy1: usb-phy at e6598100 {
 			compatible = "renesas,usb-phy-r8a77470",
 				     "renesas,rcar-gen2-usb-phy";
-- 
2.7.4
