Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A30AC4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 12:28:46 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.20171.1707222496328553437
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 04:28:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,247,1701097200"; 
   d="scan'208";a="193048785"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Feb 2024 21:28:36 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.78])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4F3DC4005E16;
	Tue,  6 Feb 2024 21:28:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 29/44] clk: renesas: r9a07g043: Add support for RZ/Five SoC
Date: Tue,  6 Feb 2024 12:27:19 +0000
Message-Id: <20240206122734.13477-30-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240206122734.13477-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 12:28:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14813

commit 95d48d270305ad2ce4e6e8d84a9fb6ea49d6f8aa upstream.

Renesas RZ/Five SoC has almost the same clock structure compared to the
Renesas RZ/G2UL SoC, re-use the r9a07g043-cpg.c file to add support for
RZ/Five SoC.

This patch splits up the clocks and reset arrays for RZ/G2UL and RZ/Five
SoC using #ifdef CONFIG_ARM64 and #ifdef CONFIG_RISCV checks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220622181723.13033-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 9d4916aa97cee..1a7a6d60aca44 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -36,9 +36,11 @@ enum clk_ids {
 	CLK_PLL3_DIV2_4_2,
 	CLK_SEL_PLL3_3,
 	CLK_DIV_PLL3_C,
+#ifdef CONFIG_ARM64
 	CLK_PLL5,
 	CLK_PLL5_500,
 	CLK_PLL5_250,
+#endif
 	CLK_PLL6,
 	CLK_PLL6_250,
 	CLK_P1_DIV2,
@@ -100,9 +102,11 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_FIXED(".pll3_533", CLK_PLL3_533, CLK_PLL3, 1, 3),
 	DEF_MUX_RO(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3, sel_pll3_3),
 	DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3, DIVPL3C, dtable_1_32),
+#ifdef CONFIG_ARM64
 	DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
 	DEF_FIXED(".pll5_500", CLK_PLL5_500, CLK_PLL5, 1, 6),
 	DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_500, 1, 2),
+#endif
 	DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
 	DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
 
@@ -126,12 +130,20 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 };
 
 static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
+#ifdef CONFIG_ARM64
 	DEF_MOD("gic",		R9A07G043_GIC600_GICCLK, R9A07G043_CLK_P1,
 				0x514, 0),
 	DEF_MOD("ia55_pclk",	R9A07G043_IA55_PCLK, R9A07G043_CLK_P2,
 				0x518, 0),
 	DEF_MOD("ia55_clk",	R9A07G043_IA55_CLK, R9A07G043_CLK_P1,
 				0x518, 1),
+#endif
+#ifdef CONFIG_RISCV
+	DEF_MOD("iax45_pclk",	R9A07G043_IAX45_PCLK, R9A07G043_CLK_P2,
+				0x518, 0),
+	DEF_MOD("iax45_clk",	R9A07G043_IAX45_CLK, R9A07G043_CLK_P1,
+				0x518, 1),
+#endif
 	DEF_MOD("dmac_aclk",	R9A07G043_DMAC_ACLK, R9A07G043_CLK_P1,
 				0x52c, 0),
 	DEF_MOD("dmac_pclk",	R9A07G043_DMAC_PCLK, CLK_P1_DIV2,
@@ -241,9 +253,14 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 };
 
 static struct rzg2l_reset r9a07g043_resets[] = {
+#ifdef CONFIG_ARM64
 	DEF_RST(R9A07G043_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A07G043_GIC600_DBG_GICRESET_N, 0x814, 1),
 	DEF_RST(R9A07G043_IA55_RESETN, 0x818, 0),
+#endif
+#ifdef CONFIG_RISCV
+	DEF_RST(R9A07G043_IAX45_RESETN, 0x818, 0),
+#endif
 	DEF_RST(R9A07G043_DMAC_ARESETN, 0x82c, 0),
 	DEF_RST(R9A07G043_DMAC_RST_ASYNC, 0x82c, 1),
 	DEF_RST(R9A07G043_OSTM0_PRESETZ, 0x834, 0),
@@ -289,8 +306,13 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 };
 
 static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
+#ifdef CONFIG_ARM64
 	MOD_CLK_BASE + R9A07G043_GIC600_GICCLK,
 	MOD_CLK_BASE + R9A07G043_IA55_CLK,
+#endif
+#ifdef CONFIG_RISCV
+	MOD_CLK_BASE + R9A07G043_IAX45_CLK,
+#endif
 	MOD_CLK_BASE + R9A07G043_DMAC_ACLK,
 };
 
@@ -308,11 +330,21 @@ const struct rzg2l_cpg_info r9a07g043_cpg_info = {
 	/* Module Clocks */
 	.mod_clks = r9a07g043_mod_clks,
 	.num_mod_clks = ARRAY_SIZE(r9a07g043_mod_clks),
+#ifdef CONFIG_ARM64
 	.num_hw_mod_clks = R9A07G043_TSU_PCLK + 1,
+#endif
+#ifdef CONFIG_RISCV
+	.num_hw_mod_clks = R9A07G043_IAX45_PCLK + 1,
+#endif
 
 	/* Resets */
 	.resets = r9a07g043_resets,
+#ifdef CONFIG_ARM64
 	.num_resets = R9A07G043_TSU_PRESETN + 1, /* Last reset ID + 1 */
+#endif
+#ifdef CONFIG_RISCV
+	.num_resets = R9A07G043_IAX45_RESETN + 1, /* Last reset ID + 1 */
+#endif
 
 	.has_clk_mon_regs = true,
 };
-- 
2.34.1


