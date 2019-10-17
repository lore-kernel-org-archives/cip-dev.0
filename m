From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 07:57:59 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 6/6] arm64: dts: renesas:
	hihope-rzg2-ex: Enable CAN interfaces
In-Reply-To: <1571295479-39328-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295479-39328-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295479-39328-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 816c5248df0fdcee33e56444232394d597a1894b upstream.

This patch enables both CAN0 and CAN1, both exposed via
connectors found on the expansion board.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
index 07a6eea..4280b19 100644
--- a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
@@ -31,6 +31,18 @@
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
@@ -60,4 +72,14 @@
 			drive-strength = <12>;
 		};
 	};
+
+	can0_pins: can0 {
+		groups = "can0_data_a";
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
