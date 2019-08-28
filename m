From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:26 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 08/17] ARM: dts: r8a77470: Add USB PHY
	DT support
In-Reply-To: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1566982115-11148-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 1a675db44002ed9674d6e534b1400a9d756ef34b upstream.

Define the r8a77470 generic part of the USB PHY device node.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[Reworked clocks and power-domains properties. Removed resets properties
 Added usb2_host regname]
---
 arch/arm/boot/dts/r8a77470.dtsi | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 2c9cd0b..e407954 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -279,6 +279,40 @@
 			status = "disabled";
 		};
 
+		usbphy0: usb-phy at e6590100 {
+			compatible = "renesas,usb-phy-r8a77470",
+				     "renesas,rcar-gen2-usb-phy";
+			reg = <0 0xe6590100 0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&mstp7_clks R8A77470_CLK_USBHS0>;
+			clock-names = "usbhs";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+
+			usb0: usb-channel at 0 {
+				reg = <0>;
+				#phy-cells = <1>;
+			};
+		};
+
+		usbphy1: usb-phy at e6598100 {
+			compatible = "renesas,usb-phy-r8a77470",
+				     "renesas,rcar-gen2-usb-phy";
+			reg = <0 0xe6598100 0 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&mstp7_clks R8A77470_CLK_USBHS1>;
+			clock-names = "usbhs";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+
+			usb1: usb-channel at 0 {
+				reg = <0>;
+				#phy-cells = <1>;
+			};
+		};
+
 		usb_dmac00: dma-controller at e65a0000 {
 			compatible = "renesas,r8a77470-usb-dmac",
 				     "renesas,usb-dmac";
@@ -522,6 +556,26 @@
 			status = "disabled";
 		};
 
+		usb2_phy0: usb-phy at ee080200 {
+			compatible = "renesas,usb2-phy-r8a77470";
+			reg = <0 0xee080200 0 0x700>;
+			reg-names = "usb2_host";
+			clocks = <&mstp7_clks R8A77470_CLK_USB_EHCI_0>;
+			power-domains = <&cpg_clocks>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		usb2_phy1: usb-phy at ee0c0200 {
+			compatible = "renesas,usb2-phy-r8a77470";
+			reg = <0 0xee0c0200 0 0x700>;
+			reg-names = "usb2_host";
+			clocks = <&mstp7_clks R8A77470_CLK_USB_EHCI_1>;
+			power-domains = <&cpg_clocks>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at f1001000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.7.4
