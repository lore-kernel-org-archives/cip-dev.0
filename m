From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:22 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 50/57] ASoC: rsnd: fixup 6ch settings
	to 8ch
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-51-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 66287def435315d9d8de740da4c543e37630b897 upstream.

rsnd need to use 8ch clock settings for 6ch for TDM.
Otherwise, it can't work correctly.
This patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/core.c | 18 +++++++++++++-----
 sound/soc/sh/rcar/rsnd.h |  1 +
 sound/soc/sh/rcar/ssi.c  |  2 ++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f361118..675691a 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -300,6 +300,18 @@ int rsnd_runtime_channel_after_ctu_with_params(struct rsnd_dai_stream *io,
 	return chan;
 }
 
+int rsnd_channel_normalization(int chan)
+{
+	if ((chan > 8) || (chan < 0))
+		return 0;
+
+	/* TDM Extend Mode needs 8ch */
+	if (chan == 6)
+		chan = 8;
+
+	return chan;
+}
+
 int rsnd_runtime_channel_for_ssi_with_params(struct rsnd_dai_stream *io,
 					     struct snd_pcm_hw_params *params)
 {
@@ -312,11 +324,7 @@ int rsnd_runtime_channel_for_ssi_with_params(struct rsnd_dai_stream *io,
 	if (rsnd_runtime_is_multi_ssi(io))
 		chan /= rsnd_rdai_ssi_lane_get(rdai);
 
-	/* TDM Extend Mode needs 8ch */
-	if (chan == 6)
-		chan = 8;
-
-	return chan;
+	return rsnd_channel_normalization(chan);
 }
 
 int rsnd_runtime_is_multi_ssi(struct rsnd_dai_stream *io)
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 0e6ef4e1..7727add 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -446,6 +446,7 @@ void rsnd_parse_connect_common(struct rsnd_dai *rdai,
 		struct device_node *playback,
 		struct device_node *capture);
 
+int rsnd_channel_normalization(int chan);
 #define rsnd_runtime_channel_original(io) \
 	rsnd_runtime_channel_original_with_params(io, NULL)
 int rsnd_runtime_channel_original_with_params(struct rsnd_dai_stream *io,
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index f5afab6..44bda21 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -303,6 +303,8 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
 	if (rsnd_runtime_is_tdm_split(io))
 		chan = rsnd_io_converted_chan(io);
 
+	chan = rsnd_channel_normalization(chan);
+
 	main_rate = rsnd_ssi_clk_query(rdai, rate, chan, &idx);
 	if (!main_rate) {
 		dev_err(dev, "unsupported clock rate\n");
-- 
2.7.4
