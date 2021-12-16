Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A3C433FE
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 12:54:59 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.10189.1639659298966442092
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 04:54:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,211,1635174000";
   d="scan'208";a="104171932"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Dec 2021 21:54:58 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4F9CC4010737;
	Thu, 16 Dec 2021 21:54:57 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/24] clk: renesas: r9a07g044: Rename divider
 table
Date: Thu, 16 Dec 2021 12:54:29 +0000
Message-Id: <20211216125446.15451-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 12:54:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7130

From: Biju Das <biju.das.jz@bp.renesas.com>

commit e93c1373613fb2f3e59db5f13271f155820e6a67 upstream.

As per RZ/G2L HW Manual (Rev.0.50), CPG_PL3A_DDIV,CPG_PL3B_DDIV
and CPG_PL2_DDIV(for P0) shares same divider table entries. Rename
clk_div_table dtable_3b to clk_div_table dtable_1_32 so that it
can be reused.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210626081344.5783-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 50b5269586a4..d5803fb1242e 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -42,12 +42,13 @@ enum clk_ids {
 };
 
 /* Divider tables */
-static const struct clk_div_table dtable_3b[] = {
+static const struct clk_div_table dtable_1_32[] = {
 	{0, 1},
 	{1, 2},
 	{2, 4},
 	{3, 8},
 	{4, 32},
+	{0, 0},
 };
 
 static const struct cpg_core_clk r9a07g044_core_clks[] __initconst = {
@@ -72,10 +73,10 @@ static const struct cpg_core_clk r9a07g044_core_clks[] __initconst = {
 	/* Core output clk */
 	DEF_FIXED("I", R9A07G044_CLK_I, CLK_PLL1, 1, 1),
 	DEF_DIV("P0", R9A07G044_CLK_P0, CLK_PLL2_DIV16, DIVPL2A,
-		dtable_3b, CLK_DIVIDER_HIWORD_MASK),
+		dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
 	DEF_FIXED("TSU", R9A07G044_CLK_TSU, CLK_PLL2_DIV20, 1, 1),
 	DEF_DIV("P1", R9A07G044_CLK_P1, CLK_PLL3_DIV8,
-		DIVPL3B, dtable_3b, CLK_DIVIDER_HIWORD_MASK),
+		DIVPL3B, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
 };
 
 static struct rzg2l_mod_clk r9a07g044_mod_clks[] = {
-- 
2.17.1


