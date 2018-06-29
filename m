From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:46 +0100
Subject: [cip-dev] [PATCH 45/86] ARM: dts: r8a7743: Use R-Car GPIO Gen2
	fallback compat string
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-46-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

Use newly added R-Car GPIO Gen2 fallback compat string
in place of now deprecated non-generation specific
R-Car GPIO fallback compat string in the DT of the r8a7743 SoC.

This should have no run-time effect as the driver matches against
the per-SoC compat string before considering the fallback compat string.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 936e7d7472547294fa305f60546afad232896fdc)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 64d8462..d94fbce 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -108,7 +108,7 @@
 
 		gpio0: gpio at e6050000 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6050000 0 0x50>;
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -122,7 +122,7 @@
 
 		gpio1: gpio at e6051000 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6051000 0 0x50>;
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -136,7 +136,7 @@
 
 		gpio2: gpio at e6052000 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6052000 0 0x50>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -150,7 +150,7 @@
 
 		gpio3: gpio at e6053000 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6053000 0 0x50>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -164,7 +164,7 @@
 
 		gpio4: gpio at e6054000 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6054000 0 0x50>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -178,7 +178,7 @@
 
 		gpio5: gpio at e6055000 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055000 0 0x50>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -192,7 +192,7 @@
 
 		gpio6: gpio at e6055400 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055400 0 0x50>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
@@ -206,7 +206,7 @@
 
 		gpio7: gpio at e6055800 {
 			compatible = "renesas,gpio-r8a7743",
-				     "renesas,gpio-rcar";
+				     "renesas,rcar-gen2-gpio";
 			reg = <0 0xe6055800 0 0x50>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			#gpio-cells = <2>;
-- 
2.7.4
