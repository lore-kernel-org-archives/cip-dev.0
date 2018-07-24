From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 24 Jul 2018 12:03:53 +0100
Subject: [cip-dev] [PATCH 3/3] ARM: dts: iwg22d-sodimm-dbhd-ca: Add can1
	support to HDMI DB
In-Reply-To: <1532430233-32277-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1532430233-32277-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1532430233-32277-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

CAN1 interface is exposed via connector J1 found on the HDMI daughter
board. This patch enables can1 DT node from within the daughter board
specific device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit d6033e7c6589c74299635eb3d84c56ccac8db5e4)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
index fc0f559..654d28b 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
@@ -54,6 +54,13 @@
 	};
 };
 
+&can1 {
+	pinctrl-0 = <&can1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &hscif2 {
 	pinctrl-0 = <&hscif2_pins>;
 	pinctrl-names = "default";
@@ -103,6 +110,11 @@
 };
 
 &pfc {
+	can1_pins: can1 {
+		groups = "can1_data_b";
+		function = "can1";
+	};
+
 	du0_pins: du0 {
 		groups = "du0_rgb888", "du0_sync", "du0_disp", "du0_clk0_out";
 		function = "du0";
-- 
2.7.4
