From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:02:10 +0000
Subject: [cip-dev] [PATCH 14/15] ARM: dts: iwg20d-q7: Add support for ttySC3
In-Reply-To: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520247731-25239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520247731-25239-15-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 77014a7c654c76e1c0cf82563cc48e07c546461c)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 1a0bb24..7d93a7c 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -11,6 +11,7 @@
 / {
 	aliases {
 		serial0 = &scif0;
+		serial3 = &scifb1;
 		ethernet0 = &avb;
 	};
 
@@ -82,6 +83,11 @@
 		function = "scif0";
 	};
 
+	scifb1_pins: scifb1 {
+		groups = "scifb1_data_d", "scifb1_ctrl";
+		function = "scifb1";
+	};
+
 	sdhi1_pins: sd1 {
 		groups = "sdhi1_data4", "sdhi1_ctrl";
 		function = "sdhi1";
@@ -96,6 +102,14 @@
 	status = "okay";
 };
 
+&scifb1 {
+	pinctrl-0 = <&scifb1_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	status = "okay";
+};
+
 &sdhi1 {
 	pinctrl-0 = <&sdhi1_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
