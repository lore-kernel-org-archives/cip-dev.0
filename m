From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:03:23 +0100
Subject: [cip-dev] [PATCH 4.19.y 52/60] arm64: dts: renesas: Fix whitespace
	around assignments
In-Reply-To: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566990211-24785-53-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit fced3a97f80955e5950b76d164a4124cb1303853 upstream.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[simon: updated for a few new cases]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[fab: dropped changes not related to r8a774a1.dtsi]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index d2c67f3..046fc93 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -66,7 +66,7 @@
 			power-domains = <&sysc 0>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
-			clocks =<&cpg CPG_CORE 0>;
+			clocks = <&cpg CPG_CORE 0>;
 		};
 
 		a57_1: cpu at 1 {
@@ -76,7 +76,7 @@
 			power-domains = <&sysc 1>;
 			next-level-cache = <&L2_CA57>;
 			enable-method = "psci";
-			clocks =<&cpg CPG_CORE 0>;
+			clocks = <&cpg CPG_CORE 0>;
 		};
 
 		a53_0: cpu at 100 {
@@ -1431,7 +1431,7 @@
 			clocks = <&cpg CPG_MOD 703>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
-			companion= <&ohci0>;
+			companion = <&ohci0>;
 			power-domains = <&sysc 32>;
 			resets = <&cpg 703>;
 			status = "disabled";
@@ -1444,7 +1444,7 @@
 			clocks = <&cpg CPG_MOD 702>;
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
-			companion= <&ohci1>;
+			companion = <&ohci1>;
 			power-domains = <&sysc 32>;
 			resets = <&cpg 702>;
 			status = "disabled";
-- 
2.7.4
