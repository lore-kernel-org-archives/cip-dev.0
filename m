From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Fri, 24 Jan 2020 09:08:11 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 01/10] ARM: dts: r8a7744: Add VSP support
In-Reply-To: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1579856900-21381-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit eddcbe813dd3c8247840859bf4d04b3423d35f8f upstream.

Add VSP support to SoC DT.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(dropped resets property. changed clocks and power-domains properties.
added vsp device configuration)
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 91e032a..cf7d8fe 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -1277,6 +1277,48 @@
 			power-domains = <&cpg_clocks>;
 		};
 
+		vsp at fe928000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe928000 0 0x8000>;
+			interrupts = <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7744_CLK_VSP1_S>;
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
+			clocks = <&mstp1_clks R8A7744_CLK_VSP1_DU0>;
+			power-domains = <&cpg_clocks>;
+
+			renesas,has-lif;
+			renesas,has-lut;
+			renesas,#rpf = <4>;
+			renesas,#uds = <1>;
+			renesas,#wpf = <1>;
+		};
+
+		vsp at fe938000 {
+			compatible = "renesas,vsp1";
+			reg = <0 0xfe938000 0 0x8000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7744_CLK_VSP1_DU1>;
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
 			compatible = "renesas,du-r8a7744";
 			reg = <0 0xfeb00000 0 0x40000>,
-- 
2.7.4
