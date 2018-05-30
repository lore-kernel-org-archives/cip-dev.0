From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 May 2018 18:36:06 +0100
Subject: [cip-dev] [PATCH v2 10/11] ARM: dts: r8a7743: Add CMT SoC specific
	support
In-Reply-To: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
References: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527701767-41785-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add CMT[01] support to SoC DT.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 3114c70c532ae2555948739f645ace268554228d)
(updated clocks and power-domains property.removed resets property.
Changed the compatible string due to the commit 8d50e9476bb4
("clocksource/drivers/sh_cmt: Mark "renesas, cmt-48-gen2" deprecated").
Added renesas,channels-mask property which is removed based on the
commit 4e18111ff38f0664 ("devicetree:bindings: Remove deprecated properties"))
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 1d9adcc..72a23c9 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1653,6 +1653,42 @@
 			status = "disabled";
 		};
 
+		cmt0: timer at ffca0000 {
+			compatible = "renesas,cmt-48-r8a7743",
+				     "renesas,cmt-48-gen2";
+			reg = <0 0xffca0000 0 0x1004>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7743_CLK_CMT0>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+
+			renesas,channels-mask = <0x60>;
+
+			status = "disabled";
+		};
+
+		cmt1: timer at e6130000 {
+			compatible = "renesas,cmt-48-r8a7743",
+				     "renesas,cmt-48-gen2";
+			reg = <0 0xe6130000 0 0x1004>;
+			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp3_clks R8A7743_CLK_CMT1>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+
+			renesas,channels-mask = <0xff>;
+
+			status = "disabled";
+		};
+
 		rcar_sound: sound at ec500000 {
 			/*
 			 * #sound-dai-cells is required
-- 
2.7.4
