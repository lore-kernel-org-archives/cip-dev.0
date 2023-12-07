Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B062EC10DCE
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 10:55:25 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.80888.1701946513569399649
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 02:55:21 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="189532850"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2023 19:55:20 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F0156420A72E;
	Thu,  7 Dec 2023 19:55:18 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/12] clk: renesas: r9a07g044: Add M1 clock support
Date: Thu,  7 Dec 2023 10:55:00 +0000
Message-Id: <20231207105508.171162-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
References: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 10:55:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13816

commit 60191843db7812dba4fdd2790a2d646721e13b21 upstream.

Add support for M1 clock which is sourced from FOUTPOSTDIV.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220430114156.6260-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 6c7c8f25c284..bf98a95c7c27 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -40,6 +40,8 @@ enum clk_ids {
 	CLK_DIV_PLL3_C,
 	CLK_PLL4,
 	CLK_PLL5,
+	CLK_PLL5_FOUTPOSTDIV,
+	CLK_PLL5_FOUT1PH0,
 	CLK_PLL5_FOUT3,
 	CLK_PLL5_250,
 	CLK_PLL6,
@@ -52,6 +54,7 @@ enum clk_ids {
 	CLK_SD0_DIV4,
 	CLK_SD1_DIV4,
 	CLK_SEL_GPU2,
+	CLK_SEL_PLL5_4,
 
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -77,12 +80,13 @@ static const struct clk_div_table dtable_1_32[] = {
 
 /* Mux clock tables */
 static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
+static const char * const sel_pll5_4[] = { ".pll5_foutpostdiv", ".pll5_fout1ph0" };
 static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
 static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
 static const char * const sel_gpu2[] = { ".pll6", ".pll3_div2_2" };
 
 static const struct {
-	struct cpg_core_clk common[44];
+	struct cpg_core_clk common[48];
 #ifdef CONFIG_CLK_R9A07G054
 	struct cpg_core_clk drp[0];
 #endif
@@ -124,6 +128,9 @@ static const struct {
 		DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_FOUT3, 1, 2),
 		DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
 		DEF_MUX_RO(".sel_gpu2", CLK_SEL_GPU2, SEL_GPU2, sel_gpu2),
+		DEF_PLL5_FOUTPOSTDIV(".pll5_foutpostdiv", CLK_PLL5_FOUTPOSTDIV, CLK_EXTAL),
+		DEF_FIXED(".pll5_fout1ph0", CLK_PLL5_FOUT1PH0, CLK_PLL5_FOUTPOSTDIV, 1, 2),
+		DEF_PLL5_4_MUX(".sel_pll5_4", CLK_SEL_PLL5_4, SEL_PLL5_4, sel_pll5_4),
 
 		/* Core output clk */
 		DEF_DIV("I", R9A07G044_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8),
@@ -143,6 +150,7 @@ static const struct {
 		DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
 		DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
 		DEF_DIV("G", R9A07G044_CLK_G, CLK_SEL_GPU2, DIVGPU, dtable_1_8),
+		DEF_FIXED("M1", R9A07G044_CLK_M1, CLK_PLL5_FOUTPOSTDIV, 1, 1),
 	},
 #ifdef CONFIG_CLK_R9A07G054
 	.drp = {
-- 
2.25.1


