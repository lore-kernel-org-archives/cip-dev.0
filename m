From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  6 Mar 2018 11:34:46 +0000
Subject: [cip-dev] [PATCH 6/7] ARM: dts: r8a7743: Add USB-DMAC device nodes
In-Reply-To: <1520336087-12870-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520336087-12870-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520336087-12870-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 310861003a0d59cb410538bcdf73a218157a111d)
(modified clocks and power-domains properties, removed resets property)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 1237746..db00959 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -309,6 +309,30 @@
 			dma-channels = <15>;
 		};
 
+		usb_dmac0: dma-controller at e65a0000 {
+			compatible = "renesas,usb-dmac";
+			reg = <0 0xe65a0000 0 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&mstp3_clks R8A7743_CLK_USBDMAC0>;
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac1: dma-controller at e65b0000 {
+			compatible = "renesas,usb-dmac";
+			reg = <0 0xe65b0000 0 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&mstp3_clks R8A7743_CLK_USBDMAC1>;
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
 		/* The memory map in the User's Manual maps the cores to bus
 		 *  numbers
 		 */
-- 
2.7.4
