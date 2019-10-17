From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:04:53 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 21/57] ASoC: rsnd: tidyup SSICR::SWSP
	for TDM
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-22-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 2eaa6e233091f51d8a629e423ad0bc080ffcb5d6 upstream.

R-Car datasheet is indicating that WS output settings of SSICR::SWSP
is inverted on TDM mode from non TDM mode settings.
But, it is meaning that TDM should use 0 here.
Without this patch, sound input/output 1ch will be 2ch, 2ch will be 3ch
..., be jumbled on I2S + TDM settings. This patch fixup it.
This patch is tested on R-Car H3 ulcb-kf board, SSI3/4 TDM sound.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 04585eb..5ff0b44 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -392,7 +392,7 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 
 	if (rdai->bit_clk_inv)
 		cr_own |= SCKP;
-	if (rdai->frm_clk_inv ^ is_tdm)
+	if (rdai->frm_clk_inv && !is_tdm)
 		cr_own |= SWSP;
 	if (rdai->data_alignment)
 		cr_own |= SDTA;
-- 
2.7.4
