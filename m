Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B7DC369AB
	for <webhook@archiver.kernel.org>; Mon, 21 Apr 2025 18:43:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.22323.1745261010984955650
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Apr 2025 11:43:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: f3S6A+28QXWxWedRkWEXbw==
X-CSE-MsgGUID: JAB/W1mAQnGk0Nau56u/DQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Apr 2025 03:43:30 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.26])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EC1AD400D0DA;
	Tue, 22 Apr 2025 03:43:28 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip] clk: renesas: r9a07g044: Add clock and reset entry for DRP-AI
Date: Mon, 21 Apr 2025 19:43:27 +0100
Message-ID: <20250421184327.633182-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Apr 2025 18:43:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18537

commit 989d673ff7c461b2abd472227fdb7df69860d23f upstream.

Add clock and reset entries for the DRP-AI block, which is available only
on the Renesas RZ/V2L SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250106202853.262787-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 55 +++++++++++++++++++++++++++--
 drivers/clk/renesas/rzg2l-cpg.h     |  2 ++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 48404cafea3f..ca518c13f4d6 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -94,6 +94,41 @@ static const struct clk_div_table dtable_1_32[] = {
 	{0, 0},
 };
 
+#ifdef CONFIG_CLK_R9A07G054
+static const struct clk_div_table dtable_4_32[] = {
+	{3, 4},
+	{4, 5},
+	{5, 6},
+	{6, 7},
+	{7, 8},
+	{8, 9},
+	{9, 10},
+	{10, 11},
+	{11, 12},
+	{12, 13},
+	{13, 14},
+	{14, 15},
+	{15, 16},
+	{16, 17},
+	{17, 18},
+	{18, 19},
+	{19, 20},
+	{20, 21},
+	{21, 22},
+	{22, 23},
+	{23, 24},
+	{24, 25},
+	{25, 26},
+	{26, 27},
+	{27, 28},
+	{28, 29},
+	{29, 30},
+	{30, 31},
+	{31, 32},
+	{0, 0},
+};
+#endif
+
 static const struct clk_div_table dtable_16_128[] = {
 	{0, 16},
 	{1, 32},
@@ -114,7 +149,7 @@ static const u32 mtable_sdhi[] = { 1, 2, 3 };
 static const struct {
 	struct cpg_core_clk common[56];
 #ifdef CONFIG_CLK_R9A07G054
-	struct cpg_core_clk drp[0];
+	struct cpg_core_clk drp[3];
 #endif
 } core_clks __initconst = {
 	.common = {
@@ -192,6 +227,9 @@ static const struct {
 	},
 #ifdef CONFIG_CLK_R9A07G054
 	.drp = {
+		DEF_FIXED("DRP_M", R9A07G054_CLK_DRP_M, CLK_PLL3, 1, 5),
+		DEF_FIXED("DRP_D", R9A07G054_CLK_DRP_D, CLK_PLL3, 1, 2),
+		DEF_DIV("DRP_A", R9A07G054_CLK_DRP_A, CLK_PLL3, DIVPL3E, dtable_4_32),
 	},
 #endif
 };
@@ -199,7 +237,7 @@ static const struct {
 static const struct {
 	struct rzg2l_mod_clk common[79];
 #ifdef CONFIG_CLK_R9A07G054
-	struct rzg2l_mod_clk drp[0];
+	struct rzg2l_mod_clk drp[5];
 #endif
 } mod_clks = {
 	.common = {
@@ -364,6 +402,16 @@ static const struct {
 	},
 #ifdef CONFIG_CLK_R9A07G054
 	.drp = {
+		DEF_MOD("stpai_initclk", R9A07G054_STPAI_INITCLK, R9A07G044_OSCCLK,
+					0x5e8, 0),
+		DEF_MOD("stpai_aclk",	R9A07G054_STPAI_ACLK, R9A07G044_CLK_P1,
+					0x5e8, 1),
+		DEF_MOD("stpai_mclk",	R9A07G054_STPAI_MCLK, R9A07G054_CLK_DRP_M,
+					0x5e8, 2),
+		DEF_MOD("stpai_dclkin",	R9A07G054_STPAI_DCLKIN, R9A07G054_CLK_DRP_D,
+					0x5e8, 3),
+		DEF_MOD("stpai_aclk_drp", R9A07G054_STPAI_ACLK_DRP, R9A07G054_CLK_DRP_A,
+					0x5e8, 4),
 	},
 #endif
 };
@@ -430,6 +478,9 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_ADC_PRESETN, 0x8a8, 0),
 	DEF_RST(R9A07G044_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A07G044_TSU_PRESETN, 0x8ac, 0),
+#ifdef CONFIG_CLK_R9A07G054
+	DEF_RST(R9A07G054_STPAI_ARESETN, 0x8e8, 0),
+#endif
 };
 
 static const unsigned int r9a07g044_crit_mod_clks[] __initconst = {
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 6e38c8fc888c..d9be4317e587 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -21,6 +21,7 @@
 #define CPG_PL2_DDIV		(0x204)
 #define CPG_PL3A_DDIV		(0x208)
 #define CPG_PL6_DDIV		(0x210)
+#define CPG_PL3C_SDIV		(0x214)
 #define CPG_CLKSTATUS		(0x280)
 #define CPG_PL3_SSEL		(0x408)
 #define CPG_PL6_SSEL		(0x414)
@@ -58,6 +59,7 @@
 #define DIVPL3A		DDIV_PACK(CPG_PL3A_DDIV, 0, 3)
 #define DIVPL3B		DDIV_PACK(CPG_PL3A_DDIV, 4, 3)
 #define DIVPL3C		DDIV_PACK(CPG_PL3A_DDIV, 8, 3)
+#define DIVPL3E		DDIV_PACK(CPG_PL3C_SDIV, 8, 5)
 #define DIVGPU		DDIV_PACK(CPG_PL6_DDIV, 0, 2)
 
 #define SEL_PLL_PACK(offset, bitpos, size) \
-- 
2.43.0


