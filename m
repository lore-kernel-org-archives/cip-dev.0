Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB97C77B7E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.6169.1682061470715228262
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:08 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="156786953"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:07 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BABA741AA88B;
	Fri, 21 Apr 2023 16:18:05 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 14/33] clk: renesas: rzg2l: Add read only versions of the clk macros
Date: Fri, 21 Apr 2023 08:17:10 +0100
Message-Id: <20230421071729.130347-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11287

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 8282fe0029e0db02fc21500790bfb621572fd28c upstream.

This just makes the clk tables easier to read.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Link: https://lore.kernel.org/r/20220503115557.53370-7-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 3 +--
 drivers/clk/renesas/r9a07g044-cpg.c | 6 ++----
 drivers/clk/renesas/rzg2l-cpg.h     | 9 +++++++++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 8241f5972de1..fde934151b57 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -98,8 +98,7 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_FIXED(".pll3_div2_4_2", CLK_PLL3_DIV2_4_2, CLK_PLL3_DIV2_4, 1, 2),
 	DEF_FIXED(".pll3_400", CLK_PLL3_400, CLK_PLL3, 1, 4),
 	DEF_FIXED(".pll3_533", CLK_PLL3_533, CLK_PLL3, 1, 3),
-	DEF_MUX(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3,
-		sel_pll3_3, 0, CLK_MUX_READ_ONLY),
+	DEF_MUX_RO(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3, sel_pll3_3),
 	DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3,
 		DIVPL3C, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
 	DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index fa36a88f0e7c..25c8059ffaf7 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -118,15 +118,13 @@ static const struct {
 		DEF_FIXED(".pll3_div2_2", CLK_PLL3_DIV2_2, CLK_PLL3_DIV2, 1, 2),
 		DEF_FIXED(".pll3_div2_4", CLK_PLL3_DIV2_4, CLK_PLL3_DIV2, 1, 4),
 		DEF_FIXED(".pll3_div2_4_2", CLK_PLL3_DIV2_4_2, CLK_PLL3_DIV2_4, 1, 2),
-		DEF_MUX(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3,
-			sel_pll3_3, 0, CLK_MUX_READ_ONLY),
+		DEF_MUX_RO(".sel_pll3_3", CLK_SEL_PLL3_3, SEL_PLL3_3, sel_pll3_3),
 		DEF_DIV("divpl3c", CLK_DIV_PLL3_C, CLK_SEL_PLL3_3,
 			DIVPL3C, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
 
 		DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_FOUT3, 1, 2),
 		DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
-		DEF_MUX(".sel_gpu2", CLK_SEL_GPU2, SEL_GPU2,
-			sel_gpu2, 0, CLK_MUX_READ_ONLY),
+		DEF_MUX_RO(".sel_gpu2", CLK_SEL_GPU2, SEL_GPU2, sel_gpu2),
 
 		/* Core output clk */
 		DEF_DIV("I", R9A07G044_CLK_I, CLK_PLL1, DIVPL1A, dtable_1_8,
diff --git a/drivers/clk/renesas/rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
index ca4a1321a639..f6af7c8fea0f 100644
--- a/drivers/clk/renesas/rzg2l-cpg.h
+++ b/drivers/clk/renesas/rzg2l-cpg.h
@@ -101,11 +101,20 @@ enum clk_types {
 #define DEF_DIV(_name, _id, _parent, _conf, _dtable, _flag) \
 	DEF_TYPE(_name, _id, CLK_TYPE_DIV, .conf = _conf, \
 		 .parent = _parent, .dtable = _dtable, .flag = _flag)
+#define DEF_DIV_RO(_name, _id, _parent, _conf, _dtable) \
+	DEF_TYPE(_name, _id, CLK_TYPE_DIV, .conf = _conf, \
+		 .parent = _parent, .dtable = _dtable, \
+		 .flag = CLK_DIVIDER_READ_ONLY)
 #define DEF_MUX(_name, _id, _conf, _parent_names, _flag, _mux_flags) \
 	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, \
 		 .num_parents = ARRAY_SIZE(_parent_names), \
 		 .flag = _flag, .mux_flags = _mux_flags)
+#define DEF_MUX_RO(_name, _id, _conf, _parent_names) \
+	DEF_TYPE(_name, _id, CLK_TYPE_MUX, .conf = _conf, \
+		 .parent_names = _parent_names, \
+		 .num_parents = ARRAY_SIZE(_parent_names), \
+		 .mux_flags = CLK_MUX_READ_ONLY)
 #define DEF_SD_MUX(_name, _id, _conf, _parent_names) \
 	DEF_TYPE(_name, _id, CLK_TYPE_SD_MUX, .conf = _conf, \
 		 .parent_names = _parent_names, \
-- 
2.25.1


