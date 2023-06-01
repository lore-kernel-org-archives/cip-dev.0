Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A7AC77B7E
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:21 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.34567.1685631857448189436
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:17 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="161816439"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:16 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B78744010DC0;
	Fri,  2 Jun 2023 00:04:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 01/19] clk: renesas: r9a09g011: Add USB clock and reset entries
Date: Thu,  1 Jun 2023 16:03:52 +0100
Message-Id: <20230601150410.124773-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11731

commit 5edf5b51e760af749c4a8e67cde92db4f3680be5 upstream.

Add USB clock and reset entries to CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20221212172804.1277751-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g011-cpg.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g011-cpg.c b/drivers/clk/renesas/r9a09g011-cpg.c
index 4dfc4e10107a..8ee4b5e27bdd 100644
--- a/drivers/clk/renesas/r9a09g011-cpg.c
+++ b/drivers/clk/renesas/r9a09g011-cpg.c
@@ -23,10 +23,12 @@
 
 #define DIV_A		DDIV_PACK(0x200, 0, 3)
 #define DIV_B		DDIV_PACK(0x204, 0, 2)
+#define DIV_D		DDIV_PACK(0x204, 4, 2)
 #define DIV_E		DDIV_PACK(0x204, 8, 1)
 #define DIV_W		DDIV_PACK(0x328, 0, 3)
 
 #define SEL_B		SEL_PLL_PACK(0x214, 0, 1)
+#define SEL_D		SEL_PLL_PACK(0x214, 1, 1)
 #define SEL_E		SEL_PLL_PACK(0x214, 2, 1)
 #define SEL_W0		SEL_PLL_PACK(0x32C, 0, 1)
 
@@ -50,10 +52,12 @@ enum clk_ids {
 	CLK_PLL4,
 	CLK_DIV_A,
 	CLK_DIV_B,
+	CLK_DIV_D,
 	CLK_DIV_E,
 	CLK_DIV_W,
 	CLK_SEL_B,
 	CLK_SEL_B_D2,
+	CLK_SEL_D,
 	CLK_SEL_E,
 	CLK_SEL_W0,
 
@@ -81,6 +85,13 @@ static const struct clk_div_table dtable_divb[] = {
 	{0, 0},
 };
 
+static const struct clk_div_table dtable_divd[] = {
+	{0, 1},
+	{1, 2},
+	{2, 4},
+	{0, 0},
+};
+
 static const struct clk_div_table dtable_divw[] = {
 	{0, 6},
 	{1, 7},
@@ -94,6 +105,7 @@ static const struct clk_div_table dtable_divw[] = {
 
 /* Mux clock tables */
 static const char * const sel_b[] = { ".main", ".divb" };
+static const char * const sel_d[] = { ".main", ".divd" };
 static const char * const sel_e[] = { ".main", ".dive" };
 static const char * const sel_w[] = { ".main", ".divw" };
 
@@ -115,10 +127,12 @@ static const struct cpg_core_clk r9a09g011_core_clks[] __initconst = {
 
 	DEF_DIV_RO(".diva",	CLK_DIV_A,	CLK_PLL1,	DIV_A,	dtable_diva),
 	DEF_DIV_RO(".divb",	CLK_DIV_B,	CLK_PLL2_400,	DIV_B,	dtable_divb),
+	DEF_DIV_RO(".divd",	CLK_DIV_D,	CLK_PLL2_200,	DIV_D,	dtable_divd),
 	DEF_DIV_RO(".dive",	CLK_DIV_E,	CLK_PLL2_100,	DIV_E,	NULL),
 	DEF_DIV_RO(".divw",	CLK_DIV_W,	CLK_PLL4,	DIV_W,	dtable_divw),
 
 	DEF_MUX_RO(".selb",	CLK_SEL_B,	SEL_B,		sel_b),
+	DEF_MUX_RO(".seld",	CLK_SEL_D,	SEL_D,		sel_d),
 	DEF_MUX_RO(".sele",	CLK_SEL_E,	SEL_E,		sel_e),
 	DEF_MUX(".selw0",	CLK_SEL_W0,	SEL_W0,		sel_w),
 
@@ -131,6 +145,9 @@ static const struct rzg2l_mod_clk r9a09g011_mod_clks[] __initconst = {
 	DEF_COUPLED("eth_axi",	R9A09G011_ETH0_CLK_AXI,	 CLK_PLL2_200, 0x40c, 8),
 	DEF_COUPLED("eth_chi",	R9A09G011_ETH0_CLK_CHI,	 CLK_PLL2_100, 0x40c, 8),
 	DEF_MOD("eth_clk_gptp",	R9A09G011_ETH0_GPTP_EXT, CLK_PLL2_100, 0x40c, 9),
+	DEF_MOD("usb_aclk_h",	R9A09G011_USB_ACLK_H,	 CLK_SEL_D,    0x40c, 4),
+	DEF_MOD("usb_aclk_p",	R9A09G011_USB_ACLK_P,	 CLK_SEL_D,    0x40c, 5),
+	DEF_MOD("usb_pclk",	R9A09G011_USB_PCLK,	 CLK_SEL_E,    0x40c, 6),
 	DEF_MOD("syc_cnt_clk",	R9A09G011_SYC_CNT_CLK,	 CLK_MAIN_24,  0x41c, 12),
 	DEF_MOD("iic_pclk0",	R9A09G011_IIC_PCLK0,	 CLK_SEL_E,    0x420, 12),
 	DEF_MOD("cperi_grpb",	R9A09G011_CPERI_GRPB_PCLK, CLK_SEL_E,  0x424, 0),
@@ -161,6 +178,10 @@ static const struct rzg2l_mod_clk r9a09g011_mod_clks[] __initconst = {
 
 static const struct rzg2l_reset r9a09g011_resets[] = {
 	DEF_RST(R9A09G011_PFC_PRESETN,		0x600, 2),
+	DEF_RST(R9A09G011_USB_PRESET_N,		0x608, 7),
+	DEF_RST(R9A09G011_USB_DRD_RESET,	0x608, 8),
+	DEF_RST(R9A09G011_USB_ARESETN_P,	0x608, 9),
+	DEF_RST(R9A09G011_USB_ARESETN_H,	0x608, 10),
 	DEF_RST_MON(R9A09G011_ETH0_RST_HW_N,	0x608, 11, 11),
 	DEF_RST_MON(R9A09G011_SYC_RST_N,	0x610, 9,  13),
 	DEF_RST(R9A09G011_TIM_GPB_PRESETN,	0x614, 1),
-- 
2.25.1


