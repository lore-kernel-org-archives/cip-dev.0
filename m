From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:32:03 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 16/57] soc: renesas: rcar-sysc:
	Remove rcar_sysc_power_{down, up}() helpers
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-17-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 319c84090696517f377a80225534677adf192e92 upstream.

Until commit 7e8a50df26f4e700 ("soc: renesas: rcar-sysc: Drop legacy
handling"), the rcar_sysc_power_{down,up}() helpers were public, as they
were called by the legacy (pre-DT) CPU power management code on R-Car H1
and R-Car Gen2 before.

As they are just one-line wrappers around rcar_sysc_power(), it makes
sense to just remove them.

This also avoids a bool/helper/bool conversion in rcar_sysc_power_cpu(),
where a bool is checked to call one of two helper functions, which
just call rcar_sysc_power() with hardcoded boolean values again.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/soc/renesas/rcar-sysc.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index e63d7a2..a71852f 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -149,16 +149,6 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
 	return ret;
 }
 
-static int rcar_sysc_power_down(const struct rcar_sysc_ch *sysc_ch)
-{
-	return rcar_sysc_power(sysc_ch, false);
-}
-
-static int rcar_sysc_power_up(const struct rcar_sysc_ch *sysc_ch)
-{
-	return rcar_sysc_power(sysc_ch, true);
-}
-
 static bool rcar_sysc_power_is_off(const struct rcar_sysc_ch *sysc_ch)
 {
 	unsigned int st;
@@ -187,7 +177,7 @@ static int rcar_sysc_pd_power_off(struct generic_pm_domain *genpd)
 	struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
 
 	pr_debug("%s: %s\n", __func__, genpd->name);
-	return rcar_sysc_power_down(&pd->ch);
+	return rcar_sysc_power(&pd->ch, false);
 }
 
 static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
@@ -195,7 +185,7 @@ static int rcar_sysc_pd_power_on(struct generic_pm_domain *genpd)
 	struct rcar_sysc_pd *pd = to_rcar_pd(genpd);
 
 	pr_debug("%s: %s\n", __func__, genpd->name);
-	return rcar_sysc_power_up(&pd->ch);
+	return rcar_sysc_power(&pd->ch, true);
 }
 
 static bool has_cpg_mstp;
@@ -255,7 +245,7 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
 		goto finalize;
 	}
 
-	rcar_sysc_power_up(&pd->ch);
+	rcar_sysc_power(&pd->ch, true);
 
 finalize:
 	error = pm_genpd_init(genpd, gov, false);
@@ -479,8 +469,7 @@ static int rcar_sysc_power_cpu(unsigned int idx, bool on)
 		if (!(pd->flags & PD_CPU) || pd->ch.chan_bit != idx)
 			continue;
 
-		return on ? rcar_sysc_power_up(&pd->ch)
-			  : rcar_sysc_power_down(&pd->ch);
+		return rcar_sysc_power(&pd->ch, on);
 	}
 
 	return -ENOENT;
-- 
2.7.4
