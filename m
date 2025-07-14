Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB28EC83F28
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74767.1752487694931488184
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:15 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: Popz3L74Svuu34ZXSLTccg==
X-CSE-MsgGUID: 7szhx5pHRYm95xmhn8EwWw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7DFB841D4BDE;
	Mon, 14 Jul 2025 19:08:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 04/57] clk: renesas: rzv2h: Add support for enabling PLLs
Date: Mon, 14 Jul 2025 11:06:45 +0100
Message-ID: <20250714100802.80035-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19432

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit fea942bc15135e065b456421f7a163df036242c5 upstream.

Some RZ/V2H(P) SoC variants do not have a GPU, resulting in PLLGPU being
disabled by default in TF-A. Add support for enabling PLL clocks in the
RZ/V2H(P) CPG driver to manage this.

Introduce `is_enabled` and `enable` callbacks to handle PLL state
transitions. With the `enable` callback, PLLGPU will be turned ON only
when the GPU node is enabled; otherwise, it will remain off. Define new
macros for PLL standby and monitor registers to facilitate this process.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250309211402.80886-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 56 +++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 3eb0f7d5c19a..d08214d1eb0f 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -44,12 +44,18 @@
 #define CPG_BUS_1_MSTOP		(0xd00)
 #define CPG_BUS_MSTOP(m)	(CPG_BUS_1_MSTOP + ((m) - 1) * 4)
 
+#define CPG_PLL_STBY(x)		((x))
+#define CPG_PLL_STBY_RESETB	BIT(0)
+#define CPG_PLL_STBY_RESETB_WEN	BIT(16)
 #define CPG_PLL_CLK1(x)		((x) + 0x004)
 #define KDIV(val)		((s16)FIELD_GET(GENMASK(31, 16), (val)))
 #define MDIV(val)		FIELD_GET(GENMASK(15, 6), (val))
 #define PDIV(val)		FIELD_GET(GENMASK(5, 0), (val))
 #define CPG_PLL_CLK2(x)		((x) + 0x008)
 #define SDIV(val)		FIELD_GET(GENMASK(2, 0), (val))
+#define CPG_PLL_MON(x)		((x) + 0x010)
+#define CPG_PLL_MON_RESETB	BIT(0)
+#define CPG_PLL_MON_LOCK	BIT(4)
 
 #define DDIV_DIVCTL_WEN(shift)		BIT((shift) + 16)
 
@@ -141,6 +147,54 @@ struct ddiv_clk {
 
 #define to_ddiv_clock(_div) container_of(_div, struct ddiv_clk, div)
 
+static int rzv2h_cpg_pll_clk_is_enabled(struct clk_hw *hw)
+{
+	struct pll_clk *pll_clk = to_pll(hw);
+	struct rzv2h_cpg_priv *priv = pll_clk->priv;
+	u32 val = readl(priv->base + CPG_PLL_MON(pll_clk->pll.offset));
+
+	/* Ensure both RESETB and LOCK bits are set */
+	return (val & (CPG_PLL_MON_RESETB | CPG_PLL_MON_LOCK)) ==
+	       (CPG_PLL_MON_RESETB | CPG_PLL_MON_LOCK);
+}
+
+static int rzv2h_cpg_pll_clk_enable(struct clk_hw *hw)
+{
+	struct pll_clk *pll_clk = to_pll(hw);
+	struct rzv2h_cpg_priv *priv = pll_clk->priv;
+	struct pll pll = pll_clk->pll;
+	u32 stby_offset;
+	u32 mon_offset;
+	u32 val;
+	int ret;
+
+	if (rzv2h_cpg_pll_clk_is_enabled(hw))
+		return 0;
+
+	stby_offset = CPG_PLL_STBY(pll.offset);
+	mon_offset = CPG_PLL_MON(pll.offset);
+
+	writel(CPG_PLL_STBY_RESETB_WEN | CPG_PLL_STBY_RESETB,
+	       priv->base + stby_offset);
+
+	/*
+	 * Ensure PLL enters into normal mode
+	 *
+	 * Note: There is no HW information about the worst case latency.
+	 *
+	 * Since this latency might depend on external crystal or PLL rate,
+	 * use a "super" safe timeout value.
+	 */
+	ret = readl_poll_timeout_atomic(priv->base + mon_offset, val,
+			(val & (CPG_PLL_MON_RESETB | CPG_PLL_MON_LOCK)) ==
+			(CPG_PLL_MON_RESETB | CPG_PLL_MON_LOCK), 200, 2000);
+	if (ret)
+		dev_err(priv->dev, "Failed to enable PLL 0x%x/%pC\n",
+			stby_offset, hw->clk);
+
+	return ret;
+}
+
 static unsigned long rzv2h_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 						   unsigned long parent_rate)
 {
@@ -163,6 +217,8 @@ static unsigned long rzv2h_cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 }
 
 static const struct clk_ops rzv2h_cpg_pll_ops = {
+	.is_enabled = rzv2h_cpg_pll_clk_is_enabled,
+	.enable = rzv2h_cpg_pll_clk_enable,
 	.recalc_rate = rzv2h_cpg_pll_clk_recalc_rate,
 };
 
-- 
2.43.0


