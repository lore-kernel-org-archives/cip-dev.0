From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 13:46:57 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 19/22] ARM: dts: r8a77470: Add SDHI2
	support
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574862420-42606-20-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit f068cc816015f8a6af494b584978aa7df96d80fe upstream.

Add SoC specific device tree definitions for the SDHI2 interface.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: Removed reset and updated clk and power domain properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a77470.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 9774ab0..603a57c 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -664,6 +664,20 @@
 			status = "disabled";
 		};
 
+		sdhi2: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a77470",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee160000 0 0x328>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A77470_CLK_SDHI2>;
+			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
+			       <&dmac1 0xd3>, <&dmac1 0xd4>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <97500000>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at f1001000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.7.4
