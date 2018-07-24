From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 24 Jul 2018 11:32:32 +0100
Subject: [cip-dev] [PATCH 1/2] ARM: dts: r8a7745: Add PWM SoC support
In-Reply-To: <1532428353-30716-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532428353-30716-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532428353-30716-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add the definitions for pwm[0123456] to the SoC .dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 3711d0ede24d2e3c90ae10e1a79746ac87169609)
(modified clocks and power-domains properties. removed resets
property)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 63 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 68ef545..4163ae4 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -772,6 +772,69 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm at e6e30000 {
+			compatible = "renesas,pwm-r8a7745", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 0x8>;
+			clocks = <&mstp5_clks R8A7745_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm1: pwm at e6e31000 {
+			compatible = "renesas,pwm-r8a7745", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 0x8>;
+			clocks = <&mstp5_clks R8A7745_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm2: pwm at e6e32000 {
+			compatible = "renesas,pwm-r8a7745", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 0x8>;
+			clocks = <&mstp5_clks R8A7745_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm3: pwm at e6e33000 {
+			compatible = "renesas,pwm-r8a7745", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 0x8>;
+			clocks = <&mstp5_clks R8A7745_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm4: pwm at e6e34000 {
+			compatible = "renesas,pwm-r8a7745", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 0x8>;
+			clocks = <&mstp5_clks R8A7745_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm5: pwm at e6e35000 {
+			compatible = "renesas,pwm-r8a7745", "renesas,pwm-rcar";
+			reg = <0 0xe6e35000 0 0x8>;
+			clocks = <&mstp5_clks R8A7745_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm6: pwm at e6e36000 {
+			compatible = "renesas,pwm-r8a7745", "renesas,pwm-rcar";
+			reg = <0 0xe6e36000 0 0x8>;
+			clocks = <&mstp5_clks R8A7745_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		pci0: pci at ee090000 {
 			compatible = "renesas,pci-r8a7745",
 				     "renesas,pci-rcar-gen2";
-- 
2.7.4
