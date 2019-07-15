From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:53 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 08/23] clk: renesas: rcar-gen3: Add
	spinlock
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit 875e8f6b0156c0ad56fd0c29c78e3f2f67ec0b16 upstream.

Protect the CPG register read-modify-write sequence with a spinlock.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 37be0e8..3bef9f2 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -33,14 +33,19 @@
 
 #define CPG_RCKCR_CKSEL	BIT(15)	/* RCLK Clock Source Select */
 
+static spinlock_t cpg_lock;
+
 static void cpg_reg_modify(void __iomem *reg, u32 clear, u32 set)
 {
+	unsigned long flags;
 	u32 val;
 
+	spin_lock_irqsave(&cpg_lock, flags);
 	val = readl(reg);
 	val &= ~clear;
 	val |= set;
 	writel(val, reg);
+	spin_unlock_irqrestore(&cpg_lock, flags);
 };
 
 struct cpg_simple_notifier {
@@ -618,5 +623,8 @@ int __init rcar_gen3_cpg_init(const struct rcar_gen3_cpg_pll_config *config,
 	if (attr)
 		cpg_quirks = (uintptr_t)attr->data;
 	pr_debug("%s: mode = 0x%x quirks = 0x%x\n", __func__, mode, cpg_quirks);
+
+	spin_lock_init(&cpg_lock);
+
 	return 0;
 }
-- 
2.7.4
