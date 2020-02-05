From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:43 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 17/35] arm64: dts: renesas: r8a774b1:
	Add PWM device nodes
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-18-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 68f627511fed928b4ddf26419733edc01525173d upstream.

This patch adds PWM device nodes to r8a774b1 SoC DT.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/1570029619-43238-7-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index ed349f0..faee99e 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -1003,6 +1003,76 @@
 			};
 		};
 
+		pwm0: pwm at e6e30000 {
+			compatible = "renesas,pwm-r8a774b1", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm1: pwm at e6e31000 {
+			compatible = "renesas,pwm-r8a774b1", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm2: pwm at e6e32000 {
+			compatible = "renesas,pwm-r8a774b1", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm3: pwm at e6e33000 {
+			compatible = "renesas,pwm-r8a774b1", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm4: pwm at e6e34000 {
+			compatible = "renesas,pwm-r8a774b1", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm5: pwm at e6e35000 {
+			compatible = "renesas,pwm-r8a774b1", "renesas,pwm-rcar";
+			reg = <0 0xe6e35000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm6: pwm at e6e36000 {
+			compatible = "renesas,pwm-r8a774b1", "renesas,pwm-rcar";
+			reg = <0 0xe6e36000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		scif0: serial at e6e60000 {
 			compatible = "renesas,scif-r8a774b1",
 				     "renesas,rcar-gen3-scif", "renesas,scif";
-- 
2.7.4
