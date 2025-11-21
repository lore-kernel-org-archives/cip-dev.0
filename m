Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D22CFA477
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 08:07:04 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7318.1763712414317368490
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 00:06:54 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: XaUhu6XgQ2iq2FoIX8rroA==
X-CSE-MsgGUID: OimmR2QvTE292sKI7lTdrQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Nov 2025 17:06:53 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5D3FB437E743;
	Fri, 21 Nov 2025 17:06:52 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 2/6] clk: renesas: r9a09g057: Add support for xspi mux and divider
Date: Fri, 21 Nov 2025 08:06:43 +0000
Message-ID: <20251121080647.20592-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121080647.20592-1-ovidiu.panait.rb@renesas.com>
References: <20251121080647.20592-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 08:07:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20663

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 7aada0abe9676d90d95fce065a8227e5d494f611 upstream.

The mux smux2_xspi_clk{0,1} used for selecting spi and spix2 clocks and
pllcm33_xspi divider to select different clock rates. Add support for
both.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250627204237.214635-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a09g057-cpg.c
index da908e820950..39065d63df61 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -16,7 +16,7 @@
 
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
-	LAST_DT_CORE_CLK = R9A09G057_GBETH_1_CLK_PTP_REF_I,
+	LAST_DT_CORE_CLK = R9A09G057_SPI_CLK_SPI,
 
 	/* External Input Clocks */
 	CLK_AUDIO_EXTAL,
@@ -33,9 +33,14 @@ enum clk_ids {
 	CLK_PLLGPU,
 
 	/* Internal Core Clocks */
+	CLK_PLLCM33_DIV3,
 	CLK_PLLCM33_DIV4,
+	CLK_PLLCM33_DIV5,
 	CLK_PLLCM33_DIV4_PLLCM33,
 	CLK_PLLCM33_DIV16,
+	CLK_SMUX2_XSPI_CLK0,
+	CLK_SMUX2_XSPI_CLK1,
+	CLK_PLLCM33_XSPI,
 	CLK_PLLCLN_DIV2,
 	CLK_PLLCLN_DIV8,
 	CLK_PLLCLN_DIV16,
@@ -78,6 +83,14 @@ static const struct clk_div_table dtable_2_4[] = {
 	{0, 0},
 };
 
+static const struct clk_div_table dtable_2_16[] = {
+	{0, 2},
+	{1, 4},
+	{2, 8},
+	{3, 16},
+	{0, 0},
+};
+
 static const struct clk_div_table dtable_2_64[] = {
 	{0, 2},
 	{1, 4},
@@ -99,6 +112,8 @@ static const char * const smux2_gbe0_rxclk[] = { ".plleth_gbe0", "et0_rxclk" };
 static const char * const smux2_gbe0_txclk[] = { ".plleth_gbe0", "et0_txclk" };
 static const char * const smux2_gbe1_rxclk[] = { ".plleth_gbe1", "et1_rxclk" };
 static const char * const smux2_gbe1_txclk[] = { ".plleth_gbe1", "et1_txclk" };
+static const char * const smux2_xspi_clk0[] = { ".pllcm33_div3", ".pllcm33_div4" };
+static const char * const smux2_xspi_clk1[] = { ".smux2_xspi_clk0", ".pllcm33_div5" };
 
 static const struct cpg_core_clk r9a09g057_core_clks[] __initconst = {
 	/* External Clock Inputs */
@@ -116,10 +131,16 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __initconst = {
 	DEF_PLL(".pllgpu", CLK_PLLGPU, CLK_QEXTAL, PLLGPU),
 
 	/* Internal Core Clocks */
+	DEF_FIXED(".pllcm33_div3", CLK_PLLCM33_DIV3, CLK_PLLCM33, 1, 3),
 	DEF_FIXED(".pllcm33_div4", CLK_PLLCM33_DIV4, CLK_PLLCM33, 1, 4),
+	DEF_FIXED(".pllcm33_div5", CLK_PLLCM33_DIV5, CLK_PLLCM33, 1, 5),
 	DEF_DDIV(".pllcm33_div4_pllcm33", CLK_PLLCM33_DIV4_PLLCM33,
 		 CLK_PLLCM33_DIV4, CDDIV0_DIVCTL1, dtable_2_64),
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
+	DEF_SMUX(".smux2_xspi_clk0", CLK_SMUX2_XSPI_CLK0, SSEL1_SELCTL2, smux2_xspi_clk0),
+	DEF_SMUX(".smux2_xspi_clk1", CLK_SMUX2_XSPI_CLK1, SSEL1_SELCTL3, smux2_xspi_clk1),
+	DEF_CSDIV(".pllcm33_xspi", CLK_PLLCM33_XSPI, CLK_SMUX2_XSPI_CLK1, CSDIV0_DIVCTL3,
+		  dtable_2_16),
 
 	DEF_FIXED(".pllcln_div2", CLK_PLLCLN_DIV2, CLK_PLLCLN, 1, 2),
 	DEF_FIXED(".pllcln_div8", CLK_PLLCLN_DIV8, CLK_PLLCLN, 1, 8),
-- 
2.51.0


