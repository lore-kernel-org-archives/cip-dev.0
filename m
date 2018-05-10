From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:20 +0100
Subject: [cip-dev] [PATCH 31/62] ASoC: sgtl5000: Disable internal PLL early
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-32-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Eric Nelson <eric@nelint.com>

To handle the soft reboot case, the internal PLL must be
disabled in SGTL5000_CHIP_CLK_CTRL before clearing bits
SGTL5000_VCOAMP_POWERUP and SGTL5000_PLL_POWERUP in
register SGTL5000_CHIP_ANA_POWER.

Signed-off-by: Eric Nelson <eric@nelint.com>
Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit 08dea16e0960ea5caf7876045b747145cb677096)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 sound/soc/codecs/sgtl5000.c | 9 ++++++++-
 sound/soc/codecs/sgtl5000.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 42f2eb6..0916bb4 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -38,7 +38,6 @@
 /* default value of sgtl5000 registers */
 static const struct reg_default sgtl5000_reg_defaults[] = {
 	{ SGTL5000_CHIP_DIG_POWER,		0x0000 },
-	{ SGTL5000_CHIP_CLK_CTRL,		0x0008 },
 	{ SGTL5000_CHIP_I2S_CTRL,		0x0010 },
 	{ SGTL5000_CHIP_SSS_CTRL,		0x0010 },
 	{ SGTL5000_CHIP_ADCDAC_CTRL,		0x020c },
@@ -1279,6 +1278,14 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	dev_info(&client->dev, "sgtl5000 revision 0x%x\n", rev);
 	sgtl5000->revision = rev;
 
+	/* reconfigure the clocks in case we're using the PLL */
+	ret = regmap_write(sgtl5000->regmap,
+			   SGTL5000_CHIP_CLK_CTRL,
+			   SGTL5000_CHIP_CLK_CTRL_DEFAULT);
+	if (ret)
+		dev_err(&client->dev,
+			"Error %d initializing CHIP_CLK_CTRL\n", ret);
+
 	/* Follow section 2.2.1.1 of AN3663 */
 	ana_pwr = SGTL5000_ANA_POWER_DEFAULT;
 	if (sgtl5000->num_supplies <= VDDD) {
diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index 1be8237..22f3442 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -92,6 +92,7 @@
 /*
  * SGTL5000_CHIP_CLK_CTRL
  */
+#define SGTL5000_CHIP_CLK_CTRL_DEFAULT		0x0008
 #define SGTL5000_RATE_MODE_MASK			0x0030
 #define SGTL5000_RATE_MODE_SHIFT		4
 #define SGTL5000_RATE_MODE_WIDTH		2
-- 
2.7.4
