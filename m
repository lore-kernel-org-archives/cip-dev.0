From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:09 +0100
Subject: [cip-dev] [PATCH 20/62] ASoC: rsnd: audio_clkout0/1/2/3 are
	optional properties
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-21-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Renesas sound driver can output Audio-clkout0/1/2/3,
but these are optional properties for each board.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit 209c09071f365aed48f8a7af5a25ea3edcfb891c)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index c57cbd6..bbcb327 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -34,6 +34,8 @@ Required properties:
 				  see below for detail.
 - #sound-dai-cells		: it must be 0 if your system is using single DAI
 				  it must be 1 if your system is using multi  DAI
+
+Optional properties:
 - #clock-cells			: it must be 0 if your system has audio_clkout
 				  it must be 1 if your system has audio_clkout0/1/2/3
 - clock-frequency		: for all audio_clkout0/1/2/3
-- 
2.7.4
