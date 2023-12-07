Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6B3C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 10:55:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.81322.1701946536546916874
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 02:55:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="189532873"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2023 19:55:35 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 47D6D420DBD6;
	Thu,  7 Dec 2023 19:55:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 11/12] clk: renesas: r9a07g044: Add POEG clock and reset entries
Date: Thu,  7 Dec 2023 10:55:07 +0000
Message-Id: <20231207105508.171162-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
References: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 10:55:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13823

commit b6ee0bbf388ab38384f92339aa9a1df15e716cfe upstream.

Add POEG clock and reset entries to CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220510110653.7326-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index c61ff71b60eb..f5550fccb029 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -182,7 +182,7 @@ static const struct {
 };
 
 static const struct {
-	struct rzg2l_mod_clk common[71];
+	struct rzg2l_mod_clk common[75];
 #ifdef CONFIG_CLK_R9A07G054
 	struct rzg2l_mod_clk drp[0];
 #endif
@@ -208,6 +208,14 @@ static const struct {
 					0x538, 0),
 		DEF_MOD("gpt_pclk",	R9A07G044_GPT_PCLK, R9A07G044_CLK_P0,
 					0x540, 0),
+		DEF_MOD("poeg_a_clkp",	R9A07G044_POEG_A_CLKP, R9A07G044_CLK_P0,
+					0x544, 0),
+		DEF_MOD("poeg_b_clkp",	R9A07G044_POEG_B_CLKP, R9A07G044_CLK_P0,
+					0x544, 1),
+		DEF_MOD("poeg_c_clkp",	R9A07G044_POEG_C_CLKP, R9A07G044_CLK_P0,
+					0x544, 2),
+		DEF_MOD("poeg_d_clkp",	R9A07G044_POEG_D_CLKP, R9A07G044_CLK_P0,
+					0x544, 3),
 		DEF_MOD("wdt0_pclk",	R9A07G044_WDT0_PCLK, R9A07G044_CLK_P0,
 					0x548, 0),
 		DEF_MOD("wdt0_clk",	R9A07G044_WDT0_CLK, R9A07G044_OSCCLK,
@@ -348,6 +356,10 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_OSTM2_PRESETZ, 0x834, 2),
 	DEF_RST(R9A07G044_MTU_X_PRESET_MTU3, 0x838, 0),
 	DEF_RST(R9A07G044_GPT_RST_C, 0x840, 0),
+	DEF_RST(R9A07G044_POEG_A_RST, 0x844, 0),
+	DEF_RST(R9A07G044_POEG_B_RST, 0x844, 1),
+	DEF_RST(R9A07G044_POEG_C_RST, 0x844, 2),
+	DEF_RST(R9A07G044_POEG_D_RST, 0x844, 3),
 	DEF_RST(R9A07G044_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A07G044_WDT1_PRESETN, 0x848, 1),
 	DEF_RST(R9A07G044_SPI_RST, 0x850, 0),
-- 
2.25.1


