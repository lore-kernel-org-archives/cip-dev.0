Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1895C10F09
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 10:55:35 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.81315.1701946517933410769
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 02:55:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="185659848"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2023 19:55:31 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EC5BA420A72E;
	Thu,  7 Dec 2023 19:55:29 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/12] clk: renesas: r9a07g044: Add DSI clock and reset entries
Date: Thu,  7 Dec 2023 10:55:05 +0000
Message-Id: <20231207105508.171162-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
References: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 10:55:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13821

commit 67f80edf8390fd8201bb285fe2b55df9e2e5edbe upstream.

Add DSI clock and reset entries to CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220430114156.6260-10-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index e27a8e50fac1..ab546d57cb60 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -182,7 +182,7 @@ static const struct {
 };
 
 static const struct {
-	struct rzg2l_mod_clk common[64];
+	struct rzg2l_mod_clk common[70];
 #ifdef CONFIG_CLK_R9A07G054
 	struct rzg2l_mod_clk drp[0];
 #endif
@@ -240,6 +240,18 @@ static const struct {
 					0x558, 1),
 		DEF_MOD("gpu_ace_clk",	R9A07G044_GPU_ACE_CLK, R9A07G044_CLK_P1,
 					0x558, 2),
+		DEF_MOD("dsi_pll_clk",	R9A07G044_MIPI_DSI_PLLCLK, R9A07G044_CLK_M1,
+					0x568, 0),
+		DEF_MOD("dsi_sys_clk",	R9A07G044_MIPI_DSI_SYSCLK, CLK_M2_DIV2,
+					0x568, 1),
+		DEF_MOD("dsi_aclk",	R9A07G044_MIPI_DSI_ACLK, R9A07G044_CLK_P1,
+					0x568, 2),
+		DEF_MOD("dsi_pclk",	R9A07G044_MIPI_DSI_PCLK, R9A07G044_CLK_P2,
+					0x568, 3),
+		DEF_MOD("dsi_vclk",	R9A07G044_MIPI_DSI_VCLK, R9A07G044_CLK_M3,
+					0x568, 4),
+		DEF_MOD("dsi_lpclk",	R9A07G044_MIPI_DSI_LPCLK, R9A07G044_CLK_M4,
+					0x568, 5),
 		DEF_COUPLED("lcdc_a",	R9A07G044_LCDC_CLK_A, R9A07G044_CLK_M0,
 					0x56c, 0),
 		DEF_COUPLED("lcdc_p",	R9A07G044_LCDC_CLK_P, R9A07G044_CLK_ZT,
@@ -341,6 +353,9 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_GPU_RESETN, 0x858, 0),
 	DEF_RST(R9A07G044_GPU_AXI_RESETN, 0x858, 1),
 	DEF_RST(R9A07G044_GPU_ACE_RESETN, 0x858, 2),
+	DEF_RST(R9A07G044_MIPI_DSI_CMN_RSTB, 0x868, 0),
+	DEF_RST(R9A07G044_MIPI_DSI_ARESET_N, 0x868, 1),
+	DEF_RST(R9A07G044_MIPI_DSI_PRESET_N, 0x868, 2),
 	DEF_RST(R9A07G044_LCDC_RESET_N, 0x86c, 0),
 	DEF_RST(R9A07G044_SSI0_RST_M2_REG, 0x870, 0),
 	DEF_RST(R9A07G044_SSI1_RST_M2_REG, 0x870, 1),
-- 
2.25.1


