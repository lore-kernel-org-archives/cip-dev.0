From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:27 +0100
Subject: [cip-dev] [PATCH 38/62] ARM: dts: iwg20d-q7-common: Sound PIO
	support
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-39-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Enable sound PIO support on carrier board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit cfa2e2f7cf22d0523a88c6284606baa9b2698866)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi | 46 +++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 8d69a67..01f60ce 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -34,6 +34,22 @@
 		regulator-always-on;
 	};
 
+	rsnd_sgtl5000: sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sndcodec>;
+		simple-audio-card,frame-master = <&sndcodec>;
+
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
+	};
+
 	vcc_sdhi1: regulator-vcc-sdhi1 {
 		compatible = "regulator-fixed";
 
@@ -160,6 +176,11 @@
 		power-source = <3300>;
 	};
 
+	sound_pins: sound {
+		groups = "ssi0129_ctrl", "ssi0_data", "ssi1_data";
+		function = "ssi";
+	};
+
 	usb0_pins: usb0 {
 		groups = "usb0";
 		function = "usb0";
@@ -171,6 +192,22 @@
 	};
 };
 
+&rcar_sound {
+	pinctrl-0 = <&sound_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+
+	rcar_sound,dai {
+		dai0 {
+			playback = <&ssi1>;
+			capture = <&ssi0>;
+		};
+	};
+};
+
 &scif0 {
 	pinctrl-0 = <&scif0_pins>;
 	pinctrl-names = "default";
@@ -197,6 +234,15 @@
 	status = "okay";
 };
 
+&ssi0 {
+	pio-transfer;
+};
+
+&ssi1 {
+	pio-transfer;
+	shared-pin;
+};
+
 &usbphy {
 	status = "okay";
 };
-- 
2.7.4
