From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:48:03 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 4/4] arm64: dts: renesas: cat875: Add
	CAN support
In-Reply-To: <1563198483-8589-1-git-send-email-biju.das@bp.renesas.com>
References: <1563198483-8589-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563198483-8589-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit e64f2c4b3aba6832758afe030ea4a703148546d7 upstream.

Add CAN support to the CAT875 sub board.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/cat875.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/cat875.dtsi b/arch/arm64/boot/dts/renesas/cat875.dtsi
index 14db667..aaefc3a 100644
--- a/arch/arm64/boot/dts/renesas/cat875.dtsi
+++ b/arch/arm64/boot/dts/renesas/cat875.dtsi
@@ -30,6 +30,18 @@
 	};
 };
 
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&can1 {
+	pinctrl-0 = <&can1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &pciec0 {
 	status = "okay";
 };
@@ -41,4 +53,14 @@
 			function = "avb";
 		};
 	};
+
+	can0_pins: can0 {
+		groups = "can0_data";
+		function = "can0";
+	};
+
+	can1_pins: can1 {
+		groups = "can1_data";
+		function = "can1";
+	};
 };
-- 
2.7.4
