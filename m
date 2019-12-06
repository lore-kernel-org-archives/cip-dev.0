From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  6 Dec 2019 12:12:18 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 02/12] ARM: dts: r8a7744: Add CAN support
In-Reply-To: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
References: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1575634348-10954-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 56f1896093043c63c6ecd8a53080aa89d6b41070 upstream.

Add the definitions for can0 and can1 to the r8a7744 SoC dtsi.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: Removed reset and updated clk and power domain properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index c73269c..4538689 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -819,13 +819,29 @@
 		};
 
 		can0: can at e6e80000 {
+			compatible = "renesas,can-r8a7744",
+				     "renesas,rcar-gen2-can";
 			reg = <0 0xe6e80000 0 0x1000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7744_CLK_RCAN0>,
+				 <&cpg_clocks R8A7744_CLK_RCAN>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
 		can1: can at e6e88000 {
+			compatible = "renesas,can-r8a7744",
+				     "renesas,rcar-gen2-can";
 			reg = <0 0xe6e88000 0 0x1000>;
-			/* placeholder */
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp9_clks R8A7744_CLK_RCAN1>,
+				 <&cpg_clocks R8A7744_CLK_RCAN>,
+				 <&can_clk>;
+			clock-names = "clkp1", "clkp2", "can_clk";
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
 		};
 
 		rcar_sound: sound at ec500000 {
-- 
2.7.4
