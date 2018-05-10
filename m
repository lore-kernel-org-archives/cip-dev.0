From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:22 +0100
Subject: [cip-dev] [PATCH  33/62] sgtl5000: add Lineout volume control
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-34-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kalle Kankare <kalle.kankare@vincit.fi>

This controls the volume for the line out pins of SGTL5000.

Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit 0593d4612146dc16ff6bd23423bdd434dd7b8c7b)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 sound/soc/codecs/sgtl5000.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 39a178a..527b759 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -385,6 +385,9 @@ static const DECLARE_TLV_DB_RANGE(mic_gain_tlv,
 /* tlv for hp volume, -51.5db to 12.0db, step .5db */
 static const DECLARE_TLV_DB_SCALE(headphone_volume, -5150, 50, 0);
 
+/* tlv for lineout volume, 31 steps of .5db each */
+static const DECLARE_TLV_DB_SCALE(lineout_volume, -1550, 50, 0);
+
 static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
 	/* SOC_DOUBLE_S8_TLV with invert */
 	{
@@ -413,6 +416,13 @@ static const struct snd_kcontrol_new sgtl5000_snd_controls[] = {
 
 	SOC_SINGLE_TLV("Mic Volume", SGTL5000_CHIP_MIC_CTRL,
 			0, 3, 0, mic_gain_tlv),
+
+	SOC_DOUBLE_TLV("Lineout Playback Volume",
+			SGTL5000_CHIP_LINE_OUT_VOL,
+			SGTL5000_LINE_OUT_VOL_LEFT_SHIFT,
+			SGTL5000_LINE_OUT_VOL_RIGHT_SHIFT,
+			0x1f, 1,
+			lineout_volume),
 };
 
 /* mute the codec used by alsa core */
-- 
2.7.4
