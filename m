From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:04:42 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 10/57] ASoC: rsnd: ssiu: Support to
	init different BUSIF instance
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jiada Wang <jiada_wang@mentor.com>

commit 2e66d523cd055ac3fa920f7e630c4bfa80d24c24 upstream.

Currently ssiu's .init is only called once during audio stream.
But SSIU with different BUSIF, shall be initialized each time,
even they are used in the same audio stream.

This patch introduces ssiu_status for BUSIF0 to BUSIF7 in rsnd_ssiu,
to make sure same .init for different BUSIF can always be executed.

To avoid the first stopped stream to stop the whole SSIU,
which may still has other BUSIF instance running, use usrcnt to count
the usage of SSIU, only the last user of SSIU can stop the whole SSIU.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[Kuninori: tidyup for upstream]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/ssiu.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index a9605a0..39b6764 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -10,9 +10,12 @@
 
 struct rsnd_ssiu {
 	struct rsnd_mod mod;
+	u32 busif_status[8]; /* for BUSIF0 - BUSIF7 */
+	unsigned int usrcnt;
 };
 
 #define rsnd_ssiu_nr(priv) ((priv)->ssiu_nr)
+#define rsnd_mod_to_ssiu(_mod) container_of((_mod), struct rsnd_ssiu, mod)
 #define for_each_rsnd_ssiu(pos, priv, i)				\
 	for (i = 0;							\
 	     (i < rsnd_ssiu_nr(priv)) &&				\
@@ -120,6 +123,7 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 			       struct rsnd_dai_stream *io,
 			       struct rsnd_priv *priv)
 {
+	struct rsnd_ssiu *ssiu = rsnd_mod_to_ssiu(mod);
 	int hdmi = rsnd_ssi_hdmi_port(io);
 	int ret;
 	u32 mode = 0;
@@ -128,6 +132,8 @@ static int rsnd_ssiu_init_gen2(struct rsnd_mod *mod,
 	if (ret < 0)
 		return ret;
 
+	ssiu->usrcnt++;
+
 	if (rsnd_runtime_is_ssi_tdm(io)) {
 		/*
 		 * TDM Extend Mode
@@ -255,6 +261,7 @@ static int rsnd_ssiu_stop_gen2(struct rsnd_mod *mod,
 			       struct rsnd_dai_stream *io,
 			       struct rsnd_priv *priv)
 {
+	struct rsnd_ssiu *ssiu = rsnd_mod_to_ssiu(mod);
 	int busif = rsnd_ssi_get_busif(io);
 
 	if (!rsnd_ssi_use_busif(io))
@@ -262,6 +269,9 @@ static int rsnd_ssiu_stop_gen2(struct rsnd_mod *mod,
 
 	rsnd_mod_bset(mod, SSI_CTRL, 1 << (busif * 4), 0);
 
+	if (--ssiu->usrcnt)
+		return 0;
+
 	if (rsnd_ssi_multi_slaves_runtime(io))
 		rsnd_mod_write(mod, SSI_CONTROL, 0);
 
@@ -294,6 +304,16 @@ int rsnd_ssiu_attach(struct rsnd_dai_stream *io,
 	return rsnd_dai_connect(mod, io, mod->type);
 }
 
+static u32 *rsnd_ssiu_get_status(struct rsnd_dai_stream *io,
+				 struct rsnd_mod *mod,
+				 enum rsnd_mod_type type)
+{
+	struct rsnd_ssiu *ssiu = rsnd_mod_to_ssiu(mod);
+	int busif = rsnd_ssi_get_busif(io);
+
+	return &ssiu->busif_status[busif];
+}
+
 int rsnd_ssiu_probe(struct rsnd_priv *priv)
 {
 	struct device *dev = rsnd_priv_to_dev(priv);
@@ -317,7 +337,7 @@ int rsnd_ssiu_probe(struct rsnd_priv *priv)
 
 	for_each_rsnd_ssiu(ssiu, priv, i) {
 		ret = rsnd_mod_init(priv, rsnd_mod_get(ssiu),
-				    ops, NULL, rsnd_mod_get_status,
+				    ops, NULL, rsnd_ssiu_get_status,
 				    RSND_MOD_SSIU, i);
 		if (ret)
 			return ret;
-- 
2.7.4
