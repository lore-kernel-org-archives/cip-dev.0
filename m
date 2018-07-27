From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 27 Jul 2018 17:27:14 +0100
Subject: [cip-dev] [PATCH 1/3] ARM: dts: r8a7745: Add VSP support
In-Reply-To: <1532708836-25349-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532708836-25349-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532708836-25349-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Add VSP support to SoC DT.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 76a2577d97f0b221245e56a17a70bb10a3a97419)
(dropped resets property. changed clocks and power-domains properties.
added vsp device configuration)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 5cafc3060..023d69c 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -1071,6 +1071,34 @@
 			status = "disabled";
 		};
 
+		vsp at fe928000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe928000 0 0x8000>;
+			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7745_CLK_VSP1_SY>;
+			power-domains = <&cpg_clocks>;
+
+			renesas,has-lut;
+			renesas,has-sru;
+			renesas,#rpf = <5>;
+			renesas,#uds = <1>;
+			renesas,#wpf = <4>;
+		};
+
+		vsp at fe930000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe930000 0 0x8000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7745_CLK_VSP1DU0>;
+			power-domains = <&cpg_clocks>;
+
+			renesas,has-lif;
+			renesas,has-lut;
+			renesas,#rpf = <4>;
+			renesas,#uds = <1>;
+			renesas,#wpf = <1>;
+		};
+
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a7745";
 			reg = <0 0xfeb00000 0 0x40000>;
-- 
2.7.4
