From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:11 +0100
Subject: [cip-dev] [PATCH 22/62] ASoC: rsnd: add missing DT example for
	Simple Card with TDM
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-23-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit 44bf5361e21d507e23f8cf8d696c0600f3795e54)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 .../devicetree/bindings/sound/renesas,rsnd.txt        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 27c45cb..3f03fd0 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -286,3 +286,22 @@ Example: simple sound card
 &ssi1 {
 	shared-pin;
 };
+
+Example: simple sound card for TDM
+
+	rsnd_tdm: sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&sndcodec>;
+		simple-audio-card,frame-master = <&sndcodec>;
+
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+			dai-tdm-slot-num = <6>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&xxx>;
+		};
+	};
-- 
2.7.4
