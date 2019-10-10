From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Oct 2019 07:45:15 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 3/3] arm64: dts: renesas:
	hihope-common: Add WLAN support
In-Reply-To: <1570689915-14149-1-git-send-email-biju.das@bp.renesas.com>
References: <1570689915-14149-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1570689915-14149-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 176f936a1e887a53d78f05248dc3c9bbd2c7f4c8 upstream.

This patch enables WLAN support for the HiHope RZ/G2[MN] boards.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index 76f7a9a..0daff2d 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -54,6 +54,13 @@
 		led3 {
 			gpios = <&gpio0  0 GPIO_ACTIVE_HIGH>;
 		};
+
+		wlan_active_led {
+			label = "yellow:wlan";
+			gpios = <&gpio7  1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
 	};
 
 	reg_1p8v: regulator0 {
@@ -98,6 +105,17 @@
 			  1800000 0>;
 	};
 
+	wlan_en_reg: regulator-wlan_en {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		startup-delay-us = <70000>;
+
+		gpio = <&gpio_expander 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	x302_clk: x302-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -242,6 +260,12 @@
 		power-source = <1800>;
 	};
 
+	sdhi2_pins: sd2 {
+		groups = "sdhi2_data4", "sdhi2_ctrl";
+		function = "sdhi2";
+		power-source = <1800>;
+	};
+
 	sdhi3_pins: sd3 {
 		groups = "sdhi3_data8", "sdhi3_ctrl", "sdhi3_ds";
 		function = "sdhi3";
@@ -301,6 +325,27 @@
 	status = "okay";
 };
 
+&sdhi2 {
+	status = "okay";
+	pinctrl-0 = <&sdhi2_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&wlan_en_reg>;
+	bus-width = <4>;
+	non-removable;
+	cap-power-off-card;
+	keep-power-in-suspend;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	wlcore: wlcore at 2 {
+		compatible = "ti,wl1837";
+		reg = <2>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
 &sdhi3 {
 	pinctrl-0 = <&sdhi3_pins>;
 	pinctrl-1 = <&sdhi3_pins>;
-- 
2.7.4
