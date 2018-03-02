From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri,  2 Mar 2018 11:44:51 +0000
Subject: [cip-dev] [PATCH 5/6] ARM: dts: iwg20m: Enable SDHI0 controller
In-Reply-To: <1519991092-4465-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519991092-4465-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1519991092-4465-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Enable the SDHI0 controller on iWave RZG1M Qseven SOM.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit e75e71e7bcee2e04be8bbca6fb67af1a45fa128b)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
index ff79938..4119737 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
+++ b/arch/arm/boot/dts/r8a7743-iwg20m.dtsi
@@ -9,6 +9,7 @@
  */
 
 #include "r8a7743.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	compatible = "iwave,g20m", "renesas,r8a7743";
@@ -42,6 +43,12 @@
 		groups = "mmc_data8_b", "mmc_ctrl";
 		function = "mmc";
 	};
+
+	sdhi0_pins: sd0 {
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
+		power-source = <3300>;
+	};
 };
 
 &mmcif0 {
@@ -53,3 +60,13 @@
 	non-removable;
 	status = "okay";
 };
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	cd-gpios = <&gpio7 11 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
-- 
2.7.4
