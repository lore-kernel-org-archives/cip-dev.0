From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:14 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 42/57] ASoC: rsnd: synchronize
	connection check for simple-card/audio-graph
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-43-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit f497c88b195eaee8733a304f2a1dc27fb319c9c3 upstream.

Current rsnd driver has below function to check connection
	rsnd_parse_connect_simple()
	rsnd_parse_connect_graph()
But these have different parameters. This patch synchronize these
for cleanup.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 5e044ee..d53f245 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1026,16 +1026,13 @@ static const struct snd_soc_dai_ops rsnd_soc_dai_ops = {
 };
 
 static void rsnd_parse_connect_simple(struct rsnd_priv *priv,
-				      struct device_node *dai_np,
-				      int dai_i, int is_play)
+				      struct rsnd_dai_stream *io,
+				      struct device_node *dai_np)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
-	struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
-	struct rsnd_dai_stream *io = is_play ?
-		&rdai->playback :
-		&rdai->capture;
 	struct device_node *ssiu_np = rsnd_ssiu_of_node(priv);
 	struct device_node *np;
+	int is_play = rsnd_io_is_play(io);
 	int i, j;
 
 	if (!ssiu_np)
@@ -1286,8 +1283,10 @@ static int rsnd_dai_probe(struct rsnd_priv *priv)
 		for_each_child_of_node(dai_node, dai_np) {
 			__rsnd_dai_probe(priv, dai_np, dai_i);
 			if (rsnd_is_gen3(priv)) {
-				rsnd_parse_connect_simple(priv, dai_np, dai_i, 1);
-				rsnd_parse_connect_simple(priv, dai_np, dai_i, 0);
+				struct rsnd_dai *rdai = rsnd_rdai_get(priv, dai_i);
+
+				rsnd_parse_connect_simple(priv, &rdai->playback, dai_np);
+				rsnd_parse_connect_simple(priv, &rdai->capture,  dai_np);
 			}
 			dai_i++;
 		}
-- 
2.7.4
