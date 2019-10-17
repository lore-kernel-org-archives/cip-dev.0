From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:04:47 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 15/57] ASoC: convert
	for_each_rtd_codec_dai() for missing part
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-16-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 7afecb3073e357ebfe4087e4ab8bb493c32bb652 upstream.

commit 0b7990e38971 ("ASoC: add for_each_rtd_codec_dai() macro")
added for_each_rtd_codec_dai(), but it didn't convert few loop
which is not using "rtd". This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/soc-pcm.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 9a64f6d..06eedb5 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1304,6 +1304,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		struct snd_soc_dapm_widget *widget, int stream)
 {
 	struct snd_soc_pcm_runtime *be;
+	struct snd_soc_dai *dai;
 	int i;
 
 	dev_dbg(card->dev, "ASoC: find BE for widget %s\n", widget->name);
@@ -1321,8 +1322,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (be->cpu_dai->playback_widget == widget)
 				return be;
 
-			for (i = 0; i < be->num_codecs; i++) {
-				struct snd_soc_dai *dai = be->codec_dais[i];
+			for_each_rtd_codec_dai(be, i, dai) {
 				if (dai->playback_widget == widget)
 					return be;
 			}
@@ -1341,8 +1341,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (be->cpu_dai->capture_widget == widget)
 				return be;
 
-			for (i = 0; i < be->num_codecs; i++) {
-				struct snd_soc_dai *dai = be->codec_dais[i];
+			for_each_rtd_codec_dai(be, i, dai) {
 				if (dai->capture_widget == widget)
 					return be;
 			}
@@ -1438,6 +1437,7 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 	struct snd_soc_dpcm *dpcm;
 	struct snd_soc_dapm_widget_list *list = *list_;
 	struct snd_soc_dapm_widget *widget;
+	struct snd_soc_dai *dai;
 	int prune = 0;
 
 	/* Destroy any old FE <--> BE connections */
@@ -1452,8 +1452,7 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 			continue;
 
 		/* is there a valid CODEC DAI widget for this BE */
-		for (i = 0; i < dpcm->be->num_codecs; i++) {
-			struct snd_soc_dai *dai = dpcm->be->codec_dais[i];
+		for_each_rtd_codec_dai(dpcm->be, i, dai) {
 			widget = dai_get_widget(dai, stream);
 
 			/* prune the BE if it's no longer in our active list */
@@ -1688,6 +1687,7 @@ static void dpcm_runtime_merge_format(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *fe = substream->private_data;
 	struct snd_soc_dpcm *dpcm;
+	struct snd_soc_dai *dai;
 	int stream = substream->stream;
 
 	if (!fe->dai_link->dpcm_merged_format)
@@ -1704,16 +1704,15 @@ static void dpcm_runtime_merge_format(struct snd_pcm_substream *substream,
 		struct snd_soc_pcm_stream *codec_stream;
 		int i;
 
-		for (i = 0; i < be->num_codecs; i++) {
+		for_each_rtd_codec_dai(be, i, dai) {
 			/*
 			 * Skip CODECs which don't support the current stream
 			 * type. See soc_pcm_init_runtime_hw() for more details
 			 */
-			if (!snd_soc_dai_stream_valid(be->codec_dais[i],
-						      stream))
+			if (!snd_soc_dai_stream_valid(dai, stream))
 				continue;
 
-			codec_dai_drv = be->codec_dais[i]->driver;
+			codec_dai_drv = dai->driver;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 				codec_stream = &codec_dai_drv->playback;
 			else
@@ -1798,6 +1797,7 @@ static void dpcm_runtime_merge_rate(struct snd_pcm_substream *substream,
 		struct snd_soc_dai_driver *codec_dai_drv;
 		struct snd_soc_pcm_stream *codec_stream;
 		struct snd_soc_pcm_stream *cpu_stream;
+		struct snd_soc_dai *dai;
 		int i;
 
 		if (stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -1809,16 +1809,15 @@ static void dpcm_runtime_merge_rate(struct snd_pcm_substream *substream,
 		*rate_max = min_not_zero(*rate_max, cpu_stream->rate_max);
 		*rates = snd_pcm_rate_mask_intersect(*rates, cpu_stream->rates);
 
-		for (i = 0; i < be->num_codecs; i++) {
+		for_each_rtd_codec_dai(be, i, dai) {
 			/*
 			 * Skip CODECs which don't support the current stream
 			 * type. See soc_pcm_init_runtime_hw() for more details
 			 */
-			if (!snd_soc_dai_stream_valid(be->codec_dais[i],
-						      stream))
+			if (!snd_soc_dai_stream_valid(dai, stream))
 				continue;
 
-			codec_dai_drv = be->codec_dais[i]->driver;
+			codec_dai_drv = dai->driver;
 			if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 				codec_stream = &codec_dai_drv->playback;
 			else
@@ -2788,6 +2787,7 @@ int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 	struct snd_soc_dpcm *dpcm;
 	struct list_head *clients =
 		&fe->dpcm[SNDRV_PCM_STREAM_PLAYBACK].be_clients;
+	struct snd_soc_dai *dai;
 
 	list_for_each_entry(dpcm, clients, list_be) {
 
@@ -2797,8 +2797,7 @@ int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 		if (be->dai_link->ignore_suspend)
 			continue;
 
-		for (i = 0; i < be->num_codecs; i++) {
-			struct snd_soc_dai *dai = be->codec_dais[i];
+		for_each_rtd_codec_dai(be, i, dai) {
 			struct snd_soc_dai_driver *drv = dai->driver;
 
 			dev_dbg(be->dev, "ASoC: BE digital mute %s\n",
-- 
2.7.4
