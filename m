From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 08:04:45 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 13/57] ASoC: rsnd: don't use %p for
	dev_dbg()
In-Reply-To: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295929-47286-14-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit dabdbe3ae0cb9a67872fa4ac80ffdef61391f645 upstream.

rsnd driver sometimes want to know which address is used when debugging.
But it will indicate "(____ptrval____)" if it used "%p" on dev_dbg().
Let's use "%pa" or "%px" for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 sound/soc/sh/rcar/adg.c | 4 ++--
 sound/soc/sh/rcar/dma.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 549a137..e9de281 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -591,7 +591,7 @@ static void rsnd_adg_clk_dbg_info(struct rsnd_priv *priv, struct rsnd_adg *adg)
 	int i;
 
 	for_each_rsnd_clk(clk, adg, i)
-		dev_dbg(dev, "%s    : %p : %ld\n",
+		dev_dbg(dev, "%s    : %pa : %ld\n",
 			clk_name[i], clk, clk_get_rate(clk));
 
 	dev_dbg(dev, "BRGCKR = 0x%08x, BRRA/BRRB = 0x%x/0x%x\n",
@@ -604,7 +604,7 @@ static void rsnd_adg_clk_dbg_info(struct rsnd_priv *priv, struct rsnd_adg *adg)
 	 * by BRGCKR::BRGCKR_31
 	 */
 	for_each_rsnd_clkout(clk, adg, i)
-		dev_dbg(dev, "clkout %d : %p : %ld\n", i,
+		dev_dbg(dev, "clkout %d : %pa : %ld\n", i,
 			clk, clk_get_rate(clk));
 }
 #else
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index b5f3bf8..0bbc4b0 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -397,7 +397,7 @@ static void rsnd_dmapp_write(struct rsnd_dma *dma, u32 data, u32 reg)
 	struct rsnd_dma_ctrl *dmac = rsnd_priv_to_dmac(priv);
 	struct device *dev = rsnd_priv_to_dev(priv);
 
-	dev_dbg(dev, "w %p : %08x\n", rsnd_dmapp_addr(dmac, dma, reg), data);
+	dev_dbg(dev, "w 0x%px : %08x\n", rsnd_dmapp_addr(dmac, dma, reg), data);
 
 	iowrite32(data, rsnd_dmapp_addr(dmac, dma, reg));
 }
-- 
2.7.4
