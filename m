From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:04:44 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 12/57] ASoC: rsnd: gen: use tab instead
	of white-space
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-13-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 501683d0cd54714de78501efe945bbe4356b922b upstream.

commit 8c9d75033340 ("ASoC: rsnd: ssiu: Support BUSIF
other than BUSIF0") added new SSIU registers.
But it is using white-space for it.
This patch fixup it to use tab.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/gen.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 3032869..1f7881cc 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -222,30 +222,30 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(SSI_BUSIF0_MODE,		0x0,	0x80),
 		RSND_GEN_M_REG(SSI_BUSIF0_ADINR,	0x4,	0x80),
 		RSND_GEN_M_REG(SSI_BUSIF0_DALIGN,	0x8,	0x80),
-		RSND_GEN_M_REG(SSI_BUSIF1_MODE,         0x20,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF1_ADINR,        0x24,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF1_DALIGN,       0x28,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF2_MODE,         0x40,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF2_ADINR,        0x44,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF2_DALIGN,       0x48,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF3_MODE,         0x60,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF3_ADINR,        0x64,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF3_DALIGN,       0x68,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF4_MODE,         0x500,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF4_ADINR,        0x504,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF4_DALIGN,       0x508,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF5_MODE,         0x520,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF5_ADINR,        0x524,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF5_DALIGN,       0x528,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF6_MODE,         0x540,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF6_ADINR,        0x544,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF6_DALIGN,       0x548,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF7_MODE,         0x560,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF7_ADINR,        0x564,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF7_DALIGN,       0x568,  0x80),
-		RSND_GEN_M_REG(SSI_MODE,	0xc,	0x80),
-		RSND_GEN_M_REG(SSI_CTRL,	0x10,	0x80),
-		RSND_GEN_M_REG(SSI_INT_ENABLE,	0x18,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF1_MODE,		0x20,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF1_ADINR,	0x24,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF1_DALIGN,	0x28,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF2_MODE,		0x40,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF2_ADINR,	0x44,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF2_DALIGN,	0x48,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF3_MODE,		0x60,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF3_ADINR,	0x64,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF3_DALIGN,	0x68,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF4_MODE,		0x500,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF4_ADINR,	0x504,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF4_DALIGN,	0x508,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF5_MODE,		0x520,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF5_ADINR,	0x524,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF5_DALIGN,	0x528,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF6_MODE,		0x540,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF6_ADINR,	0x544,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF6_DALIGN,	0x548,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF7_MODE,		0x560,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF7_ADINR,	0x564,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF7_DALIGN,	0x568,	0x80),
+		RSND_GEN_M_REG(SSI_MODE,		0xc,	0x80),
+		RSND_GEN_M_REG(SSI_CTRL,		0x10,	0x80),
+		RSND_GEN_M_REG(SSI_INT_ENABLE,		0x18,	0x80),
 	};
 
 	static const struct rsnd_regmap_field_conf conf_scu[] = {
-- 
2.7.4
