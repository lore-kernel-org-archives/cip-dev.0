Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FB2CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.15474.1755679628275340829
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:47:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: qG2q26kiSvqqNCCOaKZ7wg==
X-CSE-MsgGUID: 2hcWhAEgTDSAffgC4/XDgg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Aug 2025 17:47:16 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 782A240138ED;
	Wed, 20 Aug 2025 17:47:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/23] clk: renesas: rzv2h: Add fixed-factor module clocks with status reporting
Date: Wed, 20 Aug 2025 09:45:56 +0100
Message-ID: <20250820084645.6988-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:47:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19805

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 87239caea4dfbe69b34ddb6dd35fc58f2d395257 upstream.

Add support for fixed-factor module clocks that can report their enable
status through the module status monitor. Introduce a new clock type,
CLK_TYPE_FF_MOD_STATUS, and define the associated structure,
rzv2h_ff_mod_status_clk, to manage these clocks.

Implement the .is_enabled callback by reading the module status register
using monitor index and bit definitions. Provide a helper macro,
DEF_FIXED_MOD_STATUS, to simplify the definition of such clocks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250627204237.214635-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 92 +++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h | 22 ++++++++
 2 files changed, 114 insertions(+)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 54330e6c526b9..25a8189c2a134 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -77,6 +77,7 @@
  * @resets: Array of resets
  * @num_resets: Number of Module Resets in info->resets[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
+ * @ff_mod_status_ops: Fixed Factor Module Status Clock operations
  * @mstop_count: Array of mstop values
  * @rcdev: Reset controller entity
  */
@@ -92,6 +93,8 @@ struct rzv2h_cpg_priv {
 	unsigned int num_resets;
 	unsigned int last_dt_core_clk;
 
+	struct clk_ops *ff_mod_status_ops;
+
 	atomic_t *mstop_count;
 
 	struct reset_controller_dev rcdev;
@@ -149,6 +152,22 @@ struct ddiv_clk {
 
 #define to_ddiv_clock(_div) container_of(_div, struct ddiv_clk, div)
 
+/**
+ * struct rzv2h_ff_mod_status_clk - Fixed Factor Module Status Clock
+ *
+ * @priv: CPG private data
+ * @conf: fixed mod configuration
+ * @fix: fixed factor clock
+ */
+struct rzv2h_ff_mod_status_clk {
+	struct rzv2h_cpg_priv *priv;
+	struct fixed_mod_conf conf;
+	struct clk_fixed_factor fix;
+};
+
+#define to_rzv2h_ff_mod_status_clk(_hw) \
+	container_of(_hw, struct rzv2h_ff_mod_status_clk, fix.hw)
+
 static int rzv2h_cpg_pll_clk_is_enabled(struct clk_hw *hw)
 {
 	struct pll_clk *pll_clk = to_pll(hw);
@@ -418,6 +437,65 @@ rzv2h_cpg_mux_clk_register(const struct cpg_core_clk *core,
 	return clk_hw->clk;
 }
 
+static int
+rzv2h_clk_ff_mod_status_is_enabled(struct clk_hw *hw)
+{
+	struct rzv2h_ff_mod_status_clk *fix = to_rzv2h_ff_mod_status_clk(hw);
+	struct rzv2h_cpg_priv *priv = fix->priv;
+	u32 offset = GET_CLK_MON_OFFSET(fix->conf.mon_index);
+	u32 bitmask = BIT(fix->conf.mon_bit);
+	u32 val;
+
+	val = readl(priv->base + offset);
+	return !!(val & bitmask);
+}
+
+static struct clk * __init
+rzv2h_cpg_fixed_mod_status_clk_register(const struct cpg_core_clk *core,
+					struct rzv2h_cpg_priv *priv)
+{
+	struct rzv2h_ff_mod_status_clk *clk_hw_data;
+	struct clk_init_data init = { };
+	struct clk_fixed_factor *fix;
+	const struct clk *parent;
+	const char *parent_name;
+	int ret;
+
+	WARN_DEBUG(core->parent >= priv->num_core_clks);
+	parent = priv->clks[core->parent];
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	parent_name = __clk_get_name(parent);
+	parent = priv->clks[core->parent];
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	clk_hw_data = devm_kzalloc(priv->dev, sizeof(*clk_hw_data), GFP_KERNEL);
+	if (!clk_hw_data)
+		return ERR_PTR(-ENOMEM);
+
+	clk_hw_data->priv = priv;
+	clk_hw_data->conf = core->cfg.fixed_mod;
+
+	init.name = core->name;
+	init.ops = priv->ff_mod_status_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	fix = &clk_hw_data->fix;
+	fix->hw.init = &init;
+	fix->mult = core->mult;
+	fix->div = core->div;
+
+	ret = devm_clk_hw_register(priv->dev, &clk_hw_data->fix.hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return clk_hw_data->fix.hw.clk;
+}
+
 static struct clk
 *rzv2h_cpg_clk_src_twocell_get(struct of_phandle_args *clkspec,
 			       void *data)
@@ -496,6 +574,20 @@ rzv2h_cpg_register_core_clk(const struct cpg_core_clk *core,
 		else
 			clk = clk_hw->clk;
 		break;
+	case CLK_TYPE_FF_MOD_STATUS:
+		if (!priv->ff_mod_status_ops) {
+			priv->ff_mod_status_ops =
+				devm_kzalloc(dev, sizeof(*priv->ff_mod_status_ops), GFP_KERNEL);
+			if (!priv->ff_mod_status_ops) {
+				clk = ERR_PTR(-ENOMEM);
+				goto fail;
+			}
+			memcpy(priv->ff_mod_status_ops, &clk_fixed_factor_ops,
+			       sizeof(const struct clk_ops));
+			priv->ff_mod_status_ops->is_enabled = rzv2h_clk_ff_mod_status_is_enabled;
+		}
+		clk = rzv2h_cpg_fixed_mod_status_clk_register(core, priv);
+		break;
 	case CLK_TYPE_PLL:
 		clk = rzv2h_cpg_pll_clk_register(core, priv, &rzv2h_cpg_pll_ops);
 		break;
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cpg.h
index bf543e13eb1a2..543e44904bba3 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -94,6 +94,23 @@ struct smuxed {
 		.width = (_width), \
 	})
 
+/**
+ * struct fixed_mod_conf - Structure for fixed module configuration
+ *
+ * @mon_index: monitor index
+ * @mon_bit: monitor bit
+ */
+struct fixed_mod_conf {
+	u8 mon_index;
+	u8 mon_bit;
+};
+
+#define FIXED_MOD_CONF_PACK(_index, _bit) \
+	((struct fixed_mod_conf){ \
+		.mon_index = (_index), \
+		.mon_bit = (_bit), \
+	})
+
 #define CPG_SSEL1		(0x304)
 #define CPG_CDDIV0		(0x400)
 #define CPG_CDDIV1		(0x404)
@@ -145,6 +162,7 @@ struct cpg_core_clk {
 		struct ddiv ddiv;
 		struct pll pll;
 		struct smuxed smux;
+		struct fixed_mod_conf fixed_mod;
 	} cfg;
 	const struct clk_div_table *dtable;
 	const char * const *parent_names;
@@ -157,6 +175,7 @@ enum clk_types {
 	/* Generic */
 	CLK_TYPE_IN,		/* External Clock Input */
 	CLK_TYPE_FF,		/* Fixed Factor Clock */
+	CLK_TYPE_FF_MOD_STATUS,	/* Fixed Factor Clock which can report the status of module clock */
 	CLK_TYPE_PLL,
 	CLK_TYPE_DDIV,		/* Dynamic Switching Divider */
 	CLK_TYPE_SMUX,		/* Static Mux */
@@ -172,6 +191,9 @@ enum clk_types {
 	DEF_TYPE(_name, _id, CLK_TYPE_IN)
 #define DEF_FIXED(_name, _id, _parent, _mult, _div) \
 	DEF_BASE(_name, _id, CLK_TYPE_FF, _parent, .div = _div, .mult = _mult)
+#define DEF_FIXED_MOD_STATUS(_name, _id, _parent, _mult, _div, _gate) \
+	DEF_BASE(_name, _id, CLK_TYPE_FF_MOD_STATUS, _parent, .div = _div, \
+		 .mult = _mult, .cfg.fixed_mod = _gate)
 #define DEF_DDIV(_name, _id, _parent, _ddiv_packed, _dtable) \
 	DEF_TYPE(_name, _id, CLK_TYPE_DDIV, \
 		.cfg.ddiv = _ddiv_packed, \
-- 
2.43.0


