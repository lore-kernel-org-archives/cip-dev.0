From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 26 Nov 2019 16:20:31 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 10/10] ARM: dts: r8a7744: Add USB-DMAC
	and HSUSB device nodes
In-Reply-To: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
References: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574785231-56219-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit a5d56930c703ddbdd8712553247c38ec6f406b74 upstream.

Add usb dmac and hsusb device nodes on RZ/G1N SoC dtsi.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: removed resets property. Updated power-domains and clocks properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 34302d8..c73269c 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -418,8 +418,19 @@
 		};
 
 		hsusb: usb at e6590000 {
+			compatible = "renesas,usbhs-r8a7744",
+				     "renesas,rcar-gen2-usbhs";
 			reg = <0 0xe6590000 0 0x100>;
-			/* placeholder */
+			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7744_CLK_HSUSB>;
+			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
+			       <&usb_dmac1 0>, <&usb_dmac1 1>;
+			dma-names = "ch0", "ch1", "ch2", "ch3";
+			power-domains = <&cpg_clocks>;
+			renesas,buswait = <4>;
+			phys = <&usb0 1>;
+			phy-names = "usb";
+			status = "disabled";
 		};
 
 		usbphy: usb-phy at e6590100 {
@@ -444,6 +455,32 @@
 			};
 		};
 
+		usb_dmac0: dma-controller at e65a0000 {
+			compatible = "renesas,r8a7744-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a0000 0 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&mstp3_clks R8A7744_CLK_USBDMAC0>;
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac1: dma-controller at e65b0000 {
+			compatible = "renesas,r8a7744-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b0000 0 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&mstp3_clks R8A7744_CLK_USBDMAC1>;
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a7744",
 				     "renesas,rcar-dmac";
-- 
2.7.4
