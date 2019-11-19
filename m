From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:41 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 16/17] ARM: dts: r8a7744: Add RWDT node
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574175222-52858-17-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 336a425ce67d151fe1e275389aeccd08d66d9833 upstream.

Add a device node for the Watchdog Timer (RWDT) controller on the Renesas
RZ/G1N (r8a7744) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[biju: removed resets property. Updated power-domains and clocks properties]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7744.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7744.dtsi b/arch/arm/boot/dts/r8a7744.dtsi
index 1a4854a..a1952ea 100644
--- a/arch/arm/boot/dts/r8a7744.dtsi
+++ b/arch/arm/boot/dts/r8a7744.dtsi
@@ -134,6 +134,15 @@
 		#size-cells = <2>;
 		ranges;
 
+		rwdt: watchdog at e6020000 {
+			compatible = "renesas,r8a7744-wdt",
+				     "renesas,rcar-gen2-wdt";
+			reg = <0 0xe6020000 0 0x0c>;
+			clocks = <&mstp4_clks R8A7744_CLK_RWDT>;
+			power-domains = <&cpg_clocks>;
+			status = "disabled";
+		};
+
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7744",
 				     "renesas,rcar-gen2-gpio";
-- 
2.7.4
