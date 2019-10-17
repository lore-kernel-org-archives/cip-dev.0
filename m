From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:04:51 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 19/57] ASoC: rsnd: use 32bit TDM width
	as default
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-20-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 82ab7e9a4d3fcec27f745be04063e17da1881dda upstream.

commit fb2815f44a9e ("ASoC: rsnd: add support for 16/24 bit slot widths")
added TDM width check, and return error if it was not 16/24/32 bit.
But it is too strict. This patch uses 32bit same as default.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index fd41da7..4a2a48e 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -738,8 +738,8 @@ static int rsnd_soc_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	case 32:
 		break;
 	default:
-		dev_err(dev, "unsupported slot width value: %d\n", slot_width);
-		return -EINVAL;
+		/* use default */
+		slot_width = 32;
 	}
 
 	switch (slots) {
-- 
2.7.4
