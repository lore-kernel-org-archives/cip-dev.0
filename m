From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 15:12:05 +0000
Subject: [cip-dev] [PATCH 6/9] clk: renesas: rcar-gen3: Add support for mode
	pin clock selection
In-Reply-To: <1553181128-8171-1-git-send-email-biju.das@bp.renesas.com>
References: <1553181128-8171-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553181128-8171-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Make the existing support for selecting between clean and SSCG clocks
using MD12 more generic, to allow using other mode pins for arbitrary
clock selection.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit cd51e427e050f6a3d3bc3e0e38ad30974a52cb44)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 10 ++++------
 drivers/clk/renesas/rcar-gen3-cpg.h | 13 +++++++++----
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 19a7782..4346fde 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -539,16 +539,14 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 			parent = clks[cpg_clk_extalr];
 		break;
 
-	case CLK_TYPE_GEN3_PE:
+	case CLK_TYPE_GEN3_MDSEL:
 		/*
-		 * Peripheral clock with a fixed divider, selectable between
-		 * clean and spread spectrum parents using MD12
+		 * Clock selectable between two parents and two fixed dividers
+		 * using a mode pin
 		 */
-		if (cpg_mode & BIT(12)) {
-			/* Clean */
+		if (cpg_mode & BIT(core->offset)) {
 			div = core->div & 0xffff;
 		} else {
-			/* SCCG */
 			parent = clks[core->parent >> 16];
 			if (IS_ERR(parent))
 				return ERR_CAST(parent);
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index 7c49aeb..04dc45d 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -20,7 +20,7 @@ enum rcar_gen3_clk_types {
 	CLK_TYPE_GEN3_PLL4,
 	CLK_TYPE_GEN3_SD,
 	CLK_TYPE_GEN3_R,
-	CLK_TYPE_GEN3_PE,
+	CLK_TYPE_GEN3_MDSEL,	/* Select parent/divider using mode pin */
 	CLK_TYPE_GEN3_Z,
 	CLK_TYPE_GEN3_Z2,
 	CLK_TYPE_GEN3_OSC,	/* OSC EXTAL predivider and fixed divider */
@@ -30,11 +30,16 @@ enum rcar_gen3_clk_types {
 #define DEF_GEN3_SD(_name, _id, _parent, _offset)	\
 	DEF_BASE(_name, _id, CLK_TYPE_GEN3_SD, _parent, .offset = _offset)
 
+#define DEF_GEN3_MDSEL(_name, _id, _md, _parent0, _div0, _parent1, _div1) \
+	DEF_BASE(_name, _id, CLK_TYPE_GEN3_MDSEL,	\
+		 (_parent0) << 16 | (_parent1),		\
+		 .div = (_div0) << 16 | (_div1), .offset = _md)
+
 #define DEF_GEN3_PE(_name, _id, _parent_sscg, _div_sscg, _parent_clean, \
 		    _div_clean) \
-	DEF_BASE(_name, _id, CLK_TYPE_GEN3_PE,			\
-		 (_parent_sscg) << 16 | (_parent_clean),	\
-		 .div = (_div_sscg) << 16 | (_div_clean))
+	DEF_GEN3_MDSEL(_name, _id, 12, _parent_sscg, _div_sscg,	\
+		       _parent_clean, _div_clean)
+
 #define DEF_GEN3_OSC(_name, _id, _parent, _div)		\
 	DEF_BASE(_name, _id, CLK_TYPE_GEN3_OSC, _parent, .div = _div)
 
-- 
2.7.4
