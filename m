From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:24 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 52/57] ASoC: rsnd: fixup mod ID
	calculation in rsnd_ctu_probe_
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-53-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Nilkanth Ahirrao <anilkanth@jp.adit-jv.com>

commit ac28ec07ae1c5c1e18ed6855eb105a328418da88 upstream.

commit c16015f36cc1 ("ASoC: rsnd: add .get_id/.get_id_sub")
introduces rsnd_ctu_id which calcualates and gives
the main Device id of the CTU by dividing the id by 4.
rsnd_mod_id uses this interface to get the CTU main
Device id. But this commit forgets to revert the main
Device id calcution previously done in rsnd_ctu_probe_
which also divides the id by 4. This path corrects the
same to get the correct main Device id.

The issue is observered when rsnd_ctu_probe_ is done for CTU1

Fixes: c16015f36cc1 ("ASoC: rsnd: add .get_id/.get_id_sub")

Signed-off-by: Nilkanth Ahirrao <anilkanth@jp.adit-jv.com>
Signed-off-by: Suresh Udipi <sudipi@jp.adit-jv.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/ctu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 8cb06da..7647b3d 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -108,7 +108,7 @@ static int rsnd_ctu_probe_(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
 			   struct rsnd_priv *priv)
 {
-	return rsnd_cmd_attach(io, rsnd_mod_id(mod) / 4);
+	return rsnd_cmd_attach(io, rsnd_mod_id(mod));
 }
 
 static void rsnd_ctu_value_init(struct rsnd_dai_stream *io,
-- 
2.7.4
