From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 15:12:02 +0000
Subject: [cip-dev] [PATCH 3/9] clk: renesas: rcar-gen3: Add support for OSC
	EXTAL predivider
In-Reply-To: <1553181128-8171-1-git-send-email-biju.das@bp.renesas.com>
References: <1553181128-8171-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553181128-8171-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a clock type and macro for defining clocks using the OSC EXTAL
predivider combined with a fixed divider.

On most R-Car Gen3 SoCs, the predivider value depends on mode pins, and
thus must be specified in the configuration structure.

Inspired by a patch in the BSP by Takeshi Kihara
<takeshi.kihara.df@renesas.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 38c79e2899a66096583f3377c64b35f30584f1b4)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 7 +++++++
 drivers/clk/renesas/rcar-gen3-cpg.h | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 628b63b..7533a51 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -563,6 +563,13 @@ struct clk * __init rcar_gen3_cpg_clk_register(struct device *dev,
 		return cpg_z_clk_register(core->name, __clk_get_name(parent),
 					  base, CPG_FRQCRC_Z2FC_MASK);
 
+	case CLK_TYPE_GEN3_OSC:
+		/*
+		 * Clock combining OSC EXTAL predivider and a fixed divider
+		 */
+		div = cpg_pll_config->osc_prediv * core->div;
+		break;
+
 	default:
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.h b/drivers/clk/renesas/rcar-gen3-cpg.h
index ea4f8fc..d7d84d9 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.h
+++ b/drivers/clk/renesas/rcar-gen3-cpg.h
@@ -23,6 +23,7 @@ enum rcar_gen3_clk_types {
 	CLK_TYPE_GEN3_PE,
 	CLK_TYPE_GEN3_Z,
 	CLK_TYPE_GEN3_Z2,
+	CLK_TYPE_GEN3_OSC,	/* OSC EXTAL predivider and fixed divider */
 };
 
 #define DEF_GEN3_SD(_name, _id, _parent, _offset)	\
@@ -33,6 +34,8 @@ enum rcar_gen3_clk_types {
 	DEF_BASE(_name, _id, CLK_TYPE_GEN3_PE,			\
 		 (_parent_sscg) << 16 | (_parent_clean),	\
 		 .div = (_div_sscg) << 16 | (_div_clean))
+#define DEF_GEN3_OSC(_name, _id, _parent, _div)		\
+	DEF_BASE(_name, _id, CLK_TYPE_GEN3_OSC, _parent, .div = _div)
 
 struct rcar_gen3_cpg_pll_config {
 	u8 extal_div;
@@ -40,6 +43,7 @@ struct rcar_gen3_cpg_pll_config {
 	u8 pll1_div;
 	u8 pll3_mult;
 	u8 pll3_div;
+	u8 osc_prediv;
 };
 
 #define CPG_RCKCR	0x240
-- 
2.7.4
