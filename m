From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:23 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 51/57] ASoC: rsnd: move pcm_new from
	snd_soc_component_driver to snd_soc_dai_driver
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-52-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit e9b5daad4e9bdd1b9e467873a4463c867ccf9ff1 upstream.

snd_soc_dai_driver :: pcm_new has snd_soc_dai as parameter, but
snd_soc_component_driver :: pcm_new doesn't have it.

rsnd driver needs snd_soc_dai at pcm_new.
This patch moves .pcm_new from snd_soc_component_driver to
snd_soc_dai_driver, and don't use rtd->cpu_dai anymore.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/core.c | 120 +++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 675691a..0b90cd8 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1170,6 +1170,65 @@ static struct device_node *rsnd_dai_of_node(struct rsnd_priv *priv,
 	return ret;
 }
 
+
+#define PREALLOC_BUFFER		(32 * 1024)
+#define PREALLOC_BUFFER_MAX	(32 * 1024)
+
+static int rsnd_preallocate_pages(struct snd_soc_pcm_runtime *rtd,
+				  struct rsnd_dai_stream *io,
+				  int stream)
+{
+	struct rsnd_priv *priv = rsnd_io_to_priv(io);
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct snd_pcm_substream *substream;
+
+	/*
+	 * use Audio-DMAC dev if we can use IPMMU
+	 * see
+	 *	rsnd_dmaen_attach()
+	 */
+	if (io->dmac_dev)
+		dev = io->dmac_dev;
+
+	for (substream = rtd->pcm->streams[stream].substream;
+	     substream;
+	     substream = substream->next) {
+		snd_pcm_lib_preallocate_pages(substream,
+					      SNDRV_DMA_TYPE_DEV,
+					      dev,
+					      PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+	}
+
+	return 0;
+}
+
+static int rsnd_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			struct snd_soc_dai *dai)
+{
+	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
+	int ret;
+
+	ret = rsnd_dai_call(pcm_new, &rdai->playback, rtd);
+	if (ret)
+		return ret;
+
+	ret = rsnd_dai_call(pcm_new, &rdai->capture, rtd);
+	if (ret)
+		return ret;
+
+	ret = rsnd_preallocate_pages(rtd, &rdai->playback,
+				     SNDRV_PCM_STREAM_PLAYBACK);
+	if (ret)
+		return ret;
+
+	ret = rsnd_preallocate_pages(rtd, &rdai->capture,
+				     SNDRV_PCM_STREAM_CAPTURE);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static void __rsnd_dai_probe(struct rsnd_priv *priv,
 			     struct device_node *dai_np,
 			     int dai_i)
@@ -1192,6 +1251,7 @@ static void __rsnd_dai_probe(struct rsnd_priv *priv,
 	rdai->priv	= priv;
 	drv->name	= rdai->name;
 	drv->ops	= &rsnd_soc_dai_ops;
+	drv->pcm_new	= rsnd_pcm_new;
 
 	snprintf(io_playback->name, RSND_DAI_NAME_SIZE,
 		 "DAI%d Playback", dai_i);
@@ -1566,68 +1626,8 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 /*
  *		snd_soc_component
  */
-
-#define PREALLOC_BUFFER		(32 * 1024)
-#define PREALLOC_BUFFER_MAX	(32 * 1024)
-
-static int rsnd_preallocate_pages(struct snd_soc_pcm_runtime *rtd,
-				  struct rsnd_dai_stream *io,
-				  int stream)
-{
-	struct rsnd_priv *priv = rsnd_io_to_priv(io);
-	struct device *dev = rsnd_priv_to_dev(priv);
-	struct snd_pcm_substream *substream;
-
-	/*
-	 * use Audio-DMAC dev if we can use IPMMU
-	 * see
-	 *	rsnd_dmaen_attach()
-	 */
-	if (io->dmac_dev)
-		dev = io->dmac_dev;
-
-	for (substream = rtd->pcm->streams[stream].substream;
-	     substream;
-	     substream = substream->next) {
-		snd_pcm_lib_preallocate_pages(substream,
-					SNDRV_DMA_TYPE_DEV,
-					dev,
-					PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
-	}
-
-	return 0;
-}
-
-static int rsnd_pcm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_soc_dai *dai = rtd->cpu_dai;
-	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
-	int ret;
-
-	ret = rsnd_dai_call(pcm_new, &rdai->playback, rtd);
-	if (ret)
-		return ret;
-
-	ret = rsnd_dai_call(pcm_new, &rdai->capture, rtd);
-	if (ret)
-		return ret;
-
-	ret = rsnd_preallocate_pages(rtd, &rdai->playback,
-				     SNDRV_PCM_STREAM_PLAYBACK);
-	if (ret)
-		return ret;
-
-	ret = rsnd_preallocate_pages(rtd, &rdai->capture,
-				     SNDRV_PCM_STREAM_CAPTURE);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 static const struct snd_soc_component_driver rsnd_soc_component = {
 	.ops		= &rsnd_pcm_ops,
-	.pcm_new	= rsnd_pcm_new,
 	.name		= "rsnd",
 };
 
-- 
2.7.4
