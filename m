From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:02:49 +0100
Subject: [cip-dev] [PATCH 4.19.y 18/60] soc: renesas: rcar-sysc: Fix power
	domain control after system resume
In-Reply-To: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566990211-24785-19-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 7fc4650cc2417d7a2907a000f6f88240baa42018 upstream.

To control power to a power domain, the System Controller (SYSC) needs
the corresponding interrupt source to be enabled, but masked, to prevent
the CPU from receiving it.

Currently this is handled in the driver's probe() routine, and set up
for every domain present, even if it will not be controlled directly by
SYSC (CPU domains are powered through the APMU on R-Car Gen2 and later).

On R-Car Gen3, PSCI powers down the SoC during system suspend, thus
losing any configured interrupt state.  Hence after system resume, power
domains not controlled through the APMU (e.g. A3IR, A3VC, A3VP) fail to
power up.

Fix this by replacing the global interrupt setup in the probe() routine
by a domain-specific interrupt setup in rcar_sysc_power(), where the
domain's power is actually controlled.  This brings the code more in
line with the flowchart in the Hardware User's Manual.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/soc/renesas/rcar-sysc.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index c3805fc..3fc5937 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -108,6 +108,15 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
 
 	spin_lock_irqsave(&rcar_sysc_lock, flags);
 
+	/*
+	 * The interrupt source needs to be enabled, but masked, to prevent the
+	 * CPU from receiving it.
+	 */
+	iowrite32(ioread32(rcar_sysc_base + SYSCIMR) | isr_mask,
+		  rcar_sysc_base + SYSCIMR);
+	iowrite32(ioread32(rcar_sysc_base + SYSCIER) | isr_mask,
+		  rcar_sysc_base + SYSCIER);
+
 	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
 
 	/* Submit power shutoff or resume request until it was accepted */
@@ -325,7 +334,6 @@ static int __init rcar_sysc_pd_init(void)
 	const struct of_device_id *match;
 	struct rcar_pm_domains *domains;
 	struct device_node *np;
-	u32 syscier, syscimr;
 	void __iomem *base;
 	unsigned int i;
 	int error;
@@ -364,24 +372,6 @@ static int __init rcar_sysc_pd_init(void)
 	domains->onecell_data.num_domains = ARRAY_SIZE(domains->domains);
 	rcar_sysc_onecell_data = &domains->onecell_data;
 
-	for (i = 0, syscier = 0; i < info->num_areas; i++)
-		syscier |= BIT(info->areas[i].isr_bit);
-
-	/*
-	 * Mask all interrupt sources to prevent the CPU from receiving them.
-	 * Make sure not to clear reserved bits that were set before.
-	 */
-	syscimr = ioread32(base + SYSCIMR);
-	syscimr |= syscier;
-	pr_debug("%pOF: syscimr = 0x%08x\n", np, syscimr);
-	iowrite32(syscimr, base + SYSCIMR);
-
-	/*
-	 * SYSC needs all interrupt sources enabled to control power.
-	 */
-	pr_debug("%pOF: syscier = 0x%08x\n", np, syscier);
-	iowrite32(syscier, base + SYSCIER);
-
 	for (i = 0; i < info->num_areas; i++) {
 		const struct rcar_sysc_area *area = &info->areas[i];
 		struct rcar_sysc_pd *pd;
-- 
2.7.4
