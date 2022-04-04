Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A04C63701
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:46 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.34385.1649075759683192518
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Apr 2022 05:36:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,234,1643641200";
   d="scan'208";a="115671989"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Apr 2022 21:36:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 070094222E7D;
	Mon,  4 Apr 2022 21:36:03 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/29] clk: renesas: r9a07g044: Add WDT clock and
 reset entries
Date: Mon,  4 Apr 2022 13:35:31 +0100
Message-Id: <20220404123553.25851-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7970

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 073da9e7c768b0d81f9ce22cc907227450612d88 upstream.

Add WDT{0,1,2} clock and reset entries to CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20211104160858.15550-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index c39d60197d95..a09ce7abb36a 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -145,6 +145,18 @@ static struct rzg2l_mod_clk r9a07g044_mod_clks[] = {
 				0x52c, 0),
 	DEF_MOD("dmac_pclk",	R9A07G044_DMAC_PCLK, CLK_P1_DIV2,
 				0x52c, 1),
+	DEF_MOD("wdt0_pclk",	R9A07G044_WDT0_PCLK, R9A07G044_CLK_P0,
+				0x548, 0),
+	DEF_MOD("wdt0_clk",	R9A07G044_WDT0_CLK, R9A07G044_OSCCLK,
+				0x548, 1),
+	DEF_MOD("wdt1_pclk",	R9A07G044_WDT1_PCLK, R9A07G044_CLK_P0,
+				0x548, 2),
+	DEF_MOD("wdt1_clk",	R9A07G044_WDT1_CLK, R9A07G044_OSCCLK,
+				0x548, 3),
+	DEF_MOD("wdt2_pclk",	R9A07G044_WDT2_PCLK, R9A07G044_CLK_P0,
+				0x548, 4),
+	DEF_MOD("wdt2_clk",	R9A07G044_WDT2_CLK, R9A07G044_OSCCLK,
+				0x548, 5),
 	DEF_MOD("spi_clk2",	R9A07G044_SPI_CLK2, R9A07G044_CLK_SPI1,
 				0x550, 0),
 	DEF_MOD("spi_clk",	R9A07G044_SPI_CLK, R9A07G044_CLK_SPI0,
@@ -241,6 +253,9 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_IA55_RESETN, 0x818, 0),
 	DEF_RST(R9A07G044_DMAC_ARESETN, 0x82c, 0),
 	DEF_RST(R9A07G044_DMAC_RST_ASYNC, 0x82c, 1),
+	DEF_RST(R9A07G044_WDT0_PRESETN, 0x848, 0),
+	DEF_RST(R9A07G044_WDT1_PRESETN, 0x848, 1),
+	DEF_RST(R9A07G044_WDT2_PRESETN, 0x848, 2),
 	DEF_RST(R9A07G044_SPI_RST, 0x850, 0),
 	DEF_RST(R9A07G044_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A07G044_SDHI1_IXRST, 0x854, 1),
-- 
2.17.1


