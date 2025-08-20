Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68018CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.15332.1755679615607846173
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:47:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: 11aO4ZOPRPOpkAl/Cve4IA==
X-CSE-MsgGUID: V0Kb+6EvRtG9TsYuXRjqzA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:47:05 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D428E400B524;
	Wed, 20 Aug 2025 17:47:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 05/23] clk: renesas: rzv2h: Skip monitor checks for external clocks
Date: Wed, 20 Aug 2025 09:45:51 +0100
Message-ID: <20250820084645.6988-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:47:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19800

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 899e7ede4c19c6778873ddeca312509fa5778f2c upstream.

For module clocks whose parent mux may select an external source, bypass
the normal monitor (CLK_MON) register check when the external clock is
active. Introduce a new `ext_clk_mux_index` in `struct rzv2h_mod_clk` and
`struct mod_clock`, and detect the current mux index in
`rzv2h_mod_clock_is_enabled()` to disable monitoring if it matches the
external source index.

Provide the `DEF_MOD_MUX_EXTERNAL()` macro for declaring external-source
module clocks, and populate the `ext_clk_mux_index` field in
`rzv2h_cpg_register_mod_clk()`.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250509160121.331073-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 30 ++++++++++++++++++++++++++++--
 drivers/clk/renesas/rzv2h-cpg.h | 17 +++++++++++++----
 2 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 34278c273505d..f143f563fc3cf 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -119,6 +119,7 @@ struct pll_clk {
  * @on_bit: ON/MON bit
  * @mon_index: monitor register offset
  * @mon_bit: monitor bit
+ * @ext_clk_mux_index: mux index for external clock source, or -1 if internal
  */
 struct mod_clock {
 	struct rzv2h_cpg_priv *priv;
@@ -129,6 +130,7 @@ struct mod_clock {
 	u8 on_bit;
 	s8 mon_index;
 	u8 mon_bit;
+	s8 ext_clk_mux_index;
 };
 
 #define to_mod_clock(_hw) container_of(_hw, struct mod_clock, hw)
@@ -563,15 +565,38 @@ static void rzv2h_mod_clock_mstop_disable(struct rzv2h_cpg_priv *priv,
 	spin_unlock_irqrestore(&priv->rmw_lock, flags);
 }
 
+static int rzv2h_parent_clk_mux_to_index(struct clk_hw *hw)
+{
+	struct clk_hw *parent_hw;
+	struct clk *parent_clk;
+	struct clk_mux *mux;
+	u32 val;
+
+	/* This will always succeed, so no need to check for IS_ERR() */
+	parent_clk = clk_get_parent(hw->clk);
+
+	parent_hw = __clk_get_hw(parent_clk);
+	mux = to_clk_mux(parent_hw);
+
+	val = readl(mux->reg) >> mux->shift;
+	val &= mux->mask;
+	return clk_mux_val_to_index(parent_hw, mux->table, 0, val);
+}
+
 static int rzv2h_mod_clock_is_enabled(struct clk_hw *hw)
 {
 	struct mod_clock *clock = to_mod_clock(hw);
 	struct rzv2h_cpg_priv *priv = clock->priv;
+	int mon_index = clock->mon_index;
 	u32 bitmask;
 	u32 offset;
 
-	if (clock->mon_index >= 0) {
-		offset = GET_CLK_MON_OFFSET(clock->mon_index);
+	if (clock->ext_clk_mux_index >= 0 &&
+	    rzv2h_parent_clk_mux_to_index(hw) == clock->ext_clk_mux_index)
+		mon_index = -1;
+
+	if (mon_index >= 0) {
+		offset = GET_CLK_MON_OFFSET(mon_index);
 		bitmask = BIT(clock->mon_bit);
 
 		if (!(readl(priv->base + offset) & bitmask))
@@ -687,6 +712,7 @@ rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk *mod,
 	clock->mon_index = mod->mon_index;
 	clock->mon_bit = mod->mon_bit;
 	clock->no_pm = mod->no_pm;
+	clock->ext_clk_mux_index = mod->ext_clk_mux_index;
 	clock->priv = priv;
 	clock->hw.init = &init;
 	clock->mstop_data = mod->mstop_data;
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cpg.h
index 27d160c742322..540f2f3d8a013 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -199,6 +199,7 @@ enum clk_types {
  * @on_bit: ON bit
  * @mon_index: monitor register index
  * @mon_bit: monitor bit
+ * @ext_clk_mux_index: mux index for external clock source, or -1 if internal
  */
 struct rzv2h_mod_clk {
 	const char *name;
@@ -210,9 +211,11 @@ struct rzv2h_mod_clk {
 	u8 on_bit;
 	s8 mon_index;
 	u8 mon_bit;
+	s8 ext_clk_mux_index;
 };
 
-#define DEF_MOD_BASE(_name, _mstop, _parent, _critical, _no_pm, _onindex, _onbit, _monindex, _monbit) \
+#define DEF_MOD_BASE(_name, _mstop, _parent, _critical, _no_pm, _onindex, \
+		     _onbit, _monindex, _monbit, _ext_clk_mux_index) \
 	{ \
 		.name = (_name), \
 		.mstop_data = (_mstop), \
@@ -223,16 +226,22 @@ struct rzv2h_mod_clk {
 		.on_bit = (_onbit), \
 		.mon_index = (_monindex), \
 		.mon_bit = (_monbit), \
+		.ext_clk_mux_index = (_ext_clk_mux_index), \
 	}
 
 #define DEF_MOD(_name, _parent, _onindex, _onbit, _monindex, _monbit, _mstop) \
-	DEF_MOD_BASE(_name, _mstop, _parent, false, false, _onindex, _onbit, _monindex, _monbit)
+	DEF_MOD_BASE(_name, _mstop, _parent, false, false, _onindex, _onbit, _monindex, _monbit, -1)
 
 #define DEF_MOD_CRITICAL(_name, _parent, _onindex, _onbit, _monindex, _monbit, _mstop) \
-	DEF_MOD_BASE(_name, _mstop, _parent, true, false, _onindex, _onbit, _monindex, _monbit)
+	DEF_MOD_BASE(_name, _mstop, _parent, true, false, _onindex, _onbit, _monindex, _monbit, -1)
 
 #define DEF_MOD_NO_PM(_name, _parent, _onindex, _onbit, _monindex, _monbit, _mstop) \
-	DEF_MOD_BASE(_name, _mstop, _parent, false, true, _onindex, _onbit, _monindex, _monbit)
+	DEF_MOD_BASE(_name, _mstop, _parent, false, true, _onindex, _onbit, _monindex, _monbit, -1)
+
+#define DEF_MOD_MUX_EXTERNAL(_name, _parent, _onindex, _onbit, _monindex, _monbit, _mstop, \
+			     _ext_clk_mux_index) \
+	DEF_MOD_BASE(_name, _mstop, _parent, false, false, _onindex, _onbit, _monindex, _monbit, \
+		     _ext_clk_mux_index)
 
 /**
  * struct rzv2h_reset - Reset definitions
-- 
2.43.0


