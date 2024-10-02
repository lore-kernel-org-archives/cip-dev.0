Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36925CF6D5D
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:07:33 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1134.1727888847435222280
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 10:07:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,172,1725289200"; 
   d="scan'208";a="224579763"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Oct 2024 02:07:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.106])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4E50D4007533;
	Thu,  3 Oct 2024 02:07:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/15] clk: renesas: r9a07g043: Add LCDC clock and reset entries
Date: Wed,  2 Oct 2024 18:06:54 +0100
Message-ID: <20241002170712.655449-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 17:07:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16968

commit 10dfa837da4f5319ef6871c7cc7357da190c482f upstream.

Add LCDC clock and reset entries to CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240709135152.185042-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 078364ac739e..3675b317682b 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -52,6 +52,8 @@ enum clk_ids {
 	CLK_PLL5,
 	CLK_PLL5_500,
 	CLK_PLL5_250,
+	CLK_PLL5_FOUTPOSTDIV,
+	CLK_DSI_DIV,
 #endif
 	CLK_PLL6,
 	CLK_PLL6_250,
@@ -120,6 +122,7 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_FIXED(".pll5", CLK_PLL5, CLK_EXTAL, 125, 1),
 	DEF_FIXED(".pll5_500", CLK_PLL5_500, CLK_PLL5, 1, 6),
 	DEF_FIXED(".pll5_250", CLK_PLL5_250, CLK_PLL5_500, 1, 2),
+	DEF_PLL5_FOUTPOSTDIV(".pll5_foutpostdiv", CLK_PLL5_FOUTPOSTDIV, CLK_EXTAL),
 #endif
 	DEF_FIXED(".pll6", CLK_PLL6, CLK_EXTAL, 125, 6),
 	DEF_FIXED(".pll6_250", CLK_PLL6_250, CLK_PLL6, 1, 2),
@@ -146,6 +149,8 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 #ifdef CONFIG_ARM64
 	DEF_FIXED("M2", R9A07G043_CLK_M2, CLK_PLL3_533, 1, 2),
 	DEF_FIXED("M2_DIV2", CLK_M2_DIV2, R9A07G043_CLK_M2, 1, 2),
+	DEF_DSI_DIV("DSI_DIV", CLK_DSI_DIV, CLK_PLL5_FOUTPOSTDIV, CLK_SET_RATE_PARENT),
+	DEF_FIXED("M3", R9A07G043_CLK_M3, CLK_DSI_DIV, 1, 1),
 #endif
 };
 
@@ -209,6 +214,12 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x564, 2),
 	DEF_MOD("cru_aclk",     R9A07G043_CRU_ACLK, R9A07G043_CLK_M0,
 				0x564, 3),
+	DEF_COUPLED("lcdc_clk_a", R9A07G043_LCDC_CLK_A, R9A07G043_CLK_M0,
+				0x56c, 0),
+	DEF_COUPLED("lcdc_clk_p", R9A07G043_LCDC_CLK_P, R9A07G043_CLK_ZT,
+				0x56c, 0),
+	DEF_MOD("lcdc_clk_d",	R9A07G043_LCDC_CLK_D, R9A07G043_CLK_M3,
+				0x56c, 1),
 #endif
 	DEF_MOD("ssi0_pclk",	R9A07G043_SSI0_PCLK2, R9A07G043_CLK_P0,
 				0x570, 0),
@@ -305,6 +316,7 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_CRU_CMN_RSTB, 0x864, 0),
 	DEF_RST(R9A07G043_CRU_PRESETN, 0x864, 1),
 	DEF_RST(R9A07G043_CRU_ARESETN, 0x864, 2),
+	DEF_RST(R9A07G043_LCDC_RESET_N, 0x86c, 0),
 #endif
 	DEF_RST(R9A07G043_SSI0_RST_M2_REG, 0x870, 0),
 	DEF_RST(R9A07G043_SSI1_RST_M2_REG, 0x870, 1),
-- 
2.43.0


