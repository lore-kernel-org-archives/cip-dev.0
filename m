From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 19 Feb 2018 18:45:49 +0000
Subject: [cip-dev] [PATCH 1/3] ARM: dts: iwg20d-q7: Add RTC support
In-Reply-To: <1519065951-9897-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519065951-9897-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1519065951-9897-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Define the iWave RainboW-G20D-Qseven board dependent part of the
RTC device node.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit e0e63658c2f291e0672fdf96df1f9f2963a6a9f6)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
index 081af01..f3b4890 100644
--- a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
@@ -22,6 +22,11 @@
 };
 
 &pfc {
+	i2c2_pins: i2c2 {
+		groups = "i2c2";
+		function = "i2c2";
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data_d";
 		function = "scif0";
@@ -54,3 +59,16 @@
 		micrel,led-mode = <1>;
 	};
 };
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+	clock-frequency = <400000>;
+
+	rtc at 68 {
+		compatible = "bq32000";
+		reg = <0x68>;
+	};
+};
-- 
2.7.4
