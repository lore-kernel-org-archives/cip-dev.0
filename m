From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:20 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 48/57] ASoC: rsnd: src: Avoid a
	potential deadlock
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-49-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jiada Wang <jiada_wang@mentor.com>

commit ba164a49f8f7390b036713bf8a70a150a938c670 upstream.

lockdep warns us that priv->lock and k->k_lock can cause a
deadlock when after acquire of k->k_lock, process is interrupted
by src, while in another routine of src .init, k->k_lock is
acquired with priv->lock held.

This patch avoids a potential deadlock by not calling soc_device_match()
in SRC .init callback, instead it adds new soc fields in priv->flags to
differentiate SoCs.

Fixes: linux-next commit 7674bec4fc09 ("ASoC: rsnd: update BSDSR/BSDISR handling")
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/core.c | 2 ++
 sound/soc/sh/rcar/rsnd.h | 5 +++++
 sound/soc/sh/rcar/src.c  | 9 +--------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 96d2b39..f361118 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -110,6 +110,8 @@ static const struct of_device_id rsnd_of_match[] = {
 	{ .compatible = "renesas,rcar_sound-gen1", .data = (void *)RSND_GEN1 },
 	{ .compatible = "renesas,rcar_sound-gen2", .data = (void *)RSND_GEN2 },
 	{ .compatible = "renesas,rcar_sound-gen3", .data = (void *)RSND_GEN3 },
+	/* Special Handling */
+	{ .compatible = "renesas,rcar_sound-r8a77990", .data = (void *)(RSND_GEN3 | RSND_SOC_E) },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rsnd_of_match);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 90625c5..0e6ef4e1 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -607,6 +607,8 @@ struct rsnd_priv {
 #define RSND_GEN1	(1 << 0)
 #define RSND_GEN2	(2 << 0)
 #define RSND_GEN3	(3 << 0)
+#define RSND_SOC_MASK	(0xFF << 4)
+#define RSND_SOC_E	(1 << 4) /* E1/E2/E3 */
 
 	/*
 	 * below value will be filled on rsnd_gen_probe()
@@ -679,6 +681,9 @@ struct rsnd_priv {
 #define rsnd_is_gen1(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN1)
 #define rsnd_is_gen2(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN2)
 #define rsnd_is_gen3(priv)	(((priv)->flags & RSND_GEN_MASK) == RSND_GEN3)
+#define rsnd_is_e3(priv)	(((priv)->flags & \
+					(RSND_GEN_MASK | RSND_SOC_MASK)) == \
+					(RSND_GEN3 | RSND_SOC_E))
 
 #define rsnd_flags_has(p, f) ((p)->flags & (f))
 #define rsnd_flags_set(p, f) ((p)->flags |= (f))
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index db81e06..45096a6 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -14,7 +14,6 @@
  */
 
 #include "rsnd.h"
-#include <linux/sys_soc.h>
 
 #define SRC_NAME "src"
 
@@ -189,18 +188,12 @@ const static u32 chan222222[] = {
 	0x00000006, /* 1 to 2 */
 };
 
-static const struct soc_device_attribute ov_soc[] = {
-	{ .soc_id = "r8a77990" }, /* E3 */
-	{ /* sentinel */ }
-};
-
 static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 				      struct rsnd_mod *mod)
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
-	const struct soc_device_attribute *soc = soc_device_match(ov_soc);
 	int is_play = rsnd_io_is_play(io);
 	int use_src = 0;
 	u32 fin, fout;
@@ -307,7 +300,7 @@ static void rsnd_src_set_convert_rate(struct rsnd_dai_stream *io,
 	/*
 	 * E3 need to overwrite
 	 */
-	if (soc)
+	if (rsnd_is_e3(priv))
 		switch (rsnd_mod_id(mod)) {
 		case 0:
 		case 4:
-- 
2.7.4
