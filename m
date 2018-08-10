From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 10 Aug 2018 10:52:58 +0100
Subject: [cip-dev] [PATCH 15/19] ARM: dts: iwg22d-sodimm: Sound PIO support
In-Reply-To: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1533894782-26239-16-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Enable sound PIO support on carrier board.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 3838ef590119420031ad2a51ea19a9be2ea9acef)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index 21e484f..8ec45a3 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -32,6 +32,21 @@
 		clock-frequency = <26000000>;
 	};
 
+	rsnd_sgtl5000: sound {
+		compatible = "simple-audio-card";
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
 	vccq_sdhi0: regulator-vccq-sdhi0 {
 		compatible = "regulator-gpio";
 
@@ -110,6 +125,11 @@
 		power-source = <3300>;
 	};
 
+	sound_pins: sound {
+		groups = "ssi34_ctrl", "ssi3_data", "ssi4_data";
+		function = "ssi";
+	};
+
 	usb0_pins: usb0 {
 		groups = "usb0";
 		function = "usb0";
@@ -121,6 +141,23 @@
 	};
 };
 
+&rcar_sound {
+	pinctrl-0 = <&sound_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	/* Single DAI */
+
+	#sound-dai-cells = <0>;
+
+	rcar_sound,dai {
+		dai0 {
+			playback = <&ssi3>;
+			capture = <&ssi4>;
+		};
+	};
+};
+
 &scif4 {
 	pinctrl-0 = <&scif4_pins>;
 	pinctrl-names = "default";
@@ -169,6 +206,15 @@
 	pinctrl-names = "default";
 };
 
+&ssi3 {
+	pio-transfer;
+};
+
+&ssi4 {
+	pio-transfer;
+	shared-pin;
+};
+
 &usbphy {
 	status = "okay";
 };
-- 
2.7.4
