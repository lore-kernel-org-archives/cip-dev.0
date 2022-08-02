Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8858C19F2B
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 11:09:11 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.4832.1659438534534175527
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 04:09:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600";
   d="scan'208";a="130054321"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Aug 2022 20:09:04 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B589B400E8C0;
	Tue,  2 Aug 2022 20:09:02 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 05/24] clk: renesas: r9a07g044: Add mux and divider
 for G clock
Date: Tue,  2 Aug 2022 12:08:31 +0100
Message-Id: <20220802110850.1496057-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 11:09:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9002

commit 7ef9c45a23a9071dee23ca1a769c53ec2cdc07c0 upstream.

G clock is sourced from PLL3 and PLL6. The output of the mux is
connected to divider.

This patch adds a mux and divider for getting different rates from
this clock sources.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211203115154.31864-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 6 ++++++
 drivers/clk/renesas/rzg2l-cpg.h     | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 0962f25cd3f0..85132b6c97b7 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -50,6 +50,7 @@ enum clk_ids {
 	CLK_PLL2_SDHI_266,
 	CLK_SD0_DIV4,
 	CLK_SD1_DIV4,
+	CLK_SEL_GPU2,
 
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -77,6 +78,7 @@ static const struct clk_div_table dtable_1_32[] = {
 static const char * const sel_pll3_3[] = { ".pll3_533", ".pll3_400" };
 static const char * const sel_pll6_2[]	= { ".pll6_250", ".pll5_250" };
 static const char * const sel_shdi[] = { ".clk_533", ".clk_400", ".clk_266" };
+static const char * const sel_gpu2[] = { ".pll6", ".pll3_div2_2" };
 
 static const struct cpg_core_clk r9a07g044_core_clks[] __initconst = {
 	/* External Clock Inputs */
@@ -116,6 +118,8 @@ static const struct cpg_core_clk r9a07g044_core_clks[] __initconst = {
 
 	DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_FOUT3, 1, 2),
 	DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
+	DEF_MUX(".sel_gpu2", CLK_SEL_GPU2, SEL_GPU2,
+		sel_gpu2, ARRAY_SIZE(sel_gpu2), 0, CLK_MUX_READ_ONLY),
 
 	/* Core output clk */
 	DEF_DIV("I", R9A07G044_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8,
@@ -141,6 +145,8 @@ static const struct cpg_core_clk r9a07g044_core_clks[] __initconst = {
 		   sel_shdi, ARRAY_SIZE(sel_shdi)),
 	DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
 	DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
+	DEF_DIV("G", R9A07G044_CLK_G, CLK_SEL_GPU2, DIVGPU, dtable_1_8,
+		CLK_DIVIDER_HIWORD_MASK),
 };
 
 static struct rzg2l_mod_clk r9a07g044_mod_clks[] = {
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index fce4a8f35410..5729d102034b 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -12,9 +12,11 @@
 #define CPG_PL1_DDIV		(0x200)
 #define CPG_PL2_DDIV		(0x204)
 #define CPG_PL3A_DDIV		(0x208)
+#define CPG_PL6_DDIV		(0x210)
 #define CPG_PL2SDHI_DSEL	(0x218)
 #define CPG_CLKSTATUS		(0x280)
 #define CPG_PL3_SSEL		(0x408)
+#define CPG_PL6_SSEL		(0x414)
 #define CPG_PL6_ETH_SSEL	(0x418)
 
 #define CPG_CLKSTATUS_SELSDHI0_STS	BIT(28)
@@ -35,12 +37,14 @@
 #define DIVPL3A		DDIV_PACK(CPG_PL3A_DDIV, 0, 3)
 #define DIVPL3B		DDIV_PACK(CPG_PL3A_DDIV, 4, 3)
 #define DIVPL3C		DDIV_PACK(CPG_PL3A_DDIV, 8, 3)
+#define DIVGPU		DDIV_PACK(CPG_PL6_DDIV, 0, 2)
 
 #define SEL_PLL_PACK(offset, bitpos, size) \
 		(((offset) << 20) | ((bitpos) << 12) | ((size) << 8))
 
 #define SEL_PLL3_3	SEL_PLL_PACK(CPG_PL3_SSEL, 8, 1)
 #define SEL_PLL6_2	SEL_PLL_PACK(CPG_PL6_ETH_SSEL, 0, 1)
+#define SEL_GPU2	SEL_PLL_PACK(CPG_PL6_SSEL, 12, 1)
 
 #define SEL_SDHI0	DDIV_PACK(CPG_PL2SDHI_DSEL, 0, 2)
 #define SEL_SDHI1	DDIV_PACK(CPG_PL2SDHI_DSEL, 4, 2)
-- 
2.25.1


