From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:26 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 54/57] ASoC: rsnd: add missing pin
	sharing with SSI9
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-55-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 526a6d45b013d45fdddd420860c69fb29fed3d62 upstream.

When SSI9 is sharing pin with SSI0, we need to care about it,
but is missing. This patch fixup it.

Reported-by: Hien Dang <hien.dang.eb@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Chaoliang Qin <chaoliang.qin.jg@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/adg.c | 1 +
 sound/soc/sh/rcar/ssi.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 141d9a0..b9aacf3 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -88,6 +88,7 @@ static u32 rsnd_adg_ssi_ws_timing_gen2(struct rsnd_dai_stream *io)
 		switch (id) {
 		case 1:
 		case 2:
+		case 9:
 			ws = 0;
 			break;
 		case 4:
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 44bda21..f6a7466 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -740,6 +740,7 @@ static void rsnd_ssi_parent_attach(struct rsnd_mod *mod,
 	switch (rsnd_mod_id(mod)) {
 	case 1:
 	case 2:
+	case 9:
 		rsnd_dai_connect(rsnd_ssi_mod_get(priv, 0), io, RSND_MOD_SSIP);
 		break;
 	case 4:
-- 
2.7.4
