From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 16 Jul 2019 09:15:17 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 06/10] ARM: dts: r8a77470: Add I2C4
	support
In-Reply-To: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
References: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563264921-42973-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 3578859661975f8ccb9d8d49c97784d5ff5467df upstream.

Add I2C4 support to RZ/G1C (a.k.a. r8a77470) SoC specific
device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[Reworked clocks and power-domains properties. Removed resets properties]
---
 arch/arm/boot/dts/r8a77470.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index a10afa2..7b3c4a2 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -211,6 +211,18 @@
 			reg = <0 0xe6300000 0 0x20000>;
 		};
 
+		i2c4: i2c at e6520000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r8a77470",
+				     "renesas,rcar-gen2-i2c";
+			reg = <0 0xe6520000 0 0x40>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A77470_CLK_I2C4>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		dmac0: dma-controller at e6700000 {
 			compatible = "renesas,dmac-r8a77470",
 				     "renesas,rcar-dmac";
-- 
2.7.4
