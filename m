Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5979CC77B75
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.6173.1682061490711437733
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:11 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="160252406"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:10 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3E38841AA3E8;
	Fri, 21 Apr 2023 16:18:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 15/33] clk: renesas: rzg2l: Set HIWORD mask for all mux and dividers
Date: Fri, 21 Apr 2023 08:17:11 +0100
Message-Id: <20230421071729.130347-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11288

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 75b0ad42ccd9a87873e91598116471d9991b09ea upstream.

All of the muxes and dividers that can be modified require the HIWORD
flags, so make the macros set them. It won't affect read only muxes and
dividers.
This will make the clock tables a little easier to read, particularly for
new SoCs coming.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220503115557.53370-8-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 18 ++++++------------
 drivers/clk/renesas/r9a07g044-cpg.c | 21 +++++++--------------
 drivers/clk/renesas/rzg2l-cpg.h     |  9 +++++----
 3 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index fde934151b57..53a58034bef4 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -99,8 +99,7 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_FIXED(".pll3_400", CLK_PLL3_400, CLK_PLL3, 1, 4),
 	DEF_FIXED(".pll3_533", CLK_PLL3_533, CLK_PLL3, 1, 3),
 	DEF_MUX_RO(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3, sel_pll3_3),
-	DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3,
-		DIVPL3C, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+	DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3, DIVPL3C, dtable_1_32),
 	DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
 	DEF_FIXED(".pll5_500", CLK_PLL5_500, CLK_PLL5, 1, 6),
 	DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_500, 1, 2),
@@ -108,21 +107,16 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
 
 	/* Core output clk */
-	DEF_DIV("I", R9A07G043_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8,
-		CLK_DIVIDER_HIWORD_MASK),
-	DEF_DIV("P0", R9A07G043_CLK_P0, CLK_PLL2_DIV2_8, DIVPL2A,
-		dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+	DEF_DIV("I", R9A07G043_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8),
+	DEF_DIV("P0", R9A07G043_CLK_P0, CLK_PLL2_DIV2_8, DIVPL2A, dtable_1_32),
 	DEF_FIXED("P0_DIV2", R9A07G043_CLK_P0_DIV2, R9A07G043_CLK_P0, 1, 2),
 	DEF_FIXED("TSU", R9A07G043_CLK_TSU, CLK_PLL2_DIV2_10, 1, 1),
-	DEF_DIV("P1", R9A07G043_CLK_P1, CLK_PLL3_DIV2_4,
-		DIVPL3B, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+	DEF_DIV("P1", R9A07G043_CLK_P1, CLK_PLL3_DIV2_4, DIVPL3B, dtable_1_32),
 	DEF_FIXED("P1_DIV2", CLK_P1_DIV2, R9A07G043_CLK_P1, 1, 2),
-	DEF_DIV("P2", R9A07G043_CLK_P2, CLK_PLL3_DIV2_4_2,
-		DIVPL3A, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+	DEF_DIV("P2", R9A07G043_CLK_P2, CLK_PLL3_DIV2_4_2, DIVPL3A, dtable_1_32),
 	DEF_FIXED("M0", R9A07G043_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
 	DEF_FIXED("ZT", R9A07G043_CLK_ZT, CLK_PLL3_DIV2_4_2, 1, 1),
-	DEF_MUX("HP", R9A07G043_CLK_HP, SEL_PLL6_2,
-		sel_pll6_2, 0, CLK_MUX_HIWORD_MASK),
+	DEF_MUX("HP", R9A07G043_CLK_HP, SEL_PLL6_2, sel_pll6_2),
 	DEF_FIXED("SPI0", R9A07G043_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 	DEF_FIXED("SPI1", R9A07G043_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
 	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0, sel_shdi),
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 25c8059ffaf7..de1fe6d277dc 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -119,37 +119,30 @@ static const struct {
 		DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
 		DEF_FIXED(".pll3_div2_4_2", CLK_PLL3_DIV2_4_2, CLK_PLL3_DIV2_4, 1, 2),
 		DEF_MUX_RO(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3, sel_pll3_3),
-		DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3,
-			DIVPL3C, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+		DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3, DIVPL3C, dtable_1_32),
 
 		DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_FOUT3, 1, 2),
 		DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
 		DEF_MUX_RO(".sel_gpu2", CLK_SEL_GPU2, SEL_GPU2, sel_gpu2),
 
 		/* Core output clk */
-		DEF_DIV("I", R9A07G044_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8,
-			CLK_DIVIDER_HIWORD_MASK),
-		DEF_DIV("P0", R9A07G044_CLK_P0, CLK_PLL2_DIV2_8, DIVPL2A,
-			dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+		DEF_DIV("I", R9A07G044_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8),
+		DEF_DIV("P0", R9A07G044_CLK_P0, CLK_PLL2_DIV2_8, DIVPL2A, dtable_1_32),
 		DEF_FIXED("P0_DIV2", R9A07G044_CLK_P0_DIV2, R9A07G044_CLK_P0, 1, 2),
 		DEF_FIXED("TSU", R9A07G044_CLK_TSU, CLK_PLL2_DIV2_10, 1, 1),
-		DEF_DIV("P1", R9A07G044_CLK_P1, CLK_PLL3_DIV2_4,
-			DIVPL3B, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+		DEF_DIV("P1", R9A07G044_CLK_P1, CLK_PLL3_DIV2_4, DIVPL3B, dtable_1_32),
 		DEF_FIXED("P1_DIV2", CLK_P1_DIV2, R9A07G044_CLK_P1, 1, 2),
-		DEF_DIV("P2", R9A07G044_CLK_P2, CLK_PLL3_DIV2_4_2,
-			DIVPL3A, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+		DEF_DIV("P2", R9A07G044_CLK_P2, CLK_PLL3_DIV2_4_2, DIVPL3A, dtable_1_32),
 		DEF_FIXED("M0", R9A07G044_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
 		DEF_FIXED("ZT", R9A07G044_CLK_ZT, CLK_PLL3_DIV2_4_2, 1, 1),
-		DEF_MUX("HP", R9A07G044_CLK_HP, SEL_PLL6_2,
-			sel_pll6_2, 0, CLK_MUX_HIWORD_MASK),
+		DEF_MUX("HP", R9A07G044_CLK_HP, SEL_PLL6_2, sel_pll6_2),
 		DEF_FIXED("SPI0", R9A07G044_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 		DEF_FIXED("SPI1", R9A07G044_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
 		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0, sel_shdi),
 		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1, sel_shdi),
 		DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
 		DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
-		DEF_DIV("G", R9A07G044_CLK_G, CLK_SEL_GPU2, DIVGPU, dtable_1_8,
-			CLK_DIVIDER_HIWORD_MASK),
+		DEF_DIV("G", R9A07G044_CLK_G, CLK_SEL_GPU2, DIVGPU, dtable_1_8),
 	},
 #ifdef CONFIG_CLK_R9A07G054
 	.drp = {
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index f6af7c8fea0f..57c935ecd782 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -98,18 +98,19 @@ enum clk_types {
 	DEF_TYPE(_name, _id, CLK_TYPE_IN)
 #define DEF_FIXED(_name, _id, _parent, _mult, _div) \
 	DEF_BASE(_name, _id, CLK_TYPE_FF, _parent, .div = _div, .mult = _mult)
-#define DEF_DIV(_name, _id, _parent, _conf, _dtable, _flag) \
+#define DEF_DIV(_name, _id, _parent, _conf, _dtable) \
 	DEF_TYPE(_name, _id, CLK_TYPE_DIV, .conf = _conf, \
-		 .parent = _parent, .dtable = _dtable, .flag = _flag)
+		 .parent = _parent, .dtable = _dtable, \
+		 .flag = CLK_DIVIDER_HIWORD_MASK)
 #define DEF_DIV_RO(_name, _id, _parent, _conf, _dtable) \
 	DEF_TYPE(_name, _id, CLK_TYPE_DIV, .conf = _conf, \
 		 .parent = _parent, .dtable = _dtable, \
 		 .flag = CLK_DIVIDER_READ_ONLY)
-#define DEF_MUX(_name, _id, _conf, _parent_names, _flag, _mux_flags) \
+#define DEF_MUX(_name, _id, _conf, _parent_names) \
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, \
 		 .num_parents = ARRAY_SIZE(_parent_names), \
-		 .flag = _flag, .mux_flags = _mux_flags)
+		 .mux_flags = CLK_MUX_HIWORD_MASK)
 #define DEF_MUX_RO(_name, _id, _conf, _parent_names) \
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, \
-- 
2.25.1


