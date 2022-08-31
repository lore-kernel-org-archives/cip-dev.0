Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D814ECAAD3
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:47:07 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.1223.1661964417858439900
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:47:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="133251656"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2022 01:47:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 46C3640457D1;
	Thu,  1 Sep 2022 01:47:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/26] clk: renesas: r9a07g043: Add ethernet clock
 sources
Date: Wed, 31 Aug 2022 17:46:24 +0100
Message-Id: <20220831164645.2134258-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:47:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9365

commit f201eb84450f98decb1834e73409bb2271441dd7 upstream.

Ethernet reference clock can be sourced from PLL5_500 or PLL6. Add
support for ethernet source clock selection using SEL_PLL_6_2 mux.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220402074626.25624-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 0c574e153d4d..b9011bc7fe49 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -32,7 +32,10 @@ enum clk_ids {
 	CLK_PLL3_DIV2_4,
 	CLK_PLL3_DIV2_4_2,
 	CLK_PLL5,
+	CLK_PLL5_500,
+	CLK_PLL5_250,
 	CLK_PLL6,
+	CLK_PLL6_250,
 	CLK_P1_DIV2,
 
 	/* Module Clocks */
@@ -57,6 +60,9 @@ static const struct clk_div_table dtable_1_32[] = {
 	{0, 0},
 };
 
+/* Mux clock tables */
+static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
+
 static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	/* External Clock Inputs */
 	DEF_INPUT("extal", CLK_EXTAL),
@@ -73,7 +79,10 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
 	DEF_FIXED(".pll3_div2_4_2", CLK_PLL3_DIV2_4_2, CLK_PLL3_DIV2_4, 1, 2),
 	DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
+	DEF_FIXED(".pll5_500", CLK_PLL5_500, CLK_PLL5, 1, 6),
+	DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_500, 1, 2),
 	DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
+	DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
 
 	/* Core output clk */
 	DEF_DIV("I", R9A07G043_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8,
@@ -85,6 +94,10 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_FIXED("P1_DIV2", CLK_P1_DIV2, R9A07G043_CLK_P1, 1, 2),
 	DEF_DIV("P2", R9A07G043_CLK_P2, CLK_PLL3_DIV2_4_2,
 		DIVPL3A, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+	DEF_FIXED("M0", R9A07G043_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
+	DEF_FIXED("ZT", R9A07G043_CLK_ZT, CLK_PLL3_DIV2_4_2, 1, 1),
+	DEF_MUX("HP", R9A07G043_CLK_HP, SEL_PLL6_2,
+		sel_pll6_2, ARRAY_SIZE(sel_pll6_2), 0, CLK_MUX_HIWORD_MASK),
 };
 
 static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
-- 
2.25.1


