From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 26 Nov 2019 16:20:30 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 09/10] ARM: dts: r8a7744: USB 2.0 host
	support
In-Reply-To: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
References: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574785231-56219-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit ce28396b7a8621e048cfb8d002bc869b428a905e upstream.

Describe internal PCI bridge devices, USB phy device and
link PCI USB devices to USB phy.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: removed resets property. Updated power-domains and clocks properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 75 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index e020be8..34302d8 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -423,8 +423,25 @@
 		};
 
 		usbphy: usb-phy at e6590100 {
+			compatible = "renesas,usb-phy-r8a7744",
+				     "renesas,rcar-gen2-usb-phy";
 			reg = <0 0xe6590100 0 0x100>;
-			/* placeholder */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&mstp7_clks R8A7744_CLK_HSUSB>;
+			clock-names = "usbhs";
+			power-domains = <&cpg_clocks>;
+
+			status = "disabled";
+
+			usb0: usb-channel at 0 {
+				reg = <0>;
+				#phy-cells = <1>;
+			};
+			usb2: usb-channel at 2 {
+				reg = <2>;
+				#phy-cells = <1>;
+			};
 		};
 
 		dmac0: dma-controller at e6700000 {
@@ -795,23 +812,71 @@
 		};
 
 		pci0: pci at ee090000 {
-			reg = <0 0xee090000 0 0xc00>;
+			compatible = "renesas,pci-r8a7744",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			reg = <0 0xee090000 0 0xc00>,
+			      <0 0xee080000 0 0x1100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7744_CLK_USB_EHCI>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 
 			bus-range = <0 0>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-			/* placeholder */
+			ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
+			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
+					 0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH
+					 0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb at 1,0 {
+				reg = <0x800 0 0 0 0>;
+				phys = <&usb0 0>;
+				phy-names = "usb";
+			};
+
+			usb at 2,0 {
+				reg = <0x1000 0 0 0 0>;
+				phys = <&usb0 0>;
+				phy-names = "usb";
+			};
 		};
 
 		pci1: pci at ee0d0000 {
-			reg = <0 0xee0d0000 0 0xc00>;
+			compatible = "renesas,pci-r8a7744",
+				     "renesas,pci-rcar-gen2";
+			device_type = "pci";
+			reg = <0 0xee0d0000 0 0xc00>,
+			      <0 0xee0c0000 0 0x1100>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7744_CLK_USB_EHCI>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 
 			bus-range = <1 1>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-			/* placeholder */
+			ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
+			interrupt-map-mask = <0xff00 0 0 0x7>;
+			interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+					 0x0800 0 0 1 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH
+					 0x1000 0 0 2 &gic GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+
+			usb at 1,0 {
+				reg = <0x10800 0 0 0 0>;
+				phys = <&usb2 0>;
+				phy-names = "usb";
+			};
+
+			usb at 2,0 {
+				reg = <0x11000 0 0 0 0>;
+				phys = <&usb2 0>;
+				phy-names = "usb";
+			};
 		};
 
 		sdhi0: sd at ee100000 {
-- 
2.7.4
