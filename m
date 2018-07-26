From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 26 Jul 2018 18:42:31 +0100
Subject: [cip-dev] [PATCH 13/42] ARM: dts: r8a7745: Register rwdt and
	intc-sys clocks
In-Reply-To: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532626980-17190-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532626980-17190-14-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch registers "rwdt" and "intc-sys" clocks by adding the
necessary definitions to the mstp4_clks node. Please note that
both "rwdt" and "intc-sys" are critical clocks.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 46fb046..33236c0 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -1365,12 +1365,13 @@
 				compatible = "renesas,r8a7745-mstp-clocks",
 					     "renesas,cpg-mstp-clocks";
 				reg = <0 0xe6150140 0 4>, <0 0xe615004c 0 4>;
-				clocks = <&cp_clk>;
+				clocks = <&rclk_clk>, <&cp_clk>, <&zs_clk>;
 				#clock-cells = <1>;
 				clock-indices = <
-					R8A7745_CLK_IRQC
+					R8A7745_CLK_RWDT R8A7745_CLK_IRQC
+					R8A7745_CLK_INTC_SYS
 				>;
-				clock-output-names = "irqc";
+				clock-output-names = "rwdt", "irqc", "intc-sys";
 			};
 			mstp5_clks: mstp5_clks at e6150144 {
 				compatible = "renesas,r8a7745-mstp-clocks",
-- 
2.7.4
