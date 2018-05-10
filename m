From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:21 +0100
Subject: [cip-dev] [PATCH 32/62] ASoC: sgtl5000: Do not disable regulators
	in SND_SOC_BIAS_OFF
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-33-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Eric Nelson <eric@nelint.com>

Disabling the SGTL5000 through regulators would certainly save more
power than simply disabling the reference voltages as described in the
data sheet, but won't properly restore things on resume.

This driver does not support active regulators. So we simply disable the
reference bias currents.

Signed-off-by: Eric Nelson <eric@nelint.com>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit 8419caa7270291e26f8b34b12b29680586c85d30)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 sound/soc/codecs/sgtl5000.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 0916bb4..39a178a 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -761,42 +761,17 @@ static int sgtl5000_pcm_hw_params(struct snd_pcm_substream *substream,
 static int sgtl5000_set_bias_level(struct snd_soc_codec *codec,
 				   enum snd_soc_bias_level level)
 {
-	int ret;
-	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 	case SND_SOC_BIAS_PREPARE:
-		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
-			ret = regulator_bulk_enable(
-						sgtl5000->num_supplies,
-						sgtl5000->supplies);
-			if (ret)
-				return ret;
-			udelay(10);
-
-			regcache_cache_only(sgtl5000->regmap, false);
-
-			ret = regcache_sync(sgtl5000->regmap);
-			if (ret != 0) {
-				dev_err(codec->dev,
-					"Failed to restore cache: %d\n", ret);
-
-				regcache_cache_only(sgtl5000->regmap, true);
-				regulator_bulk_disable(sgtl5000->num_supplies,
-						       sgtl5000->supplies);
-
-				return ret;
-			}
-		}
-
+		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
+				    SGTL5000_REFTOP_POWERUP,
+				    SGTL5000_REFTOP_POWERUP);
 		break;
 	case SND_SOC_BIAS_OFF:
-		regcache_cache_only(sgtl5000->regmap, true);
-		regulator_bulk_disable(sgtl5000->num_supplies,
-				       sgtl5000->supplies);
+		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
+				    SGTL5000_REFTOP_POWERUP, 0);
 		break;
 	}
 
-- 
2.7.4
