From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:06 +0100
Subject: [cip-dev] [PATCH 17/62] ARM: dts: iwg20d-q7: Enable PCIe Controller
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-18-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Enable PCIe Controller & set PCIe bus clock frequency.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit b3a0317e312cc6d6359c7a0854d763cde528391d)
(sorted pci nodes alphabetically)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 0bcb42f..624907b 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -85,6 +85,25 @@
 	};
 };
 
+&pci0 {
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+};
+
+&pci1 {
+	status = "okay";
+	pinctrl-0 = <&usb1_pins>;
+	pinctrl-names = "default";
+};
+
+&pcie_bus_clk {
+	clock-frequency = <100000000>;
+};
+
+&pciec {
+	status = "okay";
+};
+
 &pfc {
 	can0_pins: can0 {
 		groups = "can0_data_d";
@@ -128,17 +147,6 @@
 	};
 };
 
-&pci0 {
-	pinctrl-0 = <&usb0_pins>;
-	pinctrl-names = "default";
-};
-
-&pci1 {
-	status = "okay";
-	pinctrl-0 = <&usb1_pins>;
-	pinctrl-names = "default";
-};
-
 &scif0 {
 	pinctrl-0 = <&scif0_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
