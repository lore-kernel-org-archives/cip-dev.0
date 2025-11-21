Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97757CFA748
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 08:07:54 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7333.1763712460639498828
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 00:07:45 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: TF1ih1VRS9KttDc9+Tm04A==
X-CSE-MsgGUID: wYHwjOd3RGy0mQABar2k7A==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Nov 2025 17:07:45 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D677441B5577;
	Fri, 21 Nov 2025 17:07:43 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 3/6] clk: renesas: r9a09g057: Add XSPI clock/reset
Date: Fri, 21 Nov 2025 08:07:34 +0000
Message-ID: <20251121080737.20611-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121080737.20611-1-ovidiu.panait.rb@renesas.com>
References: <20251121080737.20611-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 08:07:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20671

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit fc7dd515374455f07cdd24b8bad3c7952e812bff upstream.

Add clock and reset entries for the XSPI interface on the R9A09G057 SoC.

While at it, rename CLK_PLLCM33_DIV4_PLLCM33 to CLK_PLLCM33_GEAR to align
with the terminology used in the hardware manual.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250627204237.214635-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[OP: Included FIXED_MOD_CONF_XSPI macro from a separate upstream commit
20e31205ae1 ("clk: renesas: r9a09g056: Add XSPI clock/reset") to fix
the build. Only the macro definition was taken; r9a09g056-cpg.c changes
were skipped as the file doesn't exist in 6.12.y-cip]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 16 +++++++++++++---
 drivers/clk/renesas/rzv2h-cpg.h     |  2 ++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a09g057-cpg.c
index 39065d63df61..687c25f76852 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -36,8 +36,8 @@ enum clk_ids {
 	CLK_PLLCM33_DIV3,
 	CLK_PLLCM33_DIV4,
 	CLK_PLLCM33_DIV5,
-	CLK_PLLCM33_DIV4_PLLCM33,
 	CLK_PLLCM33_DIV16,
+	CLK_PLLCM33_GEAR,
 	CLK_SMUX2_XSPI_CLK0,
 	CLK_SMUX2_XSPI_CLK1,
 	CLK_PLLCM33_XSPI,
@@ -134,7 +134,7 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __initconst = {
 	DEF_FIXED(".pllcm33_div3", CLK_PLLCM33_DIV3, CLK_PLLCM33, 1, 3),
 	DEF_FIXED(".pllcm33_div4", CLK_PLLCM33_DIV4, CLK_PLLCM33, 1, 4),
 	DEF_FIXED(".pllcm33_div5", CLK_PLLCM33_DIV5, CLK_PLLCM33, 1, 5),
-	DEF_DDIV(".pllcm33_div4_pllcm33", CLK_PLLCM33_DIV4_PLLCM33,
+	DEF_DDIV(".pllcm33_gear", CLK_PLLCM33_GEAR,
 		 CLK_PLLCM33_DIV4, CDDIV0_DIVCTL1, dtable_2_64),
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
 	DEF_SMUX(".smux2_xspi_clk0", CLK_SMUX2_XSPI_CLK0, SSEL1_SELCTL2, smux2_xspi_clk0),
@@ -189,10 +189,12 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __initconst = {
 		  CLK_PLLETH_DIV_125_FIX, 1, 1),
 	DEF_FIXED("gbeth_1_clk_ptp_ref_i", R9A09G057_GBETH_1_CLK_PTP_REF_I,
 		  CLK_PLLETH_DIV_125_FIX, 1, 1),
+	DEF_FIXED_MOD_STATUS("spi_clk_spi", R9A09G057_SPI_CLK_SPI, CLK_PLLCM33_XSPI, 1, 2,
+			     FIXED_MOD_CONF_XSPI),
 };
 
 static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst = {
-	DEF_MOD("dmac_0_aclk",			CLK_PLLCM33_DIV4_PLLCM33, 0, 0, 0, 0,
+	DEF_MOD("dmac_0_aclk",			CLK_PLLCM33_GEAR, 0, 0, 0, 0,
 						BUS_MSTOP(5, BIT(9))),
 	DEF_MOD("dmac_1_aclk",			CLK_PLLDTY_ACPU_DIV2, 0, 1, 0, 1,
 						BUS_MSTOP(3, BIT(2))),
@@ -258,6 +260,12 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst = {
 						BUS_MSTOP(1, BIT(7))),
 	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27,
 						BUS_MSTOP(1, BIT(8))),
+	DEF_MOD("spi_hclk",			CLK_PLLCM33_GEAR, 9, 15, 4, 31,
+						BUS_MSTOP(4, BIT(5))),
+	DEF_MOD("spi_aclk",			CLK_PLLCM33_GEAR, 10, 0, 5, 0,
+						BUS_MSTOP(4, BIT(5))),
+	DEF_MOD("spi_clk_spix2",		CLK_PLLCM33_XSPI, 10, 1, 5, 2,
+						BUS_MSTOP(4, BIT(5))),
 	DEF_MOD("sdhi_0_imclk",			CLK_PLLCLN_DIV8, 10, 3, 5, 3,
 						BUS_MSTOP(8, BIT(2))),
 	DEF_MOD("sdhi_0_imclk2",		CLK_PLLCLN_DIV8, 10, 4, 5, 4,
@@ -380,6 +388,8 @@ static const struct rzv2h_reset r9a09g057_resets[] __initconst = {
 	DEF_RST(9, 14, 4, 15),		/* RIIC_6_MRST */
 	DEF_RST(9, 15, 4, 16),		/* RIIC_7_MRST */
 	DEF_RST(10, 0, 4, 17),		/* RIIC_8_MRST */
+	DEF_RST(10, 3, 4, 20),		/* SPI_HRESETN */
+	DEF_RST(10, 4, 4, 21),		/* SPI_ARESETN */
 	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
 	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
 	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cpg.h
index 34423bd4d3e1..f1fcc2c30ea1 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -149,6 +149,8 @@ struct fixed_mod_conf {
 				 FIELD_PREP_CONST(BUS_MSTOP_BITS_MASK, (mask)))
 #define BUS_MSTOP_NONE		GENMASK(31, 0)
 
+#define FIXED_MOD_CONF_XSPI    FIXED_MOD_CONF_PACK(5, 1)
+
 /**
  * Definitions of CPG Core Clocks
  *
-- 
2.51.0


