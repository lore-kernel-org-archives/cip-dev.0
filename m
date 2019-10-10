From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Oct 2019 07:45:14 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 2/3] arm64: dts: renesas:
	hihope-common: Add BT support
In-Reply-To: <1570689915-14149-1-git-send-email-biju.das@bp.renesas.com>
References: <1570689915-14149-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1570689915-14149-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit d112c20925443b4a8876b101e5b7b13ef105057e upstream.

This patch enables BT support for the HiHope RZ/G2[MN] boards.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index a13cb88..76f7a9a 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -10,6 +10,7 @@
 / {
 	aliases {
 		serial0 = &scif2;
+		serial1 = &hscif0;
 	};
 
 	chosen {
@@ -31,6 +32,13 @@
 	leds {
 		compatible = "gpio-leds";
 
+		bt_active_led {
+			label = "blue:bt";
+			gpios = <&gpio7  0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+
 		led0 {
 			gpios = <&gpio6 11 GPIO_ACTIVE_HIGH>;
 		};
@@ -153,6 +161,19 @@
 	};
 };
 
+&hscif0 {
+	pinctrl-0 = <&hscif0_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "ti,wl1837-st";
+		enable-gpios = <&gpio_expander 2 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &hsusb {
 	dr_mode = "otg";
 	status = "okay";
@@ -194,6 +215,11 @@
 	pinctrl-0 = <&scif_clk_pins>;
 	pinctrl-names = "default";
 
+	hscif0_pins: hscif0 {
+		groups = "hscif0_data", "hscif0_ctrl";
+		function = "hscif0";
+	};
+
 	scif2_pins: scif2 {
 		groups = "scif2_data_a";
 		function = "scif2";
-- 
2.7.4
