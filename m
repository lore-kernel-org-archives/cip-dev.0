From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:31 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 32/32] arm64: dts: renesas: cat874: Add
	HDMI audio
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-33-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit a597dcb1d4ab7ddbba7e80b023eff892926f146c upstream.

The CAT874 board pushes sound via I2S over SSI0 into the
TDA19988BET chip.
This commit wires things up so that we can get sound out of
the HDMI interface.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 56 +++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index 0623950..b7183f1 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 #include "r8a774c0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/display/tda998x.h>
 
 / {
 	model = "Silicon Linux RZ/G2E 96board platform (CAT874)";
@@ -63,6 +64,23 @@
 		reg = <0x0 0x48000000 0x0 0x78000000>;
 	};
 
+	sound: sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,name = "CAT874 HDMI sound";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sndcpu>;
+		simple-audio-card,frame-master = <&sndcpu>;
+
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&tda19988>;
+		};
+	};
+
 	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
@@ -93,6 +111,10 @@
 	};
 };
 
+&audio_clk_a {
+	clock-frequency = <22579200>;
+};
+
 &du {
 	pinctrl-0 = <&du_pins>;
 	pinctrl-names = "default";
@@ -133,6 +155,10 @@
 
 		video-ports = <0x234501>;
 
+		#sound-dai-cells = <0>;
+		audio-ports = <TDA998x_I2S 0x03>;
+		clocks = <&rcar_sound 1>;
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -216,6 +242,36 @@
 		function = "sdhi0";
 		power-source = <1800>;
 	};
+
+	sound_pins: sound {
+		groups = "ssi01239_ctrl", "ssi0_data";
+		function = "ssi";
+	};
+
+	sound_clk_pins: sound_clk {
+		groups = "audio_clkout1_a";
+		function = "audio_clk";
+	};
+};
+
+&rcar_sound {
+	pinctrl-0 = <&sound_pins &sound_clk_pins>;
+	pinctrl-names = "default";
+
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+
+	/* audio_clkout0/1/2/3 */
+	#clock-cells = <1>;
+	clock-frequency = <11289600>;
+
+	status = "okay";
+
+	rcar_sound,dai {
+		dai0 {
+			playback = <&ssi0 &src0 &dvc0>;
+		};
+	};
 };
 
 &rwdt {
-- 
2.7.4
