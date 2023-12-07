Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5071C10DCE
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 10:55:15 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.80888.1701946513569399649
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 02:55:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="189532837"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2023 19:55:14 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5D6F3420A72E;
	Thu,  7 Dec 2023 19:55:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/12] clk: renesas: rzg2l: Add FOUTPOSTDIV clk support
Date: Thu,  7 Dec 2023 10:54:57 +0000
Message-Id: <20231207105508.171162-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
References: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 10:55:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13813

commit 1561380ee72f55e3a86856ee046532c18d3e9855 upstream.

PLL5 generates FOUTPOSTDIV clk and is sourced by LCDC/DSI modules.
The FOUTPOSTDIV is connected to PLL5_4 MUX. Video clock is sourced
from DSI divider which is connected to PLL5_4 MUX.

This patch adds support for generating FOUTPOSTDIV clk.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220430114156.6260-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 212 ++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h |  23 ++++
 2 files changed, 235 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 1f9cbee97df1..023a4254c612 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -27,6 +27,7 @@
 #include <linux/pm_domain.h>
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
+#include <linux/units.h>
 
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
 
@@ -64,6 +65,21 @@ struct sd_hw_data {
 
 #define to_sd_hw_data(_hw)	container_of(_hw, struct sd_hw_data, hw)
 
+struct rzg2l_pll5_param {
+	u32 pl5_fracin;
+	u8 pl5_refdiv;
+	u8 pl5_intin;
+	u8 pl5_postdiv1;
+	u8 pl5_postdiv2;
+	u8 pl5_spread;
+};
+
+struct rzg2l_pll5_mux_dsi_div_param {
+	u8 clksrc;
+	u8 dsi_div_a;
+	u8 dsi_div_b;
+};
+
 /**
  * struct rzg2l_cpg_priv - Clock Pulse Generator Private Data
  *
@@ -77,6 +93,7 @@ struct sd_hw_data {
  * @num_resets: Number of Module Resets in info->resets[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
  * @info: Pointer to platform data
+ * @pll5_mux_dsi_div_params: pll5 mux and dsi div parameters
  */
 struct rzg2l_cpg_priv {
 	struct reset_controller_dev rcdev;
@@ -91,6 +108,8 @@ struct rzg2l_cpg_priv {
 	unsigned int last_dt_core_clk;
 
 	const struct rzg2l_cpg_info *info;
+
+	struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
 };
 
 static void rzg2l_cpg_del_clk_provider(void *data)
@@ -264,6 +283,196 @@ rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
 	return clk_hw->clk;
 }
 
+static unsigned long
+rzg2l_cpg_get_foutpostdiv_rate(struct rzg2l_pll5_param *params,
+			       unsigned long rate)
+{
+	unsigned long foutpostdiv_rate;
+
+	params->pl5_intin = rate / MEGA;
+	params->pl5_fracin = div_u64(((u64)rate % MEGA) << 24, MEGA);
+	params->pl5_refdiv = 2;
+	params->pl5_postdiv1 = 1;
+	params->pl5_postdiv2 = 1;
+	params->pl5_spread = 0x16;
+
+	foutpostdiv_rate =
+		EXTAL_FREQ_IN_MEGA_HZ * MEGA / params->pl5_refdiv *
+		((((params->pl5_intin << 24) + params->pl5_fracin)) >> 24) /
+		(params->pl5_postdiv1 * params->pl5_postdiv2);
+
+	return foutpostdiv_rate;
+}
+
+struct sipll5 {
+	struct clk_hw hw;
+	u32 conf;
+	unsigned long foutpostdiv_rate;
+	struct rzg2l_cpg_priv *priv;
+};
+
+#define to_sipll5(_hw)	container_of(_hw, struct sipll5, hw)
+
+static unsigned long rzg2l_cpg_get_vclk_rate(struct clk_hw *hw,
+					     unsigned long rate)
+{
+	struct sipll5 *sipll5 = to_sipll5(hw);
+	struct rzg2l_cpg_priv *priv = sipll5->priv;
+	unsigned long vclk;
+
+	vclk = rate / ((1 << priv->mux_dsi_div_params.dsi_div_a) *
+		       (priv->mux_dsi_div_params.dsi_div_b + 1));
+
+	if (priv->mux_dsi_div_params.clksrc)
+		vclk /= 2;
+
+	return vclk;
+}
+
+static unsigned long rzg2l_cpg_sipll5_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct sipll5 *sipll5 = to_sipll5(hw);
+	unsigned long pll5_rate = sipll5->foutpostdiv_rate;
+
+	if (!pll5_rate)
+		pll5_rate = parent_rate;
+
+	return pll5_rate;
+}
+
+static long rzg2l_cpg_sipll5_round_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long *parent_rate)
+{
+	return rate;
+}
+
+static int rzg2l_cpg_sipll5_set_rate(struct clk_hw *hw,
+				     unsigned long rate,
+				     unsigned long parent_rate)
+{
+	struct sipll5 *sipll5 = to_sipll5(hw);
+	struct rzg2l_cpg_priv *priv = sipll5->priv;
+	struct rzg2l_pll5_param params;
+	unsigned long vclk_rate;
+	int ret;
+	u32 val;
+
+	/*
+	 *  OSC --> PLL5 --> FOUTPOSTDIV-->|
+	 *                   |             | -->MUX -->DIV_DSIA_B -->M3 -->VCLK
+	 *                   |--FOUT1PH0-->|
+	 *
+	 * Based on the dot clock, the DSI divider clock calculates the parent
+	 * rate and the pll5 parameters for generating FOUTPOSTDIV. It propagates
+	 * that info to sipll5 which sets parameters for generating FOUTPOSTDIV.
+	 *
+	 * OSC --> PLL5 --> FOUTPOSTDIV
+	 */
+
+	if (!rate)
+		return -EINVAL;
+
+	vclk_rate = rzg2l_cpg_get_vclk_rate(hw, rate);
+	sipll5->foutpostdiv_rate =
+		rzg2l_cpg_get_foutpostdiv_rate(&params, vclk_rate);
+
+	/* Put PLL5 into standby mode */
+	writel(CPG_SIPLL5_STBY_RESETB_WEN, priv->base + CPG_SIPLL5_STBY);
+	ret = readl_poll_timeout(priv->base + CPG_SIPLL5_MON, val,
+				 !(val & CPG_SIPLL5_MON_PLL5_LOCK), 100, 250000);
+	if (ret) {
+		dev_err(priv->dev, "failed to release pll5 lock");
+		return ret;
+	}
+
+	/* Output clock setting 1 */
+	writel(CPG_SIPLL5_CLK1_POSTDIV1_WEN | CPG_SIPLL5_CLK1_POSTDIV2_WEN |
+	       CPG_SIPLL5_CLK1_REFDIV_WEN  | (params.pl5_postdiv1 << 0) |
+	       (params.pl5_postdiv2 << 4) | (params.pl5_refdiv << 8),
+	       priv->base + CPG_SIPLL5_CLK1);
+
+	/* Output clock setting, SSCG modulation value setting 3 */
+	writel((params.pl5_fracin << 8), priv->base + CPG_SIPLL5_CLK3);
+
+	/* Output clock setting 4 */
+	writel(CPG_SIPLL5_CLK4_RESV_LSB | (params.pl5_intin << 16),
+	       priv->base + CPG_SIPLL5_CLK4);
+
+	/* Output clock setting 5 */
+	writel(params.pl5_spread, priv->base + CPG_SIPLL5_CLK5);
+
+	/* PLL normal mode setting */
+	writel(CPG_SIPLL5_STBY_DOWNSPREAD_WEN | CPG_SIPLL5_STBY_SSCG_EN_WEN |
+	       CPG_SIPLL5_STBY_RESETB_WEN | CPG_SIPLL5_STBY_RESETB,
+	       priv->base + CPG_SIPLL5_STBY);
+
+	/* PLL normal mode transition, output clock stability check */
+	ret = readl_poll_timeout(priv->base + CPG_SIPLL5_MON, val,
+				 (val & CPG_SIPLL5_MON_PLL5_LOCK), 100, 250000);
+	if (ret) {
+		dev_err(priv->dev, "failed to lock pll5");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct clk_ops rzg2l_cpg_sipll5_ops = {
+	.recalc_rate = rzg2l_cpg_sipll5_recalc_rate,
+	.round_rate = rzg2l_cpg_sipll5_round_rate,
+	.set_rate = rzg2l_cpg_sipll5_set_rate,
+};
+
+static struct clk * __init
+rzg2l_cpg_sipll5_register(const struct cpg_core_clk *core,
+			  struct clk **clks,
+			  struct rzg2l_cpg_priv *priv)
+{
+	const struct clk *parent;
+	struct clk_init_data init;
+	const char *parent_name;
+	struct sipll5 *sipll5;
+	struct clk_hw *clk_hw;
+	int ret;
+
+	parent = clks[core->parent & 0xffff];
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	sipll5 = devm_kzalloc(priv->dev, sizeof(*sipll5), GFP_KERNEL);
+	if (!sipll5)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = core->name;
+	parent_name = __clk_get_name(parent);
+	init.ops = &rzg2l_cpg_sipll5_ops;
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	sipll5->hw.init = &init;
+	sipll5->conf = core->conf;
+	sipll5->priv = priv;
+
+	writel(CPG_SIPLL5_STBY_SSCG_EN_WEN | CPG_SIPLL5_STBY_RESETB_WEN |
+	       CPG_SIPLL5_STBY_RESETB, priv->base + CPG_SIPLL5_STBY);
+
+	clk_hw = &sipll5->hw;
+	clk_hw->init = &init;
+
+	ret = devm_clk_hw_register(priv->dev, clk_hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	priv->mux_dsi_div_params.clksrc = 1; /* Use clk src 1 for DSI */
+	priv->mux_dsi_div_params.dsi_div_a = 1; /* Divided by 2 */
+	priv->mux_dsi_div_params.dsi_div_b = 2; /* Divided by 3 */
+
+	return clk_hw->clk;
+}
+
 struct pll_clk {
 	struct clk_hw hw;
 	unsigned int conf;
@@ -418,6 +627,9 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 		clk = rzg2l_cpg_pll_clk_register(core, priv->clks,
 						 priv->base, priv);
 		break;
+	case CLK_TYPE_SIPLL5:
+		clk = rzg2l_cpg_sipll5_register(core, priv->clks, priv);
+		break;
 	case CLK_TYPE_DIV:
 		clk = rzg2l_cpg_div_clk_register(core, priv->clks,
 						 priv->base, priv);
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 4d7f7a102f36..9b8f3249490b 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -9,6 +9,12 @@
 #ifndef __RENESAS_RZG2L_CPG_H__
 #define __RENESAS_RZG2L_CPG_H__
 
+#define CPG_SIPLL5_STBY		(0x140)
+#define CPG_SIPLL5_CLK1		(0x144)
+#define CPG_SIPLL5_CLK3		(0x14C)
+#define CPG_SIPLL5_CLK4		(0x150)
+#define CPG_SIPLL5_CLK5		(0x154)
+#define CPG_SIPLL5_MON		(0x15C)
 #define CPG_PL1_DDIV		(0x200)
 #define CPG_PL2_DDIV		(0x204)
 #define CPG_PL3A_DDIV		(0x208)
@@ -20,6 +26,16 @@
 #define CPG_PL6_ETH_SSEL	(0x418)
 #define CPG_RST_MON		(0x680)
 
+#define CPG_SIPLL5_STBY_RESETB		BIT(0)
+#define CPG_SIPLL5_STBY_RESETB_WEN	BIT(16)
+#define CPG_SIPLL5_STBY_SSCG_EN_WEN	BIT(18)
+#define CPG_SIPLL5_STBY_DOWNSPREAD_WEN	BIT(20)
+#define CPG_SIPLL5_CLK1_POSTDIV1_WEN	BIT(16)
+#define CPG_SIPLL5_CLK1_POSTDIV2_WEN	BIT(20)
+#define CPG_SIPLL5_CLK1_REFDIV_WEN	BIT(24)
+#define CPG_SIPLL5_CLK4_RESV_LSB	(0xFF)
+#define CPG_SIPLL5_MON_PLL5_LOCK	BIT(4)
+
 #define CPG_CLKSTATUS_SELSDHI0_STS	BIT(28)
 #define CPG_CLKSTATUS_SELSDHI1_STS	BIT(29)
 
@@ -50,6 +66,8 @@
 #define SEL_SDHI0	DDIV_PACK(CPG_PL2SDHI_DSEL, 0, 2)
 #define SEL_SDHI1	DDIV_PACK(CPG_PL2SDHI_DSEL, 4, 2)
 
+#define EXTAL_FREQ_IN_MEGA_HZ	(24)
+
 /**
  * Definitions of CPG Core Clocks
  *
@@ -87,6 +105,9 @@ enum clk_types {
 
 	/* Clock with SD clock source selector */
 	CLK_TYPE_SD_MUX,
+
+	/* Clock for SIPLL5 */
+	CLK_TYPE_SIPLL5,
 };
 
 #define DEF_TYPE(_name, _id, _type...) \
@@ -121,6 +142,8 @@ enum clk_types {
 	DEF_TYPE(_name, _id, CLK_TYPE_SD_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, \
 		 .num_parents = ARRAY_SIZE(_parent_names))
+#define DEF_PLL5_FOUTPOSTDIV(_name, _id, _parent) \
+	DEF_TYPE(_name, _id, CLK_TYPE_SIPLL5, .parent = _parent)
 
 /**
  * struct rzg2l_mod_clk - Module Clocks definitions
-- 
2.25.1


