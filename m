From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:37 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 12/17] ARM: dts: r8a7744: Add I2C and
	IIC support
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574175222-52858-13-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit fb64de56dfd9e8efe05d12adca7e2885ce1b9e17 upstream.

Add the I2C[0-5] and IIC[0,1,3] devices nodes to the R8A7744 device tree.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: removed resets property. Updated power-domains and clocks properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 112 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index fdfd099..3f73784 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -285,19 +285,127 @@
 			reg = <0 0xe6300000 0 0x40000>;
 		};
 
+		/* The memory map in the User's Manual maps the cores to
+		 * bus numbers
+		 */
+		i2c0: i2c at e6508000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7744",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6508000 0 0x40>;
+			interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7744_CLK_I2C0>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at e6518000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7744",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6518000 0 0x40>;
+			interrupts = <GIC_SPI 288 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7744_CLK_I2C1>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		i2c2: i2c at e6530000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7744",
+				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6530000 0 0x40>;
-			/* placeholder */
+			interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7744_CLK_I2C2>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at e6540000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7744",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6540000 0 0x40>;
+			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7744_CLK_I2C3>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		i2c4: i2c at e6520000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7744",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6520000 0 0x40>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7744_CLK_I2C4>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
 		i2c5: i2c at e6528000 {
 			/* doesn't need pinmux */
 			#address-cells = <1>;
 			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a7744",
+				     "renesas,rcar-gen2-i2c";
 			reg = <0 0xe6528000 0 0x40>;
-			/* placeholder */
+			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7744_CLK_I2C5>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		iic0: i2c at e6500000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7744",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6500000 0 0x425>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7744_CLK_IIC0>;
+			dmas = <&dmac0 0x61>, <&dmac0 0x62>,
+			       <&dmac1 0x61>, <&dmac1 0x62>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		iic1: i2c at e6510000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7744",
+				     "renesas,rcar-gen2-iic",
+				     "renesas,rmobile-iic";
+			reg = <0 0xe6510000 0 0x425>;
+			interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7744_CLK_IIC1>;
+			dmas = <&dmac0 0x65>, <&dmac0 0x66>,
+			       <&dmac1 0x65>, <&dmac1 0x66>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
+		iic3: i2c at e60b0000 {
+			/* doesn't need pinmux */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,iic-r8a7744";
+			reg = <0 0xe60b0000 0 0x425>;
+			interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7744_CLK_IICDVFS>;
+			dmas = <&dmac0 0x77>, <&dmac0 0x78>,
+			       <&dmac1 0x77>, <&dmac1 0x78>;
+			dma-names = "tx", "rx", "tx", "rx";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
 		hsusb: usb at e6590000 {
-- 
2.7.4
