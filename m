Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B47C64EB6
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.3568.1648842202850727941
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:43:30 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200";
   d="scan'208";a="115453877"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Apr 2022 04:43:30 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EB2844011436;
	Sat,  2 Apr 2022 04:43:28 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 31/40] clk: renesas: r9a07g044: Add SDHI
 clock and reset entries
Date: Fri,  1 Apr 2022 20:42:25 +0100
Message-Id: <20220401194234.14057-32-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7942

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 373bd6f487562e8727bc842e9983b093d57968cc upstream.

Add SDHI{0,1} mux, clock and reset entries to CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211007111434.8665-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 36 +++++++++++++++++++++++++++++
 drivers/clk/renesas/rzg2l-cpg.h     |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 6c5204981dfb..463b658a0c54 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -44,6 +44,12 @@ enum clk_ids {
 	CLK_PLL6,
 	CLK_PLL6_250,
 	CLK_P1_DIV2,
+	CLK_PLL2_800,
+	CLK_PLL2_SDHI_533,
+	CLK_PLL2_SDHI_400,
+	CLK_PLL2_SDHI_266,
+	CLK_SD0_DIV4,
+	CLK_SD1_DIV4,
 
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -62,6 +68,7 @@ static const struct clk_div_table dtable_1_32[] = {
 /* Mux clock tables */
 static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
 static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
+static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
 
 static const struct cpg_core_clk r9a07g044_core_clks[] __initconst = {
 	/* External Clock Inputs */
@@ -82,6 +89,11 @@ static const struct cpg_core_clk r9a07g044_core_clks[] __initconst = {
 	DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
 
 	DEF_FIXED(".pll2_div2", CLK_PLL2_DIV2, CLK_PLL2, 1, 2),
+	DEF_FIXED(".clk_800", CLK_PLL2_800, CLK_PLL2, 1, 2),
+	DEF_FIXED(".clk_533", CLK_PLL2_SDHI_533, CLK_PLL2, 1, 3),
+	DEF_FIXED(".clk_400", CLK_PLL2_SDHI_400, CLK_PLL2_800, 1, 2),
+	DEF_FIXED(".clk_266", CLK_PLL2_SDHI_266, CLK_PLL2_SDHI_533, 1, 2),
+
 	DEF_FIXED(".pll2_div16", CLK_PLL2_DIV16, CLK_PLL2, 1, 16),
 	DEF_FIXED(".pll2_div20", CLK_PLL2_DIV20, CLK_PLL2, 1, 20),
 
@@ -114,6 +126,12 @@ static const struct cpg_core_clk r9a07g044_core_clks[] __initconst = {
 		sel_pll6_2, ARRAY_SIZE(sel_pll6_2), 0, CLK_MUX_HIWORD_MASK),
 	DEF_FIXED("SPI0", R9A07G044_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 	DEF_FIXED("SPI1", R9A07G044_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
+	DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0,
+		   sel_shdi, ARRAY_SIZE(sel_shdi)),
+	DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1,
+		   sel_shdi, ARRAY_SIZE(sel_shdi)),
+	DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
+	DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
 };
 
 static struct rzg2l_mod_clk r9a07g044_mod_clks[] = {
@@ -131,6 +149,22 @@ static struct rzg2l_mod_clk r9a07g044_mod_clks[] = {
 				0x550, 0),
 	DEF_MOD("spi_clk",	R9A07G044_SPI_CLK, R9A07G044_CLK_SPI0,
 				0x550, 1),
+	DEF_MOD("sdhi0_imclk",	R9A07G044_SDHI0_IMCLK, CLK_SD0_DIV4,
+				0x554, 0),
+	DEF_MOD("sdhi0_imclk2",	R9A07G044_SDHI0_IMCLK2, CLK_SD0_DIV4,
+				0x554, 1),
+	DEF_MOD("sdhi0_clk_hs",	R9A07G044_SDHI0_CLK_HS, R9A07G044_CLK_SD0,
+				0x554, 2),
+	DEF_MOD("sdhi0_aclk",	R9A07G044_SDHI0_ACLK, R9A07G044_CLK_P1,
+				0x554, 3),
+	DEF_MOD("sdhi1_imclk",	R9A07G044_SDHI1_IMCLK, CLK_SD1_DIV4,
+				0x554, 4),
+	DEF_MOD("sdhi1_imclk2",	R9A07G044_SDHI1_IMCLK2, CLK_SD1_DIV4,
+				0x554, 5),
+	DEF_MOD("sdhi1_clk_hs",	R9A07G044_SDHI1_CLK_HS, R9A07G044_CLK_SD1,
+				0x554, 6),
+	DEF_MOD("sdhi1_aclk",	R9A07G044_SDHI1_ACLK, R9A07G044_CLK_P1,
+				0x554, 7),
 	DEF_MOD("ssi0_pclk",	R9A07G044_SSI0_PCLK2, R9A07G044_CLK_P0,
 				0x570, 0),
 	DEF_MOD("ssi0_sfr",	R9A07G044_SSI0_PCLK_SFR, R9A07G044_CLK_P0,
@@ -202,6 +236,8 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_DMAC_ARESETN, 0x82c, 0),
 	DEF_RST(R9A07G044_DMAC_RST_ASYNC, 0x82c, 1),
 	DEF_RST(R9A07G044_SPI_RST, 0x850, 0),
+	DEF_RST(R9A07G044_SDHI0_IXRST, 0x854, 0),
+	DEF_RST(R9A07G044_SDHI1_IXRST, 0x854, 1),
 	DEF_RST(R9A07G044_SSI0_RST_M2_REG, 0x870, 0),
 	DEF_RST(R9A07G044_SSI1_RST_M2_REG, 0x870, 1),
 	DEF_RST(R9A07G044_SSI2_RST_M2_REG, 0x870, 2),
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index da41bd2a7e74..484c7cee2629 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -11,6 +11,7 @@
 
 #define CPG_PL2_DDIV		(0x204)
 #define CPG_PL3A_DDIV		(0x208)
+#define CPG_PL2SDHI_DSEL	(0x218)
 #define CPG_CLKSTATUS		(0x280)
 #define CPG_PL3_SSEL		(0x408)
 #define CPG_PL6_ETH_SSEL	(0x418)
@@ -39,6 +40,9 @@
 #define SEL_PLL3_3	SEL_PLL_PACK(CPG_PL3_SSEL, 8, 1)
 #define SEL_PLL6_2	SEL_PLL_PACK(CPG_PL6_ETH_SSEL, 0, 1)
 
+#define SEL_SDHI0	DDIV_PACK(CPG_PL2SDHI_DSEL, 0, 2)
+#define SEL_SDHI1	DDIV_PACK(CPG_PL2SDHI_DSEL, 4, 2)
+
 /**
  * Definitions of CPG Core Clocks
  *
-- 
2.17.1


