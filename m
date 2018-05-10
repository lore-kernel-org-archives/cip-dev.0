From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:10 +0100
Subject: [cip-dev] [PATCH 21/62] ASoC: rsnd: add missing DT example for
	Simple Card
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-22-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit f3f17d32fe0f3be9b1514c7e6245edee3673dccc)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 .../devicetree/bindings/sound/renesas,rsnd.txt     | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index bbcb327..27c45cb 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -246,3 +246,43 @@ rcar_sound: sound at ec500000 {
 		};
 	};
 };
+
+Example: simple sound card
+
+	rsnd_ak4643: sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&sndcodec>;
+		simple-audio-card,frame-master = <&sndcodec>;
+
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&ak4643>;
+			clocks = <&audio_clock>;
+		};
+	};
+
+&rcar_sound {
+	pinctrl-0 = <&sound_pins &sound_clk_pins>;
+	pinctrl-names = "default";
+
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+
+	status = "okay";
+
+	rcar_sound,dai {
+		dai0 {
+			playback = <&ssi0 &src2 &dvc0>;
+			capture  = <&ssi1 &src3 &dvc1>;
+		};
+	};
+};
+
+&ssi1 {
+	shared-pin;
+};
-- 
2.7.4
