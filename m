From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:41 +0100
Subject: [cip-dev] [PATCH  52/62] ARM: dts: r8a7743: Add PWM SoC support
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-53-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add the definitions for pwm[0123456] to the SoC .dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit ea16b5896267a2358fc17cf5340b27b906513119)
(updated clocks and power-domains property.removed resets property)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 63 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index c0e53ee..17be22c 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -917,6 +917,69 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm at e6e30000 {
+			compatible = "renesas,pwm-r8a7743", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 0x8>;
+			clocks = <&mstp5_clks R8A7743_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm1: pwm at e6e31000 {
+			compatible = "renesas,pwm-r8a7743", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 0x8>;
+			clocks = <&mstp5_clks R8A7743_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm2: pwm at e6e32000 {
+			compatible = "renesas,pwm-r8a7743", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 0x8>;
+			clocks = <&mstp5_clks R8A7743_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm3: pwm at e6e33000 {
+			compatible = "renesas,pwm-r8a7743", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 0x8>;
+			clocks = <&mstp5_clks R8A7743_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm4: pwm at e6e34000 {
+			compatible = "renesas,pwm-r8a7743", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 0x8>;
+			clocks = <&mstp5_clks R8A7743_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm5: pwm at e6e35000 {
+			compatible = "renesas,pwm-r8a7743", "renesas,pwm-rcar";
+			reg = <0 0xe6e35000 0 0x8>;
+			clocks = <&mstp5_clks R8A7743_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm6: pwm at e6e36000 {
+			compatible = "renesas,pwm-r8a7743", "renesas,pwm-rcar";
+			reg = <0 0xe6e36000 0 0x8>;
+			clocks = <&mstp5_clks R8A7743_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		/*
 		 * pci1 and xhci share the same phy, therefore only one of them
 		 * can be active at any one time. If both of them are enabled,
-- 
2.7.4
