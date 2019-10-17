From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:16 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 44/57] ASoC: sh: Avoid passing NULL to
	memory allocators
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-45-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takashi Iwai <tiwai@suse.de>

commit 8f74ae398aa0b96207de366e9a723517e440e590 upstream.

We should pass a proper	non-NULL device	object to memory allocators
although it was accepted in the past.  The card->dev points to the
most appropriate device object in such a case, so let's put it.

Acked-by: Christoph Hellwig <hch@lst.de>
Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/siu_pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index e263757..23384c4 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -542,7 +542,7 @@ static int siu_pcm_new(struct snd_soc_pcm_runtime *rtd)
 			return ret;
 
 		ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
-				SNDRV_DMA_TYPE_DEV, NULL,
+				SNDRV_DMA_TYPE_DEV, card->dev,
 				SIU_BUFFER_BYTES_MAX, SIU_BUFFER_BYTES_MAX);
 		if (ret < 0) {
 			dev_err(card->dev,
-- 
2.7.4
