From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:25 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 07/17] ARM: dts: r8a77470: Add USB-DMAC
	device nodes
In-Reply-To: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1566982115-11148-8-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 92c3ccd9b847a6cf130e10aa305e9e349626e4f0 upstream.

This patch adds USB DMAC nodes.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[Reworked clocks and power-domains properties. Removed resets properties]
---
 arch/arm/boot/dts/r8a77470.dtsi | 52 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 524bba6..2c9cd0b 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -279,6 +279,58 @@
 			status = "disabled";
 		};
 
+		usb_dmac00: dma-controller at e65a0000 {
+			compatible = "renesas,r8a77470-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a0000 0 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&mstp3_clks R8A77470_CLK_USBHS_DMAC0_CH0>;
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac10: dma-controller at e65b0000 {
+			compatible = "renesas,r8a77470-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b0000 0 0x100>;
+			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&mstp3_clks R8A77470_CLK_USBHS_DMAC1_CH0>;
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac01: dma-controller at e65a8000 {
+			compatible = "renesas,r8a77470-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65a8000 0 0x100>;
+			interrupts = <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&mstp3_clks R8A77470_CLK_USBHS_DMAC0_CH1>;
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
+		usb_dmac11: dma-controller at e65b8000 {
+			compatible = "renesas,r8a77470-usb-dmac",
+				     "renesas,usb-dmac";
+			reg = <0 0xe65b8000 0 0x100>;
+			interrupts = <GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 292 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "ch0", "ch1";
+			clocks = <&mstp3_clks R8A77470_CLK_USBHS_DMAC1_CH1>;
+			power-domains = <&cpg_clocks>;
+			#dma-cells = <1>;
+			dma-channels = <2>;
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a77470",
 				     "renesas,rcar-dmac";
-- 
2.7.4
