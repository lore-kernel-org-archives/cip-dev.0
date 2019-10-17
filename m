From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:04:52 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 20/57] ASoC: rsnd: enable TDM settings
	for SSI parent
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-21-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 6817d7593f3e3c8a9c11e7a07cb5646c70371f0a upstream.

Some SSIs are sharing each pins (= WS/CLK pin for playback/capture).
Then, SSI parent needs control WS/CLK setting for SSI slave.
In such case, SSI parent needs TDM settings if SSI slave is working as
TDM mode. But it is not cared in current driver.
It can't capture TDM sound without this patch if SSIs were pin sharing.
This patch is tested on R-Car H3 ulcb-kf board, SSI3/4 with TDM sound.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/ssi.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 0803704..04585eb 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -400,6 +400,17 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 		cr_own |= DEL;
 
 	/*
+	 * TDM Mode
+	 * see
+	 *	rsnd_ssiu_init_gen2()
+	 */
+	wsr = ssi->wsr;
+	if (is_tdm) {
+		wsr	|= WS_MODE;
+		cr_own	|= CHNL_8;
+	}
+
+	/*
 	 * We shouldn't exchange SWSP after running.
 	 * This means, parent needs to care it.
 	 */
@@ -429,16 +440,6 @@ static void rsnd_ssi_config_init(struct rsnd_mod *mod,
 		cr_mode = DIEN;		/* PIO : enable Data interrupt */
 	}
 
-	/*
-	 * TDM Extend Mode
-	 * see
-	 *	rsnd_ssiu_init_gen2()
-	 */
-	wsr = ssi->wsr;
-	if (is_tdm) {
-		wsr	|= WS_MODE;
-		cr_own	|= CHNL_8;
-	}
 init_end:
 	ssi->cr_own	= cr_own;
 	ssi->cr_mode	= cr_mode;
-- 
2.7.4
