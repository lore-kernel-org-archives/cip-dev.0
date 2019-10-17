From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:17 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 45/57] ASoC: sh: Drop superfluous PCM
	preallocation error checks
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-46-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takashi Iwai <tiwai@suse.de>

commit b76c7fe6c99d427a064e5e152dca7fe24f424f53 upstream.

snd_pcm_lib_preallocate_pages() and co always succeed, so the error
check is simply redundant.  Drop it.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/fsi.c       |  3 ++-
 sound/soc/sh/rcar/core.c |  5 +----
 sound/soc/sh/siu_pcm.c   | 13 +------------
 3 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index aa7e902..285afba 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1768,11 +1768,12 @@ static const struct snd_pcm_ops fsi_pcm_ops = {
 
 static int fsi_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
-	return snd_pcm_lib_preallocate_pages_for_all(
+	snd_pcm_lib_preallocate_pages_for_all(
 		rtd->pcm,
 		SNDRV_DMA_TYPE_DEV,
 		rtd->card->snd_card->dev,
 		PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+	return 0;
 }
 
 /*
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f7f9d9e..96d2b39 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1567,7 +1567,6 @@ static int rsnd_preallocate_pages(struct snd_soc_pcm_runtime *rtd,
 	struct rsnd_priv *priv = rsnd_io_to_priv(io);
 	struct device *dev = rsnd_priv_to_dev(priv);
 	struct snd_pcm_substream *substream;
-	int err;
 
 	/*
 	 * use Audio-DMAC dev if we can use IPMMU
@@ -1580,12 +1579,10 @@ static int rsnd_preallocate_pages(struct snd_soc_pcm_runtime *rtd,
 	for (substream = rtd->pcm->streams[stream].substream;
 	     substream;
 	     substream = substream->next) {
-		err = snd_pcm_lib_preallocate_pages(substream,
+		snd_pcm_lib_preallocate_pages(substream,
 					SNDRV_DMA_TYPE_DEV,
 					dev,
 					PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
-		if (err < 0)
-			return err;
 	}
 
 	return 0;
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index 23384c4..78c3145 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -541,15 +541,9 @@ static int siu_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		if (ret < 0)
 			return ret;
 
-		ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
+		snd_pcm_lib_preallocate_pages_for_all(pcm,
 				SNDRV_DMA_TYPE_DEV, card->dev,
 				SIU_BUFFER_BYTES_MAX, SIU_BUFFER_BYTES_MAX);
-		if (ret < 0) {
-			dev_err(card->dev,
-			       "snd_pcm_lib_preallocate_pages_for_all() err=%d",
-				ret);
-			goto fail;
-		}
 
 		(*port_info)->pcm = pcm;
 
@@ -562,11 +556,6 @@ static int siu_pcm_new(struct snd_soc_pcm_runtime *rtd)
 
 	dev_info(card->dev, "SuperH SIU driver initialized.\n");
 	return 0;
-
-fail:
-	siu_free_port(siu_ports[pdev->id]);
-	dev_err(card->dev, "SIU: failed to initialize.\n");
-	return ret;
 }
 
 static void siu_pcm_free(struct snd_pcm *pcm)
-- 
2.7.4
