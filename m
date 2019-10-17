From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:06 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 34/57] ASoC: rsnd: makes
	rsnd_ssi_is_dma_mode() static
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-35-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 0ade2ccfb81244d0a271a5f9917f9fccc349b6cf upstream.

ssi.c only is using rsnd_ssi_is_dma_mode().
Let's move it as static function.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/rsnd.h | 1 -
 sound/soc/sh/rcar/ssi.c  | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 64c3a3b..3c57129 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -726,7 +726,6 @@ extern const char * const volume_ramp_rate[];
 int rsnd_ssi_probe(struct rsnd_priv *priv);
 void rsnd_ssi_remove(struct rsnd_priv *priv);
 struct rsnd_mod *rsnd_ssi_mod_get(struct rsnd_priv *priv, int id);
-int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
 int rsnd_ssi_use_busif(struct rsnd_dai_stream *io);
 u32 rsnd_ssi_multi_slaves_runtime(struct rsnd_dai_stream *io);
 
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 8a9d30b..8eebcf6 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -117,6 +117,8 @@ struct rsnd_ssi {
 	(rsnd_ssi_run_mods(io) & (1 << rsnd_mod_id(mod)))
 #define rsnd_ssi_can_output_clk(mod) (!__rsnd_ssi_is_pin_sharing(mod))
 
+static int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod);
+
 int rsnd_ssi_use_busif(struct rsnd_dai_stream *io)
 {
 	struct rsnd_mod *mod = rsnd_io_to_mod_ssi(io);
@@ -1003,12 +1005,11 @@ static struct rsnd_mod_ops rsnd_ssi_dma_ops = {
 	.get_status	= rsnd_ssi_get_status,
 };
 
-int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod)
+static int rsnd_ssi_is_dma_mode(struct rsnd_mod *mod)
 {
 	return mod->ops == &rsnd_ssi_dma_ops;
 }
 
-
 /*
  *		ssi mod function
  */
-- 
2.7.4
