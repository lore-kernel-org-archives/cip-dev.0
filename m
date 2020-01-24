From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Fri, 24 Jan 2020 09:08:12 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 02/10] ARM: dts: r8a7744: Add PWM SoC
	support
In-Reply-To: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579856900-21381-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1579856900-21381-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit cebc31e8b59445aaf84b8810ff76b2fcc246fea2 upstream.

Add the definitions for pwm[0123456] to the SoC dtsi.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(updated clocks and power-domains property.removed resets property)
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 63 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index cf7d8fe..79c71ef 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -847,6 +847,69 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm at e6e30000 {
+			compatible = "renesas,pwm-r8a7744", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 0x8>;
+			clocks = <&mstp5_clks R8A7744_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm1: pwm at e6e31000 {
+			compatible = "renesas,pwm-r8a7744", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 0x8>;
+			clocks = <&mstp5_clks R8A7744_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm2: pwm at e6e32000 {
+			compatible = "renesas,pwm-r8a7744", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 0x8>;
+			clocks = <&mstp5_clks R8A7744_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm3: pwm at e6e33000 {
+			compatible = "renesas,pwm-r8a7744", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 0x8>;
+			clocks = <&mstp5_clks R8A7744_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm4: pwm at e6e34000 {
+			compatible = "renesas,pwm-r8a7744", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 0x8>;
+			clocks = <&mstp5_clks R8A7744_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm5: pwm at e6e35000 {
+			compatible = "renesas,pwm-r8a7744", "renesas,pwm-rcar";
+			reg = <0 0xe6e35000 0 0x8>;
+			clocks = <&mstp5_clks R8A7744_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
+		pwm6: pwm at e6e36000 {
+			compatible = "renesas,pwm-r8a7744", "renesas,pwm-rcar";
+			reg = <0 0xe6e36000 0 0x8>;
+			clocks = <&mstp5_clks R8A7744_CLK_PWM>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		can0: can at e6e80000 {
 			compatible = "renesas,can-r8a7744",
 				     "renesas,rcar-gen2-can";
-- 
2.7.4
