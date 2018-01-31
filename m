From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 31 Jan 2018 11:15:55 +0000
Subject: [cip-dev] [PATCH 10/10] ARM: dts: r8a7743: Add missing clock for
	secondary CA15 CPU core
In-Reply-To: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
References: <1517397355-23341-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1517397355-23341-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Currently only the primary CPU in the CA15 cluster has a clocks
property, while the secondary CPU core is driven by the same clock.
Add the missing clocks property to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit a60ddf507dda0ede43b72d348283d8725a5a83c7)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

Conflicts:
	arch/arm/boot/dts/r8a7743.dtsi
---
 arch/arm/boot/dts/r8a7743.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index e4e0dc3..e755cb9 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -46,6 +46,7 @@
 			compatible = "arm,cortex-a15";
 			reg = <1>;
 			clock-frequency = <1500000000>;
+			clocks = <&cpg_clocks R8A7743_CLK_Z>;
 			next-level-cache = <&L2_CA15>;
 		};
 
-- 
2.7.4
