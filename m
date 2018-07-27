From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 27 Jul 2018 17:27:16 +0100
Subject: [cip-dev] [PATCH 3/3] ARM: dts: r8a7791: Fix vsp1 properties
In-Reply-To: <1532708836-25349-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532708836-25349-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532708836-25349-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

According to the HW manual, VSP1S has 1 UDS and VSP1D has 1 WPF,
therefore fix the DT properties accordingly and similarly to what
done by commit 398e3d4f1e0baecb926315673a6740f2573b07ae ("[media]
v4l: vsp1: Fix descriptions of Gen2 VSP instances") upstream.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d2585a4..df9ab4d 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -876,7 +876,7 @@
 		renesas,has-lut;
 		renesas,has-sru;
 		renesas,#rpf = <5>;
-		renesas,#uds = <3>;
+		renesas,#uds = <1>;
 		renesas,#wpf = <4>;
 	};
 
@@ -891,7 +891,7 @@
 		renesas,has-lut;
 		renesas,#rpf = <4>;
 		renesas,#uds = <1>;
-		renesas,#wpf = <4>;
+		renesas,#wpf = <1>;
 	};
 
 	vsp1 at fe938000 {
@@ -905,7 +905,7 @@
 		renesas,has-lut;
 		renesas,#rpf = <4>;
 		renesas,#uds = <1>;
-		renesas,#wpf = <4>;
+		renesas,#wpf = <1>;
 	};
 
 	du: display at feb00000 {
-- 
2.7.4
