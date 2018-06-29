From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:39:08 +0100
Subject: [cip-dev] [PATCH 67/86] ARM: dts: iwg22m: Enable SDHI1 controller
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-68-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Enable the SDHI1 controller on iWave RZ/G1E SoM.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 599114ee21057040c058043fdc1367878350d5e4)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22m.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
index e306e7c..f7f9cef 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
+++ b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include "r8a7745.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	compatible = "iwave,g22m", "renesas,r8a7745";
@@ -38,6 +39,12 @@
 		function = "mmc";
 	};
 
+	sdhi1_pins: sd1 {
+		groups = "sdhi1_data4", "sdhi1_ctrl";
+		function = "sdhi1";
+		power-source = <3300>;
+	};
+
 	i2c3_pins: i2c3 {
 		groups = "i2c3_b";
 		function = "i2c3";
@@ -54,6 +61,16 @@
 	status = "okay";
 };
 
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	cd-gpios = <&gpio3 31 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &i2c3 {
 	pinctrl-0 = <&i2c3_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
