From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:18 +0100
Subject: [cip-dev] [PATCH 29/62] ASoC: sgtl5000: Write all default registers
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-30-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Eric Nelson <eric@nelint.com>

If an error occurs writing defaults, produce an error message but
continue writing other registers. The failure of a single write should
not cause catastrophic device failure.

In at least one occurrence, I2C writes of CHIP_ANA_POWER were nacked,
though continuing allowed the device to operate properly.

Signed-off-by: Eric Nelson <eric@nelint.com>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit f219b16959ee3df2fd49f09493b3f6b28487c416)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 sound/soc/codecs/sgtl5000.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 77bdd1d..56d61a2 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1219,8 +1219,9 @@ static const struct regmap_config sgtl5000_regmap = {
  * and avoid problems like, not being able to probe after an audio playback
  * followed by a system reset or a 'reboot' command in Linux
  */
-static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
+static void sgtl5000_fill_defaults(struct i2c_client *client)
 {
+	struct sgtl5000_priv *sgtl5000 = i2c_get_clientdata(client);
 	int i, ret, val, index;
 
 	for (i = 0; i < ARRAY_SIZE(sgtl5000_reg_defaults); i++) {
@@ -1228,10 +1229,10 @@ static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
 		index = sgtl5000_reg_defaults[i].reg;
 		ret = regmap_write(sgtl5000->regmap, index, val);
 		if (ret)
-			return ret;
+			dev_err(&client->dev,
+				"%s: error %d setting reg 0x%02x to 0x%04x\n",
+				__func__, ret, index, val);
 	}
-
-	return 0;
 }
 
 static int sgtl5000_i2c_probe(struct i2c_client *client,
@@ -1364,9 +1365,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	}
 
 	/* Ensure sgtl5000 will start with sane register values */
-	ret = sgtl5000_fill_defaults(sgtl5000);
-	if (ret)
-		goto disable_clk;
+	sgtl5000_fill_defaults(client);
 
 	ret = snd_soc_register_codec(&client->dev,
 			&sgtl5000_driver, &sgtl5000_dai, 1);
-- 
2.7.4
