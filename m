From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 27 Jul 2018 17:27:15 +0100
Subject: [cip-dev] [PATCH 2/3] ARM: dts: r8a7743: Fix vsp1 properties
In-Reply-To: <1532708836-25349-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532708836-25349-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532708836-25349-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

According to the RZ/G Series HW User's Manual (tables 28.1 and
28.3), VSP1S has 1 UDS and VSP1D has 1 WPF, therefore fix the
DT properties accordingly and similarly to what done by commit
398e3d4f1e0baecb926315673a6740f2573b07ae ("[media] v4l: vsp1: Fix
descriptions of Gen2 VSP instances") upstream.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index bb507a1..c78de96 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -1632,7 +1632,7 @@
 			renesas,has-lut;
 			renesas,has-sru;
 			renesas,#rpf = <5>;
-			renesas,#uds = <3>;
+			renesas,#uds = <1>;
 			renesas,#wpf = <4>;
 		};
 
@@ -1647,7 +1647,7 @@
 			renesas,has-lut;
 			renesas,#rpf = <4>;
 			renesas,#uds = <1>;
-			renesas,#wpf = <4>;
+			renesas,#wpf = <1>;
 		};
 
 		vsp at fe938000 {
@@ -1661,7 +1661,7 @@
 			renesas,has-lut;
 			renesas,#rpf = <4>;
 			renesas,#uds = <1>;
-			renesas,#wpf = <4>;
+			renesas,#wpf = <1>;
 		};
 
 		pci0: pci at ee090000 {
-- 
2.7.4
