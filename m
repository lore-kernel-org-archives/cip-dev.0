From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 10 Aug 2018 10:52:44 +0100
Subject: [cip-dev] [PATCH 01/19] ASoC: rsnd: remove platform boot support
	from src.c
In-Reply-To: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1533894782-26239-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1533894782-26239-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

No board is using Renesas sound driver via platform boot now.
This means all user is using DT boot. Platform boot support is
no longer needed. But, it strongly depends on platform boot style.
This patch removes platform boot support from src.c

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit adf6a6815952c6c6092ae15e27c1b782fd96c6a3)
(reworked to fit the context)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/src.c | 161 ++++++++++++++++--------------------------------
 1 file changed, 52 insertions(+), 109 deletions(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 460d29c..2fcd3d3 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -30,6 +30,7 @@ struct rsnd_src {
 
 #define RSND_SRC_NAME_SIZE 16
 
+#define rsnd_src_get(priv, id) ((struct rsnd_src *)(priv->src) + id)
 #define rsnd_src_nr(priv) ((priv)->src_nr)
 #define rsnd_enable_sync_convert(src) ((src)->sen.val)
 #define rsnd_src_of_node(priv) \
@@ -69,55 +70,6 @@ struct rsnd_src {
  *        |-----------------|
  */
 
-/*
- *	How to use SRC bypass mode for debugging
- *
- * SRC has bypass mode, and it is useful for debugging.
- * In Gen2 case,
- * SRCm_MODE controls whether SRC is used or not
- * SSI_MODE0 controls whether SSIU which receives SRC data
- * is used or not.
- * Both SRCm_MODE/SSI_MODE0 settings are needed if you use SRC,
- * but SRC bypass mode needs SSI_MODE0 only.
- *
- * This driver request
- * struct rsnd_src_platform_info {
- *	u32 convert_rate;
- *	int dma_id;
- * }
- *
- * rsnd_src_convert_rate() indicates
- * above convert_rate, and it controls
- * whether SRC is used or not.
- *
- * ex) doesn't use SRC
- * static struct rsnd_dai_platform_info rsnd_dai = {
- *	.playback = { .ssi = &rsnd_ssi[0], },
- * };
- *
- * ex) uses SRC
- * static struct rsnd_src_platform_info rsnd_src[] = {
- *	RSND_SCU(48000, 0),
- *	...
- * };
- * static struct rsnd_dai_platform_info rsnd_dai = {
- *	.playback = { .ssi = &rsnd_ssi[0], .src = &rsnd_src[0] },
- * };
- *
- * ex) uses SRC bypass mode
- * static struct rsnd_src_platform_info rsnd_src[] = {
- *	RSND_SCU(0, 0),
- *	...
- * };
- * static struct rsnd_dai_platform_info rsnd_dai = {
- *	.playback = { .ssi = &rsnd_ssi[0], .src = &rsnd_src[0] },
- * };
- *
- */
-
-/*
- *		Gen1/Gen2 common functions
- */
 static void rsnd_src_soft_reset(struct rsnd_mod *mod)
 {
 	rsnd_mod_write(mod, SRC_SWRSR, 0);
@@ -997,51 +949,7 @@ struct rsnd_mod *rsnd_src_mod_get(struct rsnd_priv *priv, int id)
 	if (WARN_ON(id < 0 || id >= rsnd_src_nr(priv)))
 		id = 0;
 
-	return rsnd_mod_get((struct rsnd_src *)(priv->src) + id);
-}
-
-static void rsnd_of_parse_src(struct platform_device *pdev,
-			      const struct rsnd_of_data *of_data,
-			      struct rsnd_priv *priv)
-{
-	struct device_node *src_node;
-	struct device_node *np;
-	struct rcar_snd_info *info = rsnd_priv_to_info(priv);
-	struct rsnd_src_platform_info *src_info;
-	struct device *dev = &pdev->dev;
-	int nr, i;
-
-	if (!of_data)
-		return;
-
-	src_node = rsnd_src_of_node(priv);
-	if (!src_node)
-		return;
-
-	nr = of_get_child_count(src_node);
-	if (!nr)
-		goto rsnd_of_parse_src_end;
-
-	src_info = devm_kzalloc(dev,
-				sizeof(struct rsnd_src_platform_info) * nr,
-				GFP_KERNEL);
-	if (!src_info) {
-		dev_err(dev, "src info allocation error\n");
-		goto rsnd_of_parse_src_end;
-	}
-
-	info->src_info		= src_info;
-	info->src_info_nr	= nr;
-
-	i = 0;
-	for_each_child_of_node(src_node, np) {
-		src_info[i].irq = irq_of_parse_and_map(np, 0);
-
-		i++;
-	}
-
-rsnd_of_parse_src_end:
-	of_node_put(src_node);
+	return rsnd_mod_get(rsnd_src_get(priv, id));
 }
 
 int rsnd_src_probe(struct platform_device *pdev,
@@ -1049,6 +957,9 @@ int rsnd_src_probe(struct platform_device *pdev,
 		   struct rsnd_priv *priv)
 {
 	struct rcar_snd_info *info = rsnd_priv_to_info(priv);
+	struct rsnd_src_platform_info *src_info;
+	struct device_node *node;
+	struct device_node *np;
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct rsnd_src *src;
 	struct rsnd_mod_ops *ops;
@@ -1068,38 +979,70 @@ int rsnd_src_probe(struct platform_device *pdev,
 		return -EIO;
 	}
 
-	rsnd_of_parse_src(pdev, of_data, priv);
+	node = rsnd_src_of_node(priv);
+	if (!node)
+		return 0; /* not used is not error */
 
-	/*
-	 * init SRC
-	 */
-	nr	= info->src_info_nr;
-	if (!nr)
-		return 0;
+	nr = of_get_child_count(node);
+	if (!nr) {
+		ret = -EINVAL;
+		goto rsnd_src_probe_done;
+	}
+
+	src_info = devm_kzalloc(dev,
+				sizeof(struct rsnd_src_platform_info) * nr,
+				GFP_KERNEL);
+	if (!src_info) {
+		ret = -ENOMEM;
+		goto rsnd_src_probe_done;
+	}
+
+	info->src_info = src_info;
+	info->src_info_nr = nr;
 
 	src	= devm_kzalloc(dev, sizeof(*src) * nr, GFP_KERNEL);
-	if (!src)
-		return -ENOMEM;
+	if (!src) {
+		ret = -ENOMEM;
+		goto rsnd_src_probe_done;
+	}
 
 	priv->src_nr	= nr;
 	priv->src	= src;
 
-	for_each_rsnd_src(src, priv, i) {
+	i = 0;
+	for_each_child_of_node(node, np) {
+		src = rsnd_src_get(priv, i);
+
 		snprintf(name, RSND_SRC_NAME_SIZE, "%s.%d",
 			 SRC_NAME, i);
 
+		src_info[i].irq = irq_of_parse_and_map(np, 0);
+		if (!src_info[i].irq) {
+			ret = -EINVAL;
+			goto rsnd_src_probe_done;
+		}
+
 		clk = devm_clk_get(dev, name);
-		if (IS_ERR(clk))
-			return PTR_ERR(clk);
+		if (IS_ERR(clk)) {
+			ret = PTR_ERR(clk);
+			goto rsnd_src_probe_done;
+		}
 
-		src->info = &info->src_info[i];
+		src->info = &src_info[i];
 
 		ret = rsnd_mod_init(priv, rsnd_mod_get(src), ops, clk, RSND_MOD_SRC, i);
 		if (ret)
-			return ret;
+			goto rsnd_src_probe_done;
+
+		i++;
 	}
 
-	return 0;
+	ret = 0;
+
+rsnd_src_probe_done:
+	of_node_put(node);
+
+	return ret;
 }
 
 void rsnd_src_remove(struct platform_device *pdev,
-- 
2.7.4
