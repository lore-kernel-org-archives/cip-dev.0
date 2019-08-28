From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:32:04 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 17/57] soc: renesas: rcar-sysc:
	Merge PM Domain registration and linking
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-18-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 1585124d9563da64f481dc0e7c568c344002bc13 upstream.

Commit 977d5ba4507dfe5b ("soc: renesas: rcar-sysc: Make PM domain
initialization more robust") split PM Domain registration and the
linking of children to their parents, to accommodate PM Domain tables
that list child domains before their parents.

However, this failed to realize that parent power domains must be
powered up before their children anyway, and that this thus must be
reflected by the order in the PM Domain tables.

Revert the split, as it did not help anyway.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/soc/renesas/rcar-sysc.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index a71852f..c3805fc 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -382,9 +382,6 @@ static int __init rcar_sysc_pd_init(void)
 	pr_debug("%pOF: syscier = 0x%08x\n", np, syscier);
 	iowrite32(syscier, base + SYSCIER);
 
-	/*
-	 * First, create all PM domains
-	 */
 	for (i = 0; i < info->num_areas; i++) {
 		const struct rcar_sysc_area *area = &info->areas[i];
 		struct rcar_sysc_pd *pd;
@@ -412,22 +409,17 @@ static int __init rcar_sysc_pd_init(void)
 			goto out_put;
 
 		domains->domains[area->isr_bit] = &pd->genpd;
-	}
 
-	/*
-	 * Second, link all PM domains to their parents
-	 */
-	for (i = 0; i < info->num_areas; i++) {
-		const struct rcar_sysc_area *area = &info->areas[i];
-
-		if (!area->name || area->parent < 0)
+		if (area->parent < 0)
 			continue;
 
 		error = pm_genpd_add_subdomain(domains->domains[area->parent],
-					       domains->domains[area->isr_bit]);
-		if (error)
+					       &pd->genpd);
+		if (error) {
 			pr_warn("Failed to add PM subdomain %s to parent %u\n",
 				area->name, area->parent);
+			goto out_put;
+		}
 	}
 
 	error = of_genpd_add_provider_onecell(np, &domains->onecell_data);
-- 
2.7.4
