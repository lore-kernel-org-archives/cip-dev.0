X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.2184.1648666500371105066
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200"; 
   d="scan'208";a="115208947"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:31 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 502EE40D4D0B;
	Thu, 31 Mar 2022 03:55:29 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 26/39] clk: renesas: rzg2l: Add SDHI clk mux support
Date: Wed, 30 Mar 2022 19:54:41 +0100
Message-Id: <20220330185454.10887-27-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
List-Id: <cip-dev.lists.cip-project.org>

From: Biju Das <biju.das.jz@bp.renesas.com>

commit eaff33646f4cb6a541d01013b0a222f03f6dfac3 upstream.

Add SDHI clk mux support to select SDHI clock from different clock
sources.

As per HW manual, direct clock switching from 533MHz to 400MHz and
vice versa is not recommended. So added support for handling this
in mux.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211007111434.8665-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 118 ++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h |  12 ++++
 2 files changed, 130 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 1501547a11a3..4021f6cabda4 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
@@ -55,6 +56,14 @@
 #define GET_REG_SAMPLL_CLK1(val)	((val >> 22) & 0xfff)
 #define GET_REG_SAMPLL_CLK2(val)	((val >> 12) & 0xfff)
 
+struct sd_hw_data {
+	struct clk_hw hw;
+	u32 conf;
+	struct rzg2l_cpg_priv *priv;
+};
+
+#define to_sd_hw_data(_hw)	container_of(_hw, struct sd_hw_data, hw)
+
 /**
  * struct rzg2l_cpg_priv - Clock Pulse Generator Private Data
  *
@@ -150,6 +159,112 @@ rzg2l_cpg_mux_clk_register(const struct cpg_core_clk *core,
 	return clk_hw->clk;
 }
 
+static int rzg2l_cpg_sd_clk_mux_determine_rate(struct clk_hw *hw,
+					       struct clk_rate_request *req)
+{
+	return clk_mux_determine_rate_flags(hw, req, 0);
+}
+
+static int rzg2l_cpg_sd_clk_mux_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct sd_hw_data *hwdata = to_sd_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = hwdata->priv;
+	u32 off = GET_REG_OFFSET(hwdata->conf);
+	u32 shift = GET_SHIFT(hwdata->conf);
+	const u32 clk_src_266 = 2;
+	u32 bitmask;
+
+	/*
+	 * As per the HW manual, we should not directly switch from 533 MHz to
+	 * 400 MHz and vice versa. To change the setting from 2’b01 (533 MHz)
+	 * to 2’b10 (400 MHz) or vice versa, Switch to 2’b11 (266 MHz) first,
+	 * and then switch to the target setting (2’b01 (533 MHz) or 2’b10
+	 * (400 MHz)).
+	 * Setting a value of '0' to the SEL_SDHI0_SET or SEL_SDHI1_SET clock
+	 * switching register is prohibited.
+	 * The clock mux has 3 input clocks(533 MHz, 400 MHz, and 266 MHz), and
+	 * the index to value mapping is done by adding 1 to the index.
+	 */
+	bitmask = (GENMASK(GET_WIDTH(hwdata->conf) - 1, 0) << shift) << 16;
+	if (index != clk_src_266) {
+		u32 msk, val;
+		int ret;
+
+		writel(bitmask | ((clk_src_266 + 1) << shift), priv->base + off);
+
+		msk = off ? CPG_CLKSTATUS_SELSDHI1_STS : CPG_CLKSTATUS_SELSDHI0_STS;
+
+		ret = readl_poll_timeout(priv->base + CPG_CLKSTATUS, val,
+					 !(val & msk), 100,
+					 CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US);
+		if (ret) {
+			dev_err(priv->dev, "failed to switch clk source\n");
+			return ret;
+		}
+	}
+
+	writel(bitmask | ((index + 1) << shift), priv->base + off);
+
+	return 0;
+}
+
+static u8 rzg2l_cpg_sd_clk_mux_get_parent(struct clk_hw *hw)
+{
+	struct sd_hw_data *hwdata = to_sd_hw_data(hw);
+	struct rzg2l_cpg_priv *priv = hwdata->priv;
+	u32 val = readl(priv->base + GET_REG_OFFSET(hwdata->conf));
+
+	val >>= GET_SHIFT(hwdata->conf);
+	val &= GENMASK(GET_WIDTH(hwdata->conf) - 1, 0);
+	if (val) {
+		val--;
+	} else {
+		/* Prohibited clk source, change it to 533 MHz(reset value) */
+		rzg2l_cpg_sd_clk_mux_set_parent(hw, 0);
+	}
+
+	return val;
+}
+
+static const struct clk_ops rzg2l_cpg_sd_clk_mux_ops = {
+	.determine_rate = rzg2l_cpg_sd_clk_mux_determine_rate,
+	.set_parent	= rzg2l_cpg_sd_clk_mux_set_parent,
+	.get_parent	= rzg2l_cpg_sd_clk_mux_get_parent,
+};
+
+static struct clk * __init
+rzg2l_cpg_sd_mux_clk_register(const struct cpg_core_clk *core,
+			      void __iomem *base,
+			      struct rzg2l_cpg_priv *priv)
+{
+	struct sd_hw_data *clk_hw_data;
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
+	init.name = GET_SHIFT(core->conf) ? "sd1" : "sd0";
+	init.ops = &rzg2l_cpg_sd_clk_mux_ops;
+	init.flags = 0;
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
 struct pll_clk {
 	struct clk_hw hw;
 	unsigned int conf;
@@ -311,6 +426,9 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
 	case CLK_TYPE_MUX:
 		clk = rzg2l_cpg_mux_clk_register(core, priv->base, priv);
 		break;
+	case CLK_TYPE_SD_MUX:
+		clk = rzg2l_cpg_sd_mux_clk_register(core, priv->base, priv);
+		break;
 	default:
 		goto fail;
 	}
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index dc5b65a4029e..952fca98ba71 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -11,9 +11,15 @@
 
 #define CPG_PL2_DDIV		(0x204)
 #define CPG_PL3A_DDIV		(0x208)
+#define CPG_CLKSTATUS		(0x280)
 #define CPG_PL3_SSEL		(0x408)
 #define CPG_PL6_ETH_SSEL	(0x418)
 
+#define CPG_CLKSTATUS_SELSDHI0_STS	BIT(28)
+#define CPG_CLKSTATUS_SELSDHI1_STS	BIT(29)
+
+#define CPG_SDHI_CLK_SWITCH_STATUS_TIMEOUT_US	20000
+
 /* n = 0/1/2 for PLL1/4/6 */
 #define CPG_SAMPLL_CLK1(n)	(0x04 + (16 * n))
 #define CPG_SAMPLL_CLK2(n)	(0x08 + (16 * n))
@@ -67,6 +73,9 @@ enum clk_types {
 
 	/* Clock with clock source selector */
 	CLK_TYPE_MUX,
+
+	/* Clock with SD clock source selector */
+	CLK_TYPE_SD_MUX,
 };
 
 #define DEF_TYPE(_name, _id, _type...) \
@@ -87,6 +96,9 @@ enum clk_types {
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, .num_parents = _num_parents, \
 		 .flag = _flag, .mux_flags = _mux_flags)
+#define DEF_SD_MUX(_name, _id, _conf, _parent_names, _num_parents) \
+	DEF_TYPE(_name, _id, CLK_TYPE_SD_MUX, .conf = _conf, \
+		 .parent_names = _parent_names, .num_parents = _num_parents)
 
 /**
  * struct rzg2l_mod_clk - Module Clocks definitions
-- 
2.17.1


