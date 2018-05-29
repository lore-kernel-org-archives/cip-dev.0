From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 29 May 2018 11:08:06 +0100
Subject: [cip-dev] [PATCH] ARM: dts: r8a7743: Add VSP support
Message-ID: <1527588486-4923-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Add VSP support to SoC DT.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
(cherry picked from commit ff9b22610e8c08946f9787d9e0d1a87489624417)
(dropped resets property. changed clocks and power-domains properties.
added vsp device configuration)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
Hello Ben,

this patch applies on top of v4.4.130-cip23.

Thanks,
Fab

 arch/arm/boot/dts/r8a7743.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index eb3cdc8..e8082f8 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1330,6 +1330,48 @@
 			};
 		};
 
+		vsp at fe928000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe928000 0 0x8000>;
+			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7743_CLK_VSP1_S>;
+			power-domains = <&cpg_clocks>;
+
+			renesas,has-lut;
+			renesas,has-sru;
+			renesas,#rpf = <5>;
+			renesas,#uds = <3>;
+			renesas,#wpf = <4>;
+		};
+
+		vsp at fe930000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe930000 0 0x8000>;
+			interrupts = <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7743_CLK_VSP1_DU0>;
+			power-domains = <&cpg_clocks>;
+
+			renesas,has-lif;
+			renesas,has-lut;
+			renesas,#rpf = <4>;
+			renesas,#uds = <1>;
+			renesas,#wpf = <4>;
+		};
+
+		vsp at fe938000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe938000 0 0x8000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7743_CLK_VSP1_DU1>;
+			power-domains = <&cpg_clocks>;
+
+			renesas,has-lif;
+			renesas,has-lut;
+			renesas,#rpf = <4>;
+			renesas,#uds = <1>;
+			renesas,#wpf = <4>;
+		};
+
 		pci0: pci at ee090000 {
 			compatible = "renesas,pci-r8a7743",
 				     "renesas,pci-rcar-gen2";
-- 
2.7.4
