From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 15 Oct 2019 11:42:37 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 2/2] arm64: dts: renesas: cat874: Add
	BT support
In-Reply-To: <1571136157-56249-1-git-send-email-biju.das@bp.renesas.com>
References: <1571136157-56249-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571136157-56249-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 7b7c5676a877c4e66083888d87d52e4a0d0c2e82 upstream.

This patch enables BT support for the CAT874 board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index 72cccfc..fdca695 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -16,6 +16,7 @@
 
 	aliases {
 		serial0 = &scif2;
+		serial1 = &hscif2;
 	};
 
 	chosen {
@@ -154,6 +155,19 @@
 	clock-frequency = <48000000>;
 };
 
+&hscif2 {
+	pinctrl-0 = <&hscif2_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "ti,wl1837-st";
+		enable-gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 	clock-frequency = <100000>;
@@ -237,6 +251,11 @@
 		function = "i2c1";
 	};
 
+	hscif2_pins: hscif2 {
+		groups = "hscif2_data_a", "hscif2_ctrl_a";
+		function = "hscif2";
+	};
+
 	scif2_pins: scif2 {
 		groups = "scif2_data_a";
 		function = "scif2";
-- 
2.7.4
