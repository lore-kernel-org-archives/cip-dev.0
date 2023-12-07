Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F3C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 10:55:25 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.80888.1701946513569399649
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 02:55:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="189532846"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2023 19:55:18 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C40E9420D609;
	Thu,  7 Dec 2023 19:55:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 03/12] clk: renesas: rzg2l: Add DSI divider clk support
Date: Thu,  7 Dec 2023 10:54:59 +0000
Message-Id: <20231207105508.171162-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
References: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 10:55:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13815

commit 46bb3e15e8c7e6c045f619e91b380ff090669b83 upstream.

M3 clock is sourced from DSI Divider (DSIDIVA * DSIDIVB)

This patch add support for DSI divider clk by combining
DSIDIVA and DSIDIVB.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220430114156.6260-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 125 ++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h |  11 +++
 2 files changed, 136 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 6455f52c17b5..5dfe3624f681 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -57,6 +57,8 @@
 #define GET_REG_SAMPLL_CLK1(val)	((val >> 22) & 0xfff)
 #define GET_REG_SAMPLL_CLK2(val)	((val >> 12) & 0xfff)
 
+#define MAX_VCLK_FREQ		(148500000)
+
 struct sd_hw_data {
 	struct clk_hw hw;
 	u32 conf;
@@ -304,6 +306,126 @@ rzg2l_cpg_get_foutpostdiv_rate(struct rzg2l_pll5_param *params,
 	return foutpostdiv_rate;
 }
 
+struct dsi_div_hw_data {
+	struct clk_hw hw;
+	u32 conf;
+	unsigned long rate;
+	struct rzg2l_cpg_priv *priv;
+};
+
+#define to_dsi_div_hw_data(_hw)	container_of(_hw, struct dsi_div_hw_data, hw)
+
+static unsigned long rzg2l_cpg_dsi_div_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
+{
+	struct dsi_div_hw_data *dsi_div = to_dsi_div_hw_data(hw);
+	unsigned long rate = dsi_div->rate;
+
+	if (!rate)
+		rate = parent_rate;
+
+	return rate;
+}
+
+static unsigned long rzg2l_cpg_get_vclk_parent_rate(struct clk_hw *hw,
+						    unsigned long rate)
+{
+	struct dsi_div_hw_data *dsi_div = to_dsi_div_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = dsi_div->priv;
+	struct rzg2l_pll5_param params;
+	unsigned long parent_rate;
+
+	parent_rate = rzg2l_cpg_get_foutpostdiv_rate(&params, rate);
+
+	if (priv->mux_dsi_div_params.clksrc)
+		parent_rate /= 2;
+
+	return parent_rate;
+}
+
+static int rzg2l_cpg_dsi_div_determine_rate(struct clk_hw *hw,
+					    struct clk_rate_request *req)
+{
+	if (req->rate > MAX_VCLK_FREQ)
+		req->rate = MAX_VCLK_FREQ;
+
+	req->best_parent_rate = rzg2l_cpg_get_vclk_parent_rate(hw, req->rate);
+
+	return 0;
+}
+
+static int rzg2l_cpg_dsi_div_set_rate(struct clk_hw *hw,
+				      unsigned long rate,
+				      unsigned long parent_rate)
+{
+	struct dsi_div_hw_data *dsi_div = to_dsi_div_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = dsi_div->priv;
+
+	/*
+	 * MUX -->DIV_DSI_{A,B} -->M3 -->VCLK
+	 *
+	 * Based on the dot clock, the DSI divider clock sets the divider value,
+	 * calculates the pll parameters for generating FOUTPOSTDIV and the clk
+	 * source for the MUX and propagates that info to the parents.
+	 */
+
+	if (!rate || rate > MAX_VCLK_FREQ)
+		return -EINVAL;
+
+	dsi_div->rate = rate;
+	writel(CPG_PL5_SDIV_DIV_DSI_A_WEN | CPG_PL5_SDIV_DIV_DSI_B_WEN |
+	       (priv->mux_dsi_div_params.dsi_div_a << 0) |
+	       (priv->mux_dsi_div_params.dsi_div_b << 8),
+	       priv->base + CPG_PL5_SDIV);
+
+	return 0;
+}
+
+static const struct clk_ops rzg2l_cpg_dsi_div_ops = {
+	.recalc_rate = rzg2l_cpg_dsi_div_recalc_rate,
+	.determine_rate = rzg2l_cpg_dsi_div_determine_rate,
+	.set_rate = rzg2l_cpg_dsi_div_set_rate,
+};
+
+static struct clk * __init
+rzg2l_cpg_dsi_div_clk_register(const struct cpg_core_clk *core,
+			       struct clk **clks,
+			       struct rzg2l_cpg_priv *priv)
+{
+	struct dsi_div_hw_data *clk_hw_data;
+	const struct clk *parent;
+	const char *parent_name;
+	struct clk_init_data init;
+	struct clk_hw *clk_hw;
+	int ret;
+
+	parent = clks[core->parent & 0xffff];
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	clk_hw_data = devm_kzalloc(priv->dev, sizeof(*clk_hw_data), GFP_KERNEL);
+	if (!clk_hw_data)
+		return ERR_PTR(-ENOMEM);
+
+	clk_hw_data->priv = priv;
+
+	parent_name = __clk_get_name(parent);
+	init.name = core->name;
+	init.ops = &rzg2l_cpg_dsi_div_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	clk_hw = &clk_hw_data->hw;
+	clk_hw->init = &init;
+
+	ret = devm_clk_hw_register(priv->dev, clk_hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return clk_hw->clk;
+}
+
 struct pll5_mux_hw_data {
 	struct clk_hw hw;
 	u32 conf;
@@ -733,6 +855,9 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 	case CLK_TYPE_PLL5_4_MUX:
 		clk = rzg2l_cpg_pll5_4_mux_clk_register(core, priv);
 		break;
+	case CLK_TYPE_DSI_DIV:
+		clk = rzg2l_cpg_dsi_div_clk_register(core, priv->clks, priv);
+		break;
 	default:
 		goto fail;
 	}
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 03ab6c9c3ce1..cecbdf5e4f93 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -24,6 +24,7 @@
 #define CPG_PL3_SSEL		(0x408)
 #define CPG_PL6_SSEL		(0x414)
 #define CPG_PL6_ETH_SSEL	(0x418)
+#define CPG_PL5_SDIV		(0x420)
 #define CPG_RST_MON		(0x680)
 #define CPG_OTHERFUNC1_REG	(0xBE8)
 
@@ -39,6 +40,9 @@
 
 #define CPG_OTHERFUNC1_REG_RES0_ON_WEN	BIT(16)
 
+#define CPG_PL5_SDIV_DIV_DSI_A_WEN	BIT(16)
+#define CPG_PL5_SDIV_DIV_DSI_B_WEN	BIT(24)
+
 #define CPG_CLKSTATUS_SELSDHI0_STS	BIT(28)
 #define CPG_CLKSTATUS_SELSDHI1_STS	BIT(29)
 
@@ -54,6 +58,7 @@
 		(((offset) << 20) | ((bitpos) << 12) | ((size) << 8))
 #define DIVPL1A		DDIV_PACK(CPG_PL1_DDIV, 0, 2)
 #define DIVPL2A		DDIV_PACK(CPG_PL2_DDIV, 0, 3)
+#define DIVDSILPCLK	DDIV_PACK(CPG_PL2_DDIV, 12, 2)
 #define DIVPL3A		DDIV_PACK(CPG_PL3A_DDIV, 0, 3)
 #define DIVPL3B		DDIV_PACK(CPG_PL3A_DDIV, 4, 3)
 #define DIVPL3C		DDIV_PACK(CPG_PL3A_DDIV, 8, 3)
@@ -115,6 +120,10 @@ enum clk_types {
 
 	/* Clock for PLL5_4 clock source selector */
 	CLK_TYPE_PLL5_4_MUX,
+
+	/* Clock for DSI divider */
+	CLK_TYPE_DSI_DIV,
+
 };
 
 #define DEF_TYPE(_name, _id, _type...) \
@@ -155,6 +164,8 @@ enum clk_types {
 	DEF_TYPE(_name, _id, CLK_TYPE_PLL5_4_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, \
 		 .num_parents = ARRAY_SIZE(_parent_names))
+#define DEF_DSI_DIV(_name, _id, _parent, _flag) \
+	DEF_TYPE(_name, _id, CLK_TYPE_DSI_DIV, .parent = _parent, .flag = _flag)
 
 /**
  * struct rzg2l_mod_clk - Module Clocks definitions
-- 
2.25.1


