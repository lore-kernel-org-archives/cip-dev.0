Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB60C77B75
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.6169.1682061470715228262
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="156786944"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:05 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4240641AA3E8;
	Fri, 21 Apr 2023 16:18:02 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 13/33] clk: renesas: rzg2l: Move the DEF_MUX array size calc into the macro
Date: Fri, 21 Apr 2023 08:17:09 +0100
Message-Id: <20230421071729.130347-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11286

From: Phil Edworthy <phil.edworthy@renesas.com>

commit ceb3bfab2da49f804ec629a20f731611b9ece207 upstream.

We only ever use ARRAY_SIZE() to populate the number of parents, so
move this into the macro to always detect it automatically. This
also makes the tables of clocks a little simpler.
Similarly for the DEF_SD_MUX macro.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Link: https://lore.kernel.org/r/20220503115557.53370-6-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 10 ++++------
 drivers/clk/renesas/r9a07g044-cpg.c | 12 +++++-------
 drivers/clk/renesas/rzg2l-cpg.h     | 11 ++++++-----
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 7ef2c43ea891..8241f5972de1 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -99,7 +99,7 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_FIXED(".pll3_400", CLK_PLL3_400, CLK_PLL3, 1, 4),
 	DEF_FIXED(".pll3_533", CLK_PLL3_533, CLK_PLL3, 1, 3),
 	DEF_MUX(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3,
-		sel_pll3_3, ARRAY_SIZE(sel_pll3_3), 0, CLK_MUX_READ_ONLY),
+		sel_pll3_3, 0, CLK_MUX_READ_ONLY),
 	DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3,
 		DIVPL3C, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
 	DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
@@ -123,13 +123,11 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_FIXED("M0", R9A07G043_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
 	DEF_FIXED("ZT", R9A07G043_CLK_ZT, CLK_PLL3_DIV2_4_2, 1, 1),
 	DEF_MUX("HP", R9A07G043_CLK_HP, SEL_PLL6_2,
-		sel_pll6_2, ARRAY_SIZE(sel_pll6_2), 0, CLK_MUX_HIWORD_MASK),
+		sel_pll6_2, 0, CLK_MUX_HIWORD_MASK),
 	DEF_FIXED("SPI0", R9A07G043_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 	DEF_FIXED("SPI1", R9A07G043_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
-	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0,
-		   sel_shdi, ARRAY_SIZE(sel_shdi)),
-	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, SEL_SDHI1,
-		   sel_shdi, ARRAY_SIZE(sel_shdi)),
+	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0, sel_shdi),
+	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, SEL_SDHI1, sel_shdi),
 	DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G043_CLK_SD0, 1, 4),
 	DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G043_CLK_SD1, 1, 4),
 };
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 518f00d86782..fa36a88f0e7c 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -119,14 +119,14 @@ static const struct {
 		DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
 		DEF_FIXED(".pll3_div2_4_2", CLK_PLL3_DIV2_4_2, CLK_PLL3_DIV2_4, 1, 2),
 		DEF_MUX(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3,
-			sel_pll3_3, ARRAY_SIZE(sel_pll3_3), 0, CLK_MUX_READ_ONLY),
+			sel_pll3_3, 0, CLK_MUX_READ_ONLY),
 		DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3,
 			DIVPL3C, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
 
 		DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_FOUT3, 1, 2),
 		DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
 		DEF_MUX(".sel_gpu2", CLK_SEL_GPU2, SEL_GPU2,
-			sel_gpu2, ARRAY_SIZE(sel_gpu2), 0, CLK_MUX_READ_ONLY),
+			sel_gpu2, 0, CLK_MUX_READ_ONLY),
 
 		/* Core output clk */
 		DEF_DIV("I", R9A07G044_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8,
@@ -143,13 +143,11 @@ static const struct {
 		DEF_FIXED("M0", R9A07G044_CLK_M0, CLK_PLL3_DIV2_4, 1, 1),
 		DEF_FIXED("ZT", R9A07G044_CLK_ZT, CLK_PLL3_DIV2_4_2, 1, 1),
 		DEF_MUX("HP", R9A07G044_CLK_HP, SEL_PLL6_2,
-			sel_pll6_2, ARRAY_SIZE(sel_pll6_2), 0, CLK_MUX_HIWORD_MASK),
+			sel_pll6_2, 0, CLK_MUX_HIWORD_MASK),
 		DEF_FIXED("SPI0", R9A07G044_CLK_SPI0, CLK_DIV_PLL3_C, 1, 2),
 		DEF_FIXED("SPI1", R9A07G044_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
-		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0,
-			   sel_shdi, ARRAY_SIZE(sel_shdi)),
-		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1,
-			   sel_shdi, ARRAY_SIZE(sel_shdi)),
+		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0, sel_shdi),
+		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1, sel_shdi),
 		DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
 		DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
 		DEF_DIV("G", R9A07G044_CLK_G, CLK_SEL_GPU2, DIVGPU, dtable_1_8,
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index 92c88f42ca7f..ca4a1321a639 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -101,14 +101,15 @@ enum clk_types {
 #define DEF_DIV(_name, _id, _parent, _conf, _dtable, _flag) \
 	DEF_TYPE(_name, _id, CLK_TYPE_DIV, .conf = _conf, \
 		 .parent = _parent, .dtable = _dtable, .flag = _flag)
-#define DEF_MUX(_name, _id, _conf, _parent_names, _num_parents, _flag, \
-		_mux_flags) \
+#define DEF_MUX(_name, _id, _conf, _parent_names, _flag, _mux_flags) \
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
-		 .parent_names = _parent_names, .num_parents = _num_parents, \
+		 .parent_names = _parent_names, \
+		 .num_parents = ARRAY_SIZE(_parent_names), \
 		 .flag = _flag, .mux_flags = _mux_flags)
-#define DEF_SD_MUX(_name, _id, _conf, _parent_names, _num_parents) \
+#define DEF_SD_MUX(_name, _id, _conf, _parent_names) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SD_MUX, .conf = _conf, \
-		 .parent_names = _parent_names, .num_parents = _num_parents)
+		 .parent_names = _parent_names, \
+		 .num_parents = ARRAY_SIZE(_parent_names))
 
 /**
  * struct rzg2l_mod_clk - Module Clocks definitions
-- 
2.25.1


