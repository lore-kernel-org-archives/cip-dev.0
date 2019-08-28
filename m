From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:27 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 09/17] ARM: dts: r8a77470: Add USB2.0
	Host (EHCI/OHCI) device
In-Reply-To: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1566982115-11148-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit ce5940798cf1eb1ba70e94702cbb334ca370f96b upstream.

Define the r8a77470 generic part of the USB2.0 Host Controller device
nodes (ehci[01]/ohci[01]).

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[Reworked clocks and power-domains properties. Removed resets properties]
---
 arch/arm/boot/dts/r8a77470.dtsi | 46 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index e407954..36538c8 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -556,6 +556,29 @@
 			status = "disabled";
 		};
 
+		ohci0: usb at ee080000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee080000 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A77470_CLK_USB_EHCI_0>;
+			phys = <&usb0 0>, <&usb2_phy0>;
+			phy-names = "usb";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		ehci0: usb at ee080100 {
+			compatible = "generic-ehci";
+			reg = <0 0xee080100 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A77470_CLK_USB_EHCI_0>;
+			phys = <&usb0 0>, <&usb2_phy0>;
+			phy-names = "usb";
+			companion = <&ohci0>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		usb2_phy0: usb-phy at ee080200 {
 			compatible = "renesas,usb2-phy-r8a77470";
 			reg = <0 0xee080200 0 0x700>;
@@ -566,6 +589,29 @@
 			status = "disabled";
 		};
 
+		ohci1: usb at ee0c0000 {
+			compatible = "generic-ohci";
+			reg = <0 0xee0c0000 0 0x100>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A77470_CLK_USB_EHCI_1>;
+			phys = <&usb0 1>, <&usb2_phy1>, <&usb1 0>;
+			phy-names = "usb";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		ehci1: usb at ee0c0100 {
+			compatible = "generic-ehci";
+			reg = <0 0xee0c0100 0 0x100>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A77470_CLK_USB_EHCI_1>;
+			phys = <&usb0 1>, <&usb2_phy1>, <&usb1 0>;
+			phy-names = "usb";
+			companion = <&ohci1>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		usb2_phy1: usb-phy at ee0c0200 {
 			compatible = "renesas,usb2-phy-r8a77470";
 			reg = <0 0xee0c0200 0 0x700>;
-- 
2.7.4
