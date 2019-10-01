From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:30 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 31/32] arm64: dts: renesas: cat874: Add
	HDMI video support
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-32-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 94fc0ee22a5cb3a744a38906a55323fd6ac793fa upstream.

The CAT874 board comes with a HDMI connector, managed by
a TDA19988BET chip, connected to the RZ/G2E SoC via DPAD.
This patch adds the necessary support to the board DT.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 81 +++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index 9241407..0623950 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -22,6 +22,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_out: endpoint {
+				remote-endpoint = <&tda19988_out>;
+			};
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 
@@ -74,6 +85,31 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	x13_clk: x13 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <74250000>;
+	};
+};
+
+&du {
+	pinctrl-0 = <&du_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	clocks = <&cpg CPG_MOD 724>,
+		 <&cpg CPG_MOD 723>,
+		 <&x13_clk>;
+	clock-names = "du.0", "du.1", "dclkin.0";
+
+	ports {
+		port at 0 {
+			endpoint {
+				remote-endpoint = <&tda19988_in>;
+			};
+		};
+	};
 };
 
 &ehci0 {
@@ -85,6 +121,39 @@
 	clock-frequency = <48000000>;
 };
 
+&i2c0 {
+	status = "okay";
+	clock-frequency = <100000>;
+
+	tda19988: tda19988 at 70 {
+		compatible = "nxp,tda998x";
+		reg = <0x70>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+
+		video-ports = <0x234501>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				tda19988_in: endpoint {
+					remote-endpoint = <&du_out_rgb>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+				tda19988_out: endpoint {
+					remote-endpoint = <&hdmi_con_out>;
+				};
+			};
+		};
+	};
+};
+
 &i2c1 {
 	pinctrl-0 = <&i2c1_pins>;
 	pinctrl-names = "default";
@@ -98,6 +167,13 @@
 	};
 };
 
+&lvds0 {
+	status = "okay";
+
+	clocks = <&cpg CPG_MOD 727>, <&x13_clk>, <&extal_clk>;
+	clock-names = "fck", "dclkin.0", "extal";
+};
+
 &ohci0 {
 	dr_mode = "host";
 	status = "okay";
@@ -113,6 +189,11 @@
 };
 
 &pfc {
+	du_pins: du {
+		groups = "du_rgb888", "du_clk_out_0", "du_sync", "du_disp",
+			 "du_clk_in_0";
+		function = "du";
+	};
 
 	i2c1_pins: i2c1 {
 		groups = "i2c1_b";
-- 
2.7.4
