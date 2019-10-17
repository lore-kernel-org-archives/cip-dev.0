From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:05:18 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 46/57] ASoC: rsnd: ssiu: correct shift
	bit for ssiu9
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-47-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jiada Wang <jiada_wang@mentor.com>

commit 76379dfbfd7c8fd7dd29eea3f828cf85c884829e upstream.

Currently "0xf << 36" is used to
clear SSIU-9 internal buffer state, which overflows 32-bit value
according to user reference manual, it is always bit4 ~ bit7
of SSI_SYS_STATUS[1,3,5,7] registers indicate
SSIU-9's buffer state, so "0xf << 4" should be used.

This patch fix incorrect shifting issue in SSIU-9 case

Fixes: commit b7169ddea2f2 ("ASoC: rsnd: remove RSND_REG_ from rsnd_reg")

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/ssiu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index c5934ad..c74991d 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -79,7 +79,7 @@ static int rsnd_ssiu_init(struct rsnd_mod *mod,
 		break;
 	case 9:
 		for (i = 0; i < 4; i++)
-			rsnd_mod_write(mod, SSI_SYS_STATUS((i * 2) + 1), 0xf << (id * 4));
+			rsnd_mod_write(mod, SSI_SYS_STATUS((i * 2) + 1), 0xf << 4);
 		break;
 	}
 
-- 
2.7.4
