From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 07:57:55 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 2/6] arm64: dts: renesas:
	hihope-common: Add HDMI audio support
In-Reply-To: <1571295479-39328-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295479-39328-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295479-39328-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit e77ad88d0c6228af65d0a0d49b264c2fb249afcf upstream.

This patch adds support for HDMI audio to the device tree
common to the HiHope RZ/G2M and the HiHope RZ/G2N.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index 0daff2d..3e376d2 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -81,6 +81,14 @@
 		regulator-always-on;
 	};
 
+	sound_card: sound {
+		compatible = "audio-graph-card";
+
+		label = "rcar-sound";
+
+		dais = <&rsnd_port0>;
+	};
+
 	vbus0_usb2: regulator-vbus0-usb2 {
 		compatible = "regulator-fixed";
 
@@ -129,6 +137,10 @@
 	};
 };
 
+&audio_clk_a {
+	clock-frequency = <22579200>;
+};
+
 &du {
 	clocks = <&cpg CPG_MOD 724>,
 		 <&cpg CPG_MOD 723>,
@@ -176,6 +188,12 @@
 				remote-endpoint = <&hdmi0_con>;
 			};
 		};
+		port at 2 {
+			reg = <2>;
+			dw_hdmi0_snd_in: endpoint {
+				remote-endpoint = <&rsnd_endpoint0>;
+			};
+		};
 	};
 };
 
@@ -272,6 +290,11 @@
 		power-source = <1800>;
 	};
 
+	sound_clk_pins: sound_clk {
+		groups = "audio_clk_a_a";
+		function = "audio_clk";
+	};
+
 	usb0_pins: usb0 {
 		groups = "usb0";
 		function = "usb0";
@@ -295,6 +318,30 @@
 	};
 };
 
+&rcar_sound {
+	pinctrl-0 = <&sound_clk_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+
+	ports {
+		rsnd_port0: port at 0 {
+			rsnd_endpoint0: endpoint {
+				remote-endpoint = <&dw_hdmi0_snd_in>;
+
+				dai-format = "i2s";
+				bitclock-master = <&rsnd_endpoint0>;
+				frame-master = <&rsnd_endpoint0>;
+
+				playback = <&ssi2>;
+			};
+		};
+	};
+};
+
 &rwdt {
 	timeout-sec = <60>;
 	status = "okay";
-- 
2.7.4
