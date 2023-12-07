Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BE1C10DCE
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 10:55:35 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.81315.1701946517933410769
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 02:55:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="185659841"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2023 19:55:27 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 753EC420DBD6;
	Thu,  7 Dec 2023 19:55:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/12] clk: renesas: r9a07g044: Add M4 Clock support
Date: Thu,  7 Dec 2023 10:55:03 +0000
Message-Id: <20231207105508.171162-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
References: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 10:55:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13819

commit 31d5ef2f565d2378d9a615f89e4ff86d3d87eb80 upstream.

Add support for M4 clock which is sourced from pll2_533_div2.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220430114156.6260-8-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index a3a4f560d5f8..39ac1abbcea4 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -57,6 +57,9 @@ enum clk_ids {
 	CLK_SEL_GPU2,
 	CLK_SEL_PLL5_4,
 	CLK_DSI_DIV,
+	CLK_PLL2_533,
+	CLK_PLL2_533_DIV2,
+	CLK_DIV_DSI_LPCLK,
 
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -80,6 +83,14 @@ static const struct clk_div_table dtable_1_32[] = {
 	{0, 0},
 };
 
+static const struct clk_div_table dtable_16_128[] = {
+	{0, 16},
+	{1, 32},
+	{2, 64},
+	{3, 128},
+	{0, 0},
+};
+
 /* Mux clock tables */
 static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
 static const char * const sel_pll5_4[] = { ".pll5_foutpostdiv", ".pll5_fout1ph0" };
@@ -88,7 +99,7 @@ static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
 static const char * const sel_gpu2[] = { ".pll6", ".pll3_div2_2" };
 
 static const struct {
-	struct cpg_core_clk common[52];
+	struct cpg_core_clk common[56];
 #ifdef CONFIG_CLK_R9A07G054
 	struct cpg_core_clk drp[0];
 #endif
@@ -102,6 +113,7 @@ static const struct {
 		DEF_FIXED(".osc_div1000", CLK_OSC_DIV1000, CLK_EXTAL, 1, 1000),
 		DEF_SAMPLL(".pll1", CLK_PLL1, CLK_EXTAL, PLL146_CONF(0)),
 		DEF_FIXED(".pll2", CLK_PLL2, CLK_EXTAL, 200, 3),
+		DEF_FIXED(".pll2_533", CLK_PLL2_533, CLK_PLL2, 1, 3),
 		DEF_FIXED(".pll3", CLK_PLL3, CLK_EXTAL, 200, 3),
 		DEF_FIXED(".pll3_400", CLK_PLL3_400, CLK_PLL3, 1, 4),
 		DEF_FIXED(".pll3_533", CLK_PLL3_533, CLK_PLL3, 1, 3),
@@ -120,6 +132,8 @@ static const struct {
 		DEF_FIXED(".pll2_div2_8", CLK_PLL2_DIV2_8, CLK_PLL2_DIV2, 1, 8),
 		DEF_FIXED(".pll2_div2_10", CLK_PLL2_DIV2_10, CLK_PLL2_DIV2, 1, 10),
 
+		DEF_FIXED(".pll2_533_div2", CLK_PLL2_533_DIV2, CLK_PLL2_533, 1, 2),
+
 		DEF_FIXED(".pll3_div2", CLK_PLL3_DIV2, CLK_PLL3, 1, 2),
 		DEF_FIXED(".pll3_div2_2", CLK_PLL3_DIV2_2, CLK_PLL3_DIV2, 1, 2),
 		DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
@@ -133,6 +147,8 @@ static const struct {
 		DEF_PLL5_FOUTPOSTDIV(".pll5_foutpostdiv", CLK_PLL5_FOUTPOSTDIV, CLK_EXTAL),
 		DEF_FIXED(".pll5_fout1ph0", CLK_PLL5_FOUT1PH0, CLK_PLL5_FOUTPOSTDIV, 1, 2),
 		DEF_PLL5_4_MUX(".sel_pll5_4", CLK_SEL_PLL5_4, SEL_PLL5_4, sel_pll5_4),
+		DEF_DIV(".div_dsi_lpclk", CLK_DIV_DSI_LPCLK, CLK_PLL2_533_DIV2,
+			DIVDSILPCLK, dtable_16_128),
 
 		/* Core output clk */
 		DEF_DIV("I", R9A07G044_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8),
@@ -157,6 +173,7 @@ static const struct {
 		DEF_FIXED("M2_DIV2", CLK_M2_DIV2, R9A07G044_CLK_M2, 1, 2),
 		DEF_DSI_DIV("DSI_DIV", CLK_DSI_DIV, CLK_SEL_PLL5_4, CLK_SET_RATE_PARENT),
 		DEF_FIXED("M3", R9A07G044_CLK_M3, CLK_DSI_DIV, 1, 1),
+		DEF_FIXED("M4", R9A07G044_CLK_M4, CLK_DIV_DSI_LPCLK, 1, 1),
 	},
 #ifdef CONFIG_CLK_R9A07G054
 	.drp = {
-- 
2.25.1


