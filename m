From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:16 +0100
Subject: [cip-dev] [PATCH 27/62] ASoC: sgtl5000: Remove misleading comment
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-28-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Clemens Gruber <clemens.gruber@pqgruber.com>

All new designs should use external VDDD according to official
documentation. See ER1 in errata sheet:
http://cache.nxp.com/files/analog/doc/errata/SGTL5000ER.pdf

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit 7e74436410a9a74f41f3be9cc45b504e83544f60)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 sound/soc/codecs/sgtl5000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 08b4046..23766bc 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1113,7 +1113,6 @@ static const u8 vol_quot_table[] = {
  * and should be set according to:
  * 1. vddd provided by external or not
  * 2. vdda and vddio voltage value. > 3.1v or not
- * 3. chip revision >=0x11 or not. If >=0x11, not use external vddd.
  */
 static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 {
-- 
2.7.4
