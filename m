From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:56:19 +0000
Subject: [cip-dev] [PATCH 3/5] arm64: dts: renesas: cat875: Add ethernet
	support
In-Reply-To: <1553248581-64466-1-git-send-email-biju.das@bp.renesas.com>
References: <1553248581-64466-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553248581-64466-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch adds ethernet support to the sub board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 6b170cd3ed02949f33fb8b6898b3b31ae5e87716)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/cat875.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/cat875.dtsi b/arch/arm64/boot/dts/renesas/cat875.dtsi
index a41d0d8..805ffa7 100644
--- a/arch/arm64/boot/dts/renesas/cat875.dtsi
+++ b/arch/arm64/boot/dts/renesas/cat875.dtsi
@@ -7,4 +7,34 @@
 
 / {
 	model = "Silicon Linux sub board for CAT874 (CAT875)";
+
+	aliases {
+		ethernet0 = &avb;
+	};
+};
+
+&avb {
+	pinctrl-0 = <&avb_pins>;
+	pinctrl-names = "default";
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii";
+	status = "okay";
+
+	phy0: ethernet-phy at 0 {
+		rxc-skew-ps = <1500>;
+		reg = <0>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&gpio1 20 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&pfc {
+	avb_pins: avb {
+		mux {
+			groups = "avb_mii";
+			function = "avb";
+		};
+	};
 };
-- 
2.7.4
