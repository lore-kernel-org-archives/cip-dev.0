Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F13C10DC3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 10:55:25 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.81315.1701946517933410769
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 02:55:18 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="185659817"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2023 19:55:16 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 95383420D609;
	Thu,  7 Dec 2023 19:55:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/12] clk: renesas: rzg2l: Add PLL5_4 clk mux support
Date: Thu,  7 Dec 2023 10:54:58 +0000
Message-Id: <20231207105508.171162-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
References: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 10:55:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13814

commit 6cc859cae9aa8c42e8347e2806232bdffeb1b33d upstream.

Add PLL5_4 clk mux support to select clock from clock
sources FOUTPOSTDIV and FOUT1PH0.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220430114156.6260-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 93 +++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h | 11 ++++
 2 files changed, 104 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 023a4254c612..6455f52c17b5 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -304,6 +304,96 @@ rzg2l_cpg_get_foutpostdiv_rate(struct rzg2l_pll5_param *params,
 	return foutpostdiv_rate;
 }
 
+struct pll5_mux_hw_data {
+	struct clk_hw hw;
+	u32 conf;
+	unsigned long rate;
+	struct rzg2l_cpg_priv *priv;
+};
+
+#define to_pll5_mux_hw_data(_hw)	container_of(_hw, struct pll5_mux_hw_data, hw)
+
+static int rzg2l_cpg_pll5_4_clk_mux_determine_rate(struct clk_hw *hw,
+						   struct clk_rate_request *req)
+{
+	struct clk_hw *parent;
+	struct pll5_mux_hw_data *hwdata = to_pll5_mux_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = hwdata->priv;
+
+	parent = clk_hw_get_parent_by_index(hw, priv->mux_dsi_div_params.clksrc);
+	req->best_parent_hw = parent;
+	req->best_parent_rate = req->rate;
+
+	return 0;
+}
+
+static int rzg2l_cpg_pll5_4_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct pll5_mux_hw_data *hwdata = to_pll5_mux_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = hwdata->priv;
+
+	/*
+	 * FOUTPOSTDIV--->|
+	 *  |             | -->MUX -->DIV_DSIA_B -->M3 -->VCLK
+	 *  |--FOUT1PH0-->|
+	 *
+	 * Based on the dot clock, the DSI divider clock calculates the parent
+	 * rate and clk source for the MUX. It propagates that info to
+	 * pll5_4_clk_mux which sets the clock source for DSI divider clock.
+	 */
+
+	writel(CPG_OTHERFUNC1_REG_RES0_ON_WEN | index,
+	       priv->base + CPG_OTHERFUNC1_REG);
+
+	return 0;
+}
+
+static u8 rzg2l_cpg_pll5_4_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct pll5_mux_hw_data *hwdata = to_pll5_mux_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = hwdata->priv;
+
+	return readl(priv->base + GET_REG_OFFSET(hwdata->conf));
+}
+
+static const struct clk_ops rzg2l_cpg_pll5_4_clk_mux_ops = {
+	.determine_rate = rzg2l_cpg_pll5_4_clk_mux_determine_rate,
+	.set_parent	= rzg2l_cpg_pll5_4_clk_mux_set_parent,
+	.get_parent	= rzg2l_cpg_pll5_4_clk_mux_get_parent,
+};
+
+static struct clk * __init
+rzg2l_cpg_pll5_4_mux_clk_register(const struct cpg_core_clk *core,
+				  struct rzg2l_cpg_priv *priv)
+{
+	struct pll5_mux_hw_data *clk_hw_data;
+	struct clk_init_data init;
+	struct clk_hw *clk_hw;
+	int ret;
+
+	clk_hw_data = devm_kzalloc(priv->dev, sizeof(*clk_hw_data), GFP_KERNEL);
+	if (!clk_hw_data)
+		return ERR_PTR(-ENOMEM);
+
+	clk_hw_data->priv = priv;
+	clk_hw_data->conf = core->conf;
+
+	init.name = core->name;
+	init.ops = &rzg2l_cpg_pll5_4_clk_mux_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.num_parents = core->num_parents;
+	init.parent_names = core->parent_names;
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
 struct sipll5 {
 	struct clk_hw hw;
 	u32 conf;
@@ -640,6 +730,9 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 	case CLK_TYPE_SD_MUX:
 		clk = rzg2l_cpg_sd_mux_clk_register(core, priv->base, priv);
 		break;
+	case CLK_TYPE_PLL5_4_MUX:
+		clk = rzg2l_cpg_pll5_4_mux_clk_register(core, priv);
+		break;
 	default:
 		goto fail;
 	}
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 9b8f3249490b..03ab6c9c3ce1 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -25,6 +25,7 @@
 #define CPG_PL6_SSEL		(0x414)
 #define CPG_PL6_ETH_SSEL	(0x418)
 #define CPG_RST_MON		(0x680)
+#define CPG_OTHERFUNC1_REG	(0xBE8)
 
 #define CPG_SIPLL5_STBY_RESETB		BIT(0)
 #define CPG_SIPLL5_STBY_RESETB_WEN	BIT(16)
@@ -36,6 +37,8 @@
 #define CPG_SIPLL5_CLK4_RESV_LSB	(0xFF)
 #define CPG_SIPLL5_MON_PLL5_LOCK	BIT(4)
 
+#define CPG_OTHERFUNC1_REG_RES0_ON_WEN	BIT(16)
+
 #define CPG_CLKSTATUS_SELSDHI0_STS	BIT(28)
 #define CPG_CLKSTATUS_SELSDHI1_STS	BIT(29)
 
@@ -60,6 +63,7 @@
 		(((offset) << 20) | ((bitpos) << 12) | ((size) << 8))
 
 #define SEL_PLL3_3	SEL_PLL_PACK(CPG_PL3_SSEL, 8, 1)
+#define SEL_PLL5_4	SEL_PLL_PACK(CPG_OTHERFUNC1_REG, 0, 1)
 #define SEL_PLL6_2	SEL_PLL_PACK(CPG_PL6_ETH_SSEL, 0, 1)
 #define SEL_GPU2	SEL_PLL_PACK(CPG_PL6_SSEL, 12, 1)
 
@@ -108,6 +112,9 @@ enum clk_types {
 
 	/* Clock for SIPLL5 */
 	CLK_TYPE_SIPLL5,
+
+	/* Clock for PLL5_4 clock source selector */
+	CLK_TYPE_PLL5_4_MUX,
 };
 
 #define DEF_TYPE(_name, _id, _type...) \
@@ -144,6 +151,10 @@ enum clk_types {
 		 .num_parents = ARRAY_SIZE(_parent_names))
 #define DEF_PLL5_FOUTPOSTDIV(_name, _id, _parent) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SIPLL5, .parent = _parent)
+#define DEF_PLL5_4_MUX(_name, _id, _conf, _parent_names) \
+	DEF_TYPE(_name, _id, CLK_TYPE_PLL5_4_MUX, .conf = _conf, \
+		 .parent_names = _parent_names, \
+		 .num_parents = ARRAY_SIZE(_parent_names))
 
 /**
  * struct rzg2l_mod_clk - Module Clocks definitions
-- 
2.25.1


