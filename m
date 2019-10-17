From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:04:36 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 04/57] ASoC: rsnd: remove is_play
	parameter from hw_rule function
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jiada Wang <jiada_wang@mentor.com>

commit b735662fa473c0e3618a4d645ce797d31e0c9192 upstream.

Currently rsnd_dai_stream *io is set to either &rdai->playback or
&rdai->capture based on whether it is a playback or capture stream,
in __rsnd_soc_hw_rule_* functions, but this is not necessary,
rsnd_dai_stream *io handler can be get from rule->private.

This patch removes 'is_play' parameter from hw_rule function.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
[Kuninori: tidyup for upstream]
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/core.c | 54 +++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 42 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 76f05716..636f6ed 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -813,16 +813,14 @@ static int rsnd_soc_hw_rule(struct rsnd_dai *rdai,
 	return snd_interval_refine(iv, &p);
 }
 
-static int __rsnd_soc_hw_rule_rate(struct snd_pcm_hw_params *params,
-				   struct snd_pcm_hw_rule *rule,
-				   int is_play)
+static int rsnd_soc_hw_rule_rate(struct snd_pcm_hw_params *params,
+				 struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval *ic_ = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct snd_interval *ir = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval ic;
-	struct snd_soc_dai *dai = rule->private;
-	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
-	struct rsnd_dai_stream *io = is_play ? &rdai->playback : &rdai->capture;
+	struct rsnd_dai_stream *io = rule->private;
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 
 	/*
 	 * possible sampling rate limitation is same as
@@ -838,28 +836,14 @@ static int __rsnd_soc_hw_rule_rate(struct snd_pcm_hw_params *params,
 				&ic, ir);
 }
 
-static int rsnd_soc_hw_rule_rate_playback(struct snd_pcm_hw_params *params,
-				 struct snd_pcm_hw_rule *rule)
-{
-	return __rsnd_soc_hw_rule_rate(params, rule, 1);
-}
-
-static int rsnd_soc_hw_rule_rate_capture(struct snd_pcm_hw_params *params,
-					  struct snd_pcm_hw_rule *rule)
-{
-	return __rsnd_soc_hw_rule_rate(params, rule, 0);
-}
-
-static int __rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
-				       struct snd_pcm_hw_rule *rule,
-				       int is_play)
+static int rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
+				     struct snd_pcm_hw_rule *rule)
 {
 	struct snd_interval *ic_ = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct snd_interval *ir = hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval ic;
-	struct snd_soc_dai *dai = rule->private;
-	struct rsnd_dai *rdai = rsnd_dai_to_rdai(dai);
-	struct rsnd_dai_stream *io = is_play ? &rdai->playback : &rdai->capture;
+	struct rsnd_dai_stream *io = rule->private;
+	struct rsnd_dai *rdai = rsnd_io_to_rdai(io);
 
 	/*
 	 * possible sampling rate limitation is same as
@@ -875,18 +859,6 @@ static int __rsnd_soc_hw_rule_channels(struct snd_pcm_hw_params *params,
 				ir, &ic);
 }
 
-static int rsnd_soc_hw_rule_channels_playback(struct snd_pcm_hw_params *params,
-					      struct snd_pcm_hw_rule *rule)
-{
-	return __rsnd_soc_hw_rule_channels(params, rule, 1);
-}
-
-static int rsnd_soc_hw_rule_channels_capture(struct snd_pcm_hw_params *params,
-					     struct snd_pcm_hw_rule *rule)
-{
-	return __rsnd_soc_hw_rule_channels(params, rule, 0);
-}
-
 static const struct snd_pcm_hardware rsnd_pcm_hardware = {
 	.info =		SNDRV_PCM_INFO_INTERLEAVED	|
 			SNDRV_PCM_INFO_MMAP		|
@@ -943,14 +915,12 @@ static int rsnd_soc_dai_startup(struct snd_pcm_substream *substream,
 		int is_play = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 
 		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
-				    is_play ? rsnd_soc_hw_rule_rate_playback :
-					      rsnd_soc_hw_rule_rate_capture,
-				    dai,
+				    rsnd_soc_hw_rule_rate,
+				    is_play ? &rdai->playback : &rdai->capture,
 				    SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 		snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
-				    is_play ? rsnd_soc_hw_rule_channels_playback :
-					      rsnd_soc_hw_rule_channels_capture,
-				    dai,
+				    rsnd_soc_hw_rule_channels,
+				    is_play ? &rdai->playback : &rdai->capture,
 				    SNDRV_PCM_HW_PARAM_RATE, -1);
 	}
 
-- 
2.7.4
