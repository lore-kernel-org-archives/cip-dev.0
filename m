From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:07:55 +0100
Subject: [cip-dev] [PATCH 06/62] ARM: dts: iwg20d-q7-dbcm-ca: Add can1
	support to camera DB
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

CAN1 interface is exposed via connector J3 found on the camera daughter
board. This patch enables can1 DT node from within the daughter board
specific dtsi.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 04e31b155f628e572d4ee2eeda5d6ee20ba86038)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi b/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
index 31fab5f..cbdfdc8 100644
--- a/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
@@ -15,6 +15,13 @@
 	};
 };
 
+&can1 {
+	pinctrl-0 = <&can1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &hscif1 {
 	pinctrl-0 = <&hscif1_pins>;
 	pinctrl-names = "default";
@@ -24,6 +31,11 @@
 };
 
 &pfc {
+	can1_pins: can1 {
+		groups = "can1_data_d";
+		function = "can1";
+	};
+
 	hscif1_pins: hscif1 {
 		groups = "hscif1_data_c", "hscif1_ctrl_c";
 		function = "hscif1";
-- 
2.7.4
