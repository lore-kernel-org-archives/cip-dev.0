From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:05 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 33/57] ASoC: rsnd: tidyup
	rsnd_parse_connect_ssiu_compatible()
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-34-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 331e875432ecfb651d9335a18149160c307429ab upstream.

rsnd_parse_connect_ssiu_compatible() is doing
 - using rsnd_ssiu_id(), but we use it via rsnd_mod_id()
 - we can break loop if rsnd_dai_connect() was called
This patch fixup these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/ssiu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 650b14e..04b1a48 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -382,9 +382,11 @@ static void rsnd_parse_connect_ssiu_compatible(struct rsnd_priv *priv,
 	for_each_rsnd_ssiu(ssiu, priv, i) {
 		mod = rsnd_mod_get(ssiu);
 
-		if ((rsnd_mod_id(ssi_mod) == rsnd_ssiu_id(mod)) &&
-		    (rsnd_mod_id_sub(mod) == 0))
+		if ((rsnd_mod_id(ssi_mod) == rsnd_mod_id(mod)) &&
+		    (rsnd_mod_id_sub(mod) == 0)) {
 			rsnd_dai_connect(mod, io, mod->type);
+			return;
+		}
 	}
 }
 
-- 
2.7.4
