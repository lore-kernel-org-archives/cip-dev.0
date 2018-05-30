From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 30 May 2018 18:36:03 +0100
Subject: [cip-dev] [PATCH v2 07/11] ARM: dts: r8a7743: Add thermal device to
	DT
In-Reply-To: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
References: <1527701767-41785-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527701767-41785-8-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch instantiates the thermal sensor module with thermal-zone
support.

This patch is based on the commit cac68a56e34b
("ARM: dts: r8a7791: enable to use thermal-zone") by Kuninori Morimoto.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 6c76b4f7d89e89f0ae405dfc7a64c6d2b5d02813)
(updated clocks and power-domains property.removed resets property)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 17be22c..1d9adcc 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -237,6 +237,37 @@
 			power-domains = <&cpg_clocks>;
 		};
 
+		thermal: thermal at e61f0000 {
+			compatible = "renesas,thermal-r8a7743",
+				     "renesas,rcar-gen2-thermal",
+				     "renesas,rcar-thermal";
+			reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp5_clks R8A7743_CLK_THERMAL>;
+			power-domains = <&cpg_clocks>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		thermal-zones {
+			cpu_thermal: cpu-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&thermal>;
+
+				trips {
+					cpu-crit {
+						temperature = <95000>;
+						hysteresis = <0>;
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+				};
+			};
+		};
+
 		timer {
 			compatible = "arm,armv7-timer";
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
-- 
2.7.4
