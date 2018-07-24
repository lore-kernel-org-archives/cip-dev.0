From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 24 Jul 2018 11:32:33 +0100
Subject: [cip-dev] [PATCH 2/2] ARM: dts: r8a7745: Add TPU support
In-Reply-To: <1532428353-30716-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532428353-30716-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532428353-30716-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add TPU support to SoC DT.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit b9db514555274eb325c9b13a0b0587c0e600d75a)
(moved node to a better location to allow for better sorting. modified
clocks and power-domains properties. removed resets property)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 4163ae4..6fdd3c2 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -173,6 +173,15 @@
 			reg = <0 0xe6060000 0 0x11c>;
 		};
 
+		tpu: pwm at e60f0000 {
+			compatible = "renesas,tpu-r8a7745", "renesas,tpu";
+			reg = <0 0xe60f0000 0 0x148>;
+			clocks = <&mstp3_clks R8A7745_CLK_TPU0>;
+			power-domains = <&cpg_clocks>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		gic: interrupt-controller at f1001000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
-- 
2.7.4
