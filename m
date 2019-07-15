From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:48:00 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 1/4] arm64: dts: renesas: r8a774c0: Fix
	cpu nodes style
In-Reply-To: <1563198483-8589-1-git-send-email-biju.das@bp.renesas.com>
References: <1563198483-8589-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563198483-8589-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 12ce412b2cc6aea88c9c93e6303372f72014efc6 upstream.

We usually leave a space between "=" and the value of device
tree properties, but unfortunately that was overlooked for the
"clocks" property of cpu at 0 and cpu at 1.
This patch fixes the spacing with the "clocks" property of
cpu at 0 and cpu at 1.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
index 8a2e4d8..8678da4 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774c0.dtsi
@@ -76,7 +76,7 @@
 			power-domains = <&sysc R8A774C0_PD_CA53_CPU0>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
-			clocks =<&cpg CPG_CORE R8A774C0_CLK_Z2>;
+			clocks = <&cpg CPG_CORE R8A774C0_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
 		};
 
@@ -87,7 +87,7 @@
 			power-domains = <&sysc R8A774C0_PD_CA53_CPU1>;
 			next-level-cache = <&L2_CA53>;
 			enable-method = "psci";
-			clocks =<&cpg CPG_CORE R8A774C0_CLK_Z2>;
+			clocks = <&cpg CPG_CORE R8A774C0_CLK_Z2>;
 			operating-points-v2 = <&cluster1_opp>;
 		};
 
-- 
2.7.4
