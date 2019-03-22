From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:40:09 +0000
Subject: [cip-dev] [PATCH 10/11] arm64: dts: renesas: r8a774c0: Add SDHI
	nodes
In-Reply-To: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
References: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553247610-33056-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add SDHI nodes to the DT of the r8a774c0 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 77223211f44db5b35541f4cc1fe48cdee21a85b2)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 36 +++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 97ff545..e354b8011 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -548,6 +548,42 @@
 			status = "disabled";
 		};
 
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a774c0",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee100000 0 0x2000>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			status = "disabled";
+		};
+
+		sdhi1: sd at ee120000 {
+			compatible = "renesas,sdhi-r8a774c0",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee120000 0 0x2000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 313>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 313>;
+			status = "disabled";
+		};
+
+		sdhi3: sd at ee160000 {
+			compatible = "renesas,sdhi-r8a774c0",
+				     "renesas,rcar-gen3-sdhi";
+			reg = <0 0xee160000 0 0x2000>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 311>;
+			max-frequency = <200000000>;
+			power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
+			resets = <&cpg 311>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at f1010000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.7.4
