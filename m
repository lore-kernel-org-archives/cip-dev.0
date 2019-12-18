From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:17 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 07/39] soc: renesas: rcar-sysc: Prepare
	for fixing power request conflicts
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-8-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 44b5100f7b744b2cd2a29f8766eea5dbf741e0e5 upstream.

Recent R-Car Gen3 SoCs added an External Request Mask Register to the
System Controller (SYSC).  This register allows to mask external power
requests for CPU or 3DG domains, to prevent conflicts between powering
off CPU cores or the 3D Graphics Engine, and changing the state of
another power domain through SYSC, which could lead to CPG state machine
lock-ups.

Add support for making use of this register.  Take into account that the
register is optional, and that its location and contents are
SoC-specific.

Note that the issue fixed by this cannot happen in the upstream kernel,
as upstream has no support for graphics acceleration yet.  SoCs lacking
the External Request Mask Register may need a different mitigation in
the future.

Inspired by a patch in the BSP by Dien Pham <dien.pham.ry@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Link: https://lore.kernel.org/r/20190828113618.6672-2-geert+renesas at glider.be
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/soc/renesas/rcar-sysc.c | 16 ++++++++++++++++
 drivers/soc/renesas/rcar-sysc.h |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 3fc5937..86d5d00 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -66,6 +66,7 @@ struct rcar_sysc_ch {
 
 static void __iomem *rcar_sysc_base;
 static DEFINE_SPINLOCK(rcar_sysc_lock); /* SMP CPUs + I/O devices */
+static u32 rcar_sysc_extmask_offs, rcar_sysc_extmask_val;
 
 static int rcar_sysc_pwr_on_off(const struct rcar_sysc_ch *sysc_ch, bool on)
 {
@@ -109,6 +110,14 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
 	spin_lock_irqsave(&rcar_sysc_lock, flags);
 
 	/*
+	 * Mask external power requests for CPU or 3DG domains
+	 */
+	if (rcar_sysc_extmask_val) {
+		iowrite32(rcar_sysc_extmask_val,
+			  rcar_sysc_base + rcar_sysc_extmask_offs);
+	}
+
+	/*
 	 * The interrupt source needs to be enabled, but masked, to prevent the
 	 * CPU from receiving it.
 	 */
@@ -151,6 +160,9 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
 	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
 
  out:
+	if (rcar_sysc_extmask_val)
+		iowrite32(0, rcar_sysc_base + rcar_sysc_extmask_offs);
+
 	spin_unlock_irqrestore(&rcar_sysc_lock, flags);
 
 	pr_debug("sysc power %s domain %d: %08x -> %d\n", on ? "on" : "off",
@@ -362,6 +374,10 @@ static int __init rcar_sysc_pd_init(void)
 
 	rcar_sysc_base = base;
 
+	/* Optional External Request Mask Register */
+	rcar_sysc_extmask_offs = info->extmask_offs;
+	rcar_sysc_extmask_val = info->extmask_val;
+
 	domains = kzalloc(sizeof(*domains), GFP_KERNEL);
 	if (!domains) {
 		error = -ENOMEM;
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index dc71f49..9b2a869 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -47,6 +47,9 @@ struct rcar_sysc_info {
 	int (*init)(void);	/* Optional */
 	const struct rcar_sysc_area *areas;
 	unsigned int num_areas;
+	/* Optional External Request Mask Register */
+	u32 extmask_offs;	/* SYSCEXTMASK register offset */
+	u32 extmask_val;	/* SYSCEXTMASK register mask value */
 };
 
 extern const struct rcar_sysc_info r8a7743_sysc_info;
-- 
2.7.4
