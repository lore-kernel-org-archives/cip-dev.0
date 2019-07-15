From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:48:02 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 3/4] arm64: dts: renesas: r8a774c0: Add
	clkp2 clock to CAN nodes
In-Reply-To: <1563198483-8589-1-git-send-email-biju.das@bp.renesas.com>
References: <1563198483-8589-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563198483-8589-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 036bc85c1d06ef0a0924aed3fbbef8dccb86b9a1 upstream.

According to the latest information, clkp2 is available on RZ/G2.
Modify CAN0 and CAN1 nodes accordingly.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 064fbda..b6f6929 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -969,8 +969,10 @@
 				     "renesas,rcar-gen3-can";
 			reg = <0 0xe6c30000 0 0x1000>;
 			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 916>, <&can_clk>;
-			clock-names = "clkp1", "can_clk";
+			clocks = <&cpg CPG_MOD 916>,
+				 <&cpg CPG_CORE R8A774C0_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets = <&cpg 916>;
 			status = "disabled";
@@ -981,8 +983,10 @@
 				     "renesas,rcar-gen3-can";
 			reg = <0 0xe6c38000 0 0x1000>;
 			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&cpg CPG_MOD 915>, <&can_clk>;
-			clock-names = "clkp1", "can_clk";
+			clocks = <&cpg CPG_MOD 915>,
+				 <&cpg CPG_CORE R8A774C0_CLK_CANFD>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
 			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
 			resets = <&cpg 915>;
 			status = "disabled";
-- 
2.7.4
