From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:04:59 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 27/57] ASoC: rsnd: use defined
	io_playback/io_capture
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-28-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 9328882e9dc6b3ae6d11eaf6dbdeb45dfbb2d38f upstream.

rdai->playback/rdai->capture are defined as io_playback/io_capture
on __rsnd_dai_probe(). Let's use it instead of original one.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f93644e..dacd7bb 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1085,24 +1085,24 @@ static void __rsnd_dai_probe(struct rsnd_priv *priv,
 	drv->name	= rdai->name;
 	drv->ops	= &rsnd_soc_dai_ops;
 
-	snprintf(rdai->playback.name, RSND_DAI_NAME_SIZE,
+	snprintf(io_playback->name, RSND_DAI_NAME_SIZE,
 		 "DAI%d Playback", dai_i);
 	drv->playback.rates		= RSND_RATES;
 	drv->playback.formats		= RSND_FMTS;
 	drv->playback.channels_min	= 2;
 	drv->playback.channels_max	= 8;
-	drv->playback.stream_name	= rdai->playback.name;
+	drv->playback.stream_name	= io_playback->name;
 
-	snprintf(rdai->capture.name, RSND_DAI_NAME_SIZE,
+	snprintf(io_capture->name, RSND_DAI_NAME_SIZE,
 		 "DAI%d Capture", dai_i);
 	drv->capture.rates		= RSND_RATES;
 	drv->capture.formats		= RSND_FMTS;
 	drv->capture.channels_min	= 2;
 	drv->capture.channels_max	= 8;
-	drv->capture.stream_name	= rdai->capture.name;
+	drv->capture.stream_name	= io_capture->name;
 
-	rdai->playback.rdai		= rdai;
-	rdai->capture.rdai		= rdai;
+	io_playback->rdai		= rdai;
+	io_capture->rdai		= rdai;
 	rsnd_rdai_channels_set(rdai, 2); /* default 2ch */
 	rsnd_rdai_ssi_lane_set(rdai, 1); /* default 1lane */
 	rsnd_rdai_width_set(rdai, 32);   /* default 32bit width */
-- 
2.7.4
