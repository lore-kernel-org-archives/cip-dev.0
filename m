From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 15 Oct 2019 11:42:36 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 1/2] arm64: dts: renesas: cat874: Add
	WLAN support
In-Reply-To: <1571136157-56249-1-git-send-email-biju.das@bp.renesas.com>
References: <1571136157-56249-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571136157-56249-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit b263b0067d727ffb230bd8ac75a6a3f9ff448f0f upstream.

This patch enables WLAN support for the CAT874 board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 38 +++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index b7183f1..72cccfc 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -104,6 +104,17 @@
 			  1800000 0>;
 	};
 
+	wlan_en_reg: fixedregulator {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		startup-delay-us = <70000>;
+
+		gpio = <&gpio2 25 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	x13_clk: x13 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -243,6 +254,12 @@
 		power-source = <1800>;
 	};
 
+	sdhi3_pins: sd3 {
+		groups = "sdhi3_data4", "sdhi3_ctrl";
+		function = "sdhi3";
+		power-source = <1800>;
+	};
+
 	sound_pins: sound {
 		groups = "ssi01239_ctrl", "ssi0_data";
 		function = "ssi";
@@ -300,6 +317,27 @@
 	status = "okay";
 };
 
+&sdhi3 {
+	status = "okay";
+	pinctrl-0 = <&sdhi3_pins>;
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
+		interrupt-parent = <&gpio1>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
+
 &usb2_phy0 {
 	renesas,no-otg-pins;
 	status = "okay";
-- 
2.7.4
