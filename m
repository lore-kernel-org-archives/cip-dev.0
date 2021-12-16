Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB0DC433F5
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 12:55:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.10135.1639659320030414022
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 04:55:20 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,211,1635174000";
   d="scan'208";a="104171981"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Dec 2021 21:55:19 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4272B40121CF;
	Thu, 16 Dec 2021 21:55:18 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 23/24] clk: renesas: rzg2l: Add support to handle
 coupled clocks
Date: Thu, 16 Dec 2021 12:54:45 +0000
Message-Id: <20211216125446.15451-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 12:55:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7146

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 32897e6fff196a5de4981030466ae391dfe56c7b upstream.

The AXI and CHI clocks use the same register bit for controlling clock
output. Add a new clock type for coupled clocks, which sets the
CPG_CLKON_ETH.CLK[01]_ON bit when at least one clock is enabled, and
clears the bit only when both clocks are disabled.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210922155145.28156-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 71 +++++++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h | 11 ++++-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 597efc2504eb..834a7a73de33 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -333,13 +333,17 @@ rzg2l_cpg_register_core_clk(const struct cpg_core_clk *core,
  * @hw: handle between common and hardware-specific interfaces
  * @off: register offset
  * @bit: ON/MON bit
+ * @enabled: soft state of the clock, if it is coupled with another clock
  * @priv: CPG/MSTP private data
+ * @sibling: pointer to the other coupled clock
  */
 struct mstp_clock {
 	struct clk_hw hw;
 	u16 off;
 	u8 bit;
+	bool enabled;
 	struct rzg2l_cpg_priv *priv;
+	struct mstp_clock *sibling;
 };
 
 #define to_mod_clock(_hw) container_of(_hw, struct mstp_clock, hw)
@@ -392,11 +396,41 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 
 static int rzg2l_mod_clock_enable(struct clk_hw *hw)
 {
+	struct mstp_clock *clock = to_mod_clock(hw);
+
+	if (clock->sibling) {
+		struct rzg2l_cpg_priv *priv = clock->priv;
+		unsigned long flags;
+		bool enabled;
+
+		spin_lock_irqsave(&priv->rmw_lock, flags);
+		enabled = clock->sibling->enabled;
+		clock->enabled = true;
+		spin_unlock_irqrestore(&priv->rmw_lock, flags);
+		if (enabled)
+			return 0;
+	}
+
 	return rzg2l_mod_clock_endisable(hw, true);
 }
 
 static void rzg2l_mod_clock_disable(struct clk_hw *hw)
 {
+	struct mstp_clock *clock = to_mod_clock(hw);
+
+	if (clock->sibling) {
+		struct rzg2l_cpg_priv *priv = clock->priv;
+		unsigned long flags;
+		bool enabled;
+
+		spin_lock_irqsave(&priv->rmw_lock, flags);
+		enabled = clock->sibling->enabled;
+		clock->enabled = false;
+		spin_unlock_irqrestore(&priv->rmw_lock, flags);
+		if (enabled)
+			return;
+	}
+
 	rzg2l_mod_clock_endisable(hw, false);
 }
 
@@ -412,6 +446,9 @@ static int rzg2l_mod_clock_is_enabled(struct clk_hw *hw)
 		return 1;
 	}
 
+	if (clock->sibling)
+		return clock->enabled;
+
 	value = readl(priv->base + CLK_MON_R(clock->off));
 
 	return !(value & bitmask);
@@ -423,6 +460,28 @@ static const struct clk_ops rzg2l_mod_clock_ops = {
 	.is_enabled = rzg2l_mod_clock_is_enabled,
 };
 
+static struct mstp_clock
+*rzg2l_mod_clock__get_sibling(struct mstp_clock *clock,
+			      struct rzg2l_cpg_priv *priv)
+{
+	struct clk_hw *hw;
+	unsigned int i;
+
+	for (i = 0; i < priv->num_mod_clks; i++) {
+		struct mstp_clock *clk;
+
+		if (priv->clks[priv->num_core_clks + i] == ERR_PTR(-ENOENT))
+			continue;
+
+		hw = __clk_get_hw(priv->clks[priv->num_core_clks + i]);
+		clk = to_mod_clock(hw);
+		if (clock->off == clk->off && clock->bit == clk->bit)
+			return clk;
+	}
+
+	return NULL;
+}
+
 static void __init
 rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 			   const struct rzg2l_cpg_info *info,
@@ -484,6 +543,18 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 
 	dev_dbg(dev, "Module clock %pC at %lu Hz\n", clk, clk_get_rate(clk));
 	priv->clks[id] = clk;
+
+	if (mod->is_coupled) {
+		struct mstp_clock *sibling;
+
+		clock->enabled = rzg2l_mod_clock_is_enabled(&clock->hw);
+		sibling = rzg2l_mod_clock__get_sibling(clock, priv);
+		if (sibling) {
+			clock->sibling = sibling;
+			sibling->sibling = clock;
+		}
+	}
+
 	return;
 
 fail:
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index f538ffa3371c..ebf716bb913e 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -90,6 +90,7 @@ enum clk_types {
  * @parent: id of parent clock
  * @off: register offset
  * @bit: ON/MON bit
+ * @is_coupled: flag to indicate coupled clock
  */
 struct rzg2l_mod_clk {
 	const char *name;
@@ -97,17 +98,25 @@ struct rzg2l_mod_clk {
 	unsigned int parent;
 	u16 off;
 	u8 bit;
+	bool is_coupled;
 };
 
-#define DEF_MOD(_name, _id, _parent, _off, _bit)	\
+#define DEF_MOD_BASE(_name, _id, _parent, _off, _bit, _is_coupled)	\
 	{ \
 		.name = _name, \
 		.id = MOD_CLK_BASE + (_id), \
 		.parent = (_parent), \
 		.off = (_off), \
 		.bit = (_bit), \
+		.is_coupled = (_is_coupled), \
 	}
 
+#define DEF_MOD(_name, _id, _parent, _off, _bit)	\
+	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, false)
+
+#define DEF_COUPLED(_name, _id, _parent, _off, _bit)	\
+	DEF_MOD_BASE(_name, _id, _parent, _off, _bit, true)
+
 /**
  * struct rzg2l_reset - Reset definitions
  *
-- 
2.17.1


