From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 15:28:06 +0100
Subject: [cip-dev] [PATCH 2/3] ARM: dts: r8a7745: Add CMT SoC specific
	support
In-Reply-To: <1532615287-1183-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532615287-1183-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532615287-1183-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add CMT[01] support to SoC DT.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 9680c97b516cbb70efe73dde05d497b1203bde6d)
(updated clocks and power-domains properties. removed resets property.
added renesas,channels-mask property. updated compatible strings)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 0335e45..46fb046 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -1062,6 +1062,38 @@
 			};
 		};
 
+		cmt0: timer at ffca0000 {
+			compatible = "renesas,cmt-48-r8a7745",
+				     "renesas,cmt-48-gen2";
+			reg = <0 0xffca0000 0 0x1004>;
+			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp1_clks R8A7745_CLK_CMT0>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			renesas,channels-mask = <0x60>;
+			status = "disabled";
+		};
+
+		cmt1: timer at e6130000 {
+			compatible = "renesas,cmt-48-r8a7745",
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
+			clocks = <&mstp3_clks R8A7745_CLK_CMT1>;
+			clock-names = "fck";
+			power-domains = <&cpg_clocks>;
+			renesas,channels-mask = <0xff>;
+			status = "disabled";
+		};
+
 		clocks {
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
2.7.4
