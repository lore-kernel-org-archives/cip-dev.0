Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD77C001DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 15:32:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.10790.1689694336488386504
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 08:32:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="173423833"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jul 2023 00:32:24 +0900
Received: from mulinux.home (unknown [10.226.93.62])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 08202400C9F4;
	Wed, 19 Jul 2023 00:32:21 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 3/6] clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries
Date: Tue, 18 Jul 2023 16:32:09 +0100
Message-Id: <20230718153212.327448-4-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
References: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 15:32:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12406

From: Phil Edworthy <phil.edworthy@renesas.com>

Commit d969103ac89de797fda351aa984f69602b149a72 upstream.

Add SDHI/eMMC clock/reset entries to CPG driver.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20221213230129.549968-2-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/clk/renesas/r9a09g011-cpg.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g011-cpg.c b/drivers/clk/renesas/r9a09g011-cpg.c
index 8ee4b5e27bdd..a3506abb990c 100644
--- a/drivers/clk/renesas/r9a09g011-cpg.c
+++ b/drivers/clk/renesas/r9a09g011-cpg.c
@@ -30,6 +30,7 @@
 #define SEL_B		SEL_PLL_PACK(0x214, 0, 1)
 #define SEL_D		SEL_PLL_PACK(0x214, 1, 1)
 #define SEL_E		SEL_PLL_PACK(0x214, 2, 1)
+#define SEL_SDI		SEL_PLL_PACK(0x300, 0, 1)
 #define SEL_W0		SEL_PLL_PACK(0x32C, 0, 1)
 
 enum clk_ids {
@@ -59,6 +60,7 @@ enum clk_ids {
 	CLK_SEL_B_D2,
 	CLK_SEL_D,
 	CLK_SEL_E,
+	CLK_SEL_SDI,
 	CLK_SEL_W0,
 
 	/* Module Clocks */
@@ -92,6 +94,7 @@ static const struct clk_div_table dtable_divd[] = {
 	{0, 0},
 };
 
+
 static const struct clk_div_table dtable_divw[] = {
 	{0, 6},
 	{1, 7},
@@ -108,6 +111,7 @@ static const char * const sel_b[] = { ".main", ".divb" };
 static const char * const sel_d[] = { ".main", ".divd" };
 static const char * const sel_e[] = { ".main", ".dive" };
 static const char * const sel_w[] = { ".main", ".divw" };
+static const char * const sel_sdi[] = { ".main", ".pll2_200" };
 
 static const struct cpg_core_clk r9a09g011_core_clks[] __initconst = {
 	/* External Clock Inputs */
@@ -134,6 +138,7 @@ static const struct cpg_core_clk r9a09g011_core_clks[] __initconst = {
 	DEF_MUX_RO(".selb",	CLK_SEL_B,	SEL_B,		sel_b),
 	DEF_MUX_RO(".seld",	CLK_SEL_D,	SEL_D,		sel_d),
 	DEF_MUX_RO(".sele",	CLK_SEL_E,	SEL_E,		sel_e),
+	DEF_MUX(".selsdi",	CLK_SEL_SDI,	SEL_SDI,	sel_sdi),
 	DEF_MUX(".selw0",	CLK_SEL_W0,	SEL_W0,		sel_w),
 
 	DEF_FIXED(".selb_d2",	CLK_SEL_B_D2,	CLK_SEL_B,	1,	2),
@@ -142,6 +147,18 @@ static const struct cpg_core_clk r9a09g011_core_clks[] __initconst = {
 static const struct rzg2l_mod_clk r9a09g011_mod_clks[] __initconst = {
 	DEF_MOD("pfc",		R9A09G011_PFC_PCLK,	 CLK_MAIN,     0x400, 2),
 	DEF_MOD("gic",		R9A09G011_GIC_CLK,	 CLK_SEL_B_D2, 0x400, 5),
+	DEF_MOD("sdi0_aclk",	R9A09G011_SDI0_ACLK,	 CLK_SEL_D,    0x408, 0),
+	DEF_MOD("sdi0_imclk",	R9A09G011_SDI0_IMCLK,	 CLK_SEL_SDI,  0x408, 1),
+	DEF_MOD("sdi0_imclk2",	R9A09G011_SDI0_IMCLK2,	 CLK_SEL_SDI,  0x408, 2),
+	DEF_MOD("sdi0_clk_hs",	R9A09G011_SDI0_CLK_HS,	 CLK_PLL2_800, 0x408, 3),
+	DEF_MOD("sdi1_aclk",	R9A09G011_SDI1_ACLK,	 CLK_SEL_D,    0x408, 4),
+	DEF_MOD("sdi1_imclk",	R9A09G011_SDI1_IMCLK,	 CLK_SEL_SDI,  0x408, 5),
+	DEF_MOD("sdi1_imclk2",	R9A09G011_SDI1_IMCLK2,	 CLK_SEL_SDI,  0x408, 6),
+	DEF_MOD("sdi1_clk_hs",	R9A09G011_SDI1_CLK_HS,	 CLK_PLL2_800, 0x408, 7),
+	DEF_MOD("emm_aclk",	R9A09G011_EMM_ACLK,	 CLK_SEL_D,    0x408, 8),
+	DEF_MOD("emm_imclk",	R9A09G011_EMM_IMCLK,	 CLK_SEL_SDI,  0x408, 9),
+	DEF_MOD("emm_imclk2",	R9A09G011_EMM_IMCLK2,	 CLK_SEL_SDI,  0x408, 10),
+	DEF_MOD("emm_clk_hs",	R9A09G011_EMM_CLK_HS,	 CLK_PLL2_800, 0x408, 11),
 	DEF_COUPLED("eth_axi",	R9A09G011_ETH0_CLK_AXI,	 CLK_PLL2_200, 0x40c, 8),
 	DEF_COUPLED("eth_chi",	R9A09G011_ETH0_CLK_CHI,	 CLK_PLL2_100, 0x40c, 8),
 	DEF_MOD("eth_clk_gptp",	R9A09G011_ETH0_GPTP_EXT, CLK_PLL2_100, 0x40c, 9),
@@ -178,6 +195,9 @@ static const struct rzg2l_mod_clk r9a09g011_mod_clks[] __initconst = {
 
 static const struct rzg2l_reset r9a09g011_resets[] = {
 	DEF_RST(R9A09G011_PFC_PRESETN,		0x600, 2),
+	DEF_RST_MON(R9A09G011_SDI0_IXRST,	0x608, 0,  6),
+	DEF_RST_MON(R9A09G011_SDI1_IXRST,	0x608, 1,  7),
+	DEF_RST_MON(R9A09G011_EMM_IXRST,	0x608, 2,  8),
 	DEF_RST(R9A09G011_USB_PRESET_N,		0x608, 7),
 	DEF_RST(R9A09G011_USB_DRD_RESET,	0x608, 8),
 	DEF_RST(R9A09G011_USB_ARESETN_P,	0x608, 9),
-- 
2.34.1


