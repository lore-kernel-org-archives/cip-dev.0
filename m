Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7B6CD3436
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 06:49:54 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9370.1777877388211967274
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 May 2026 23:49:48 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: PPdBYjW/S06TbTNhB5FRPA==
X-CSE-MsgGUID: HK+5sYbxSTGj91M3T6bHrg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 May 2026 15:49:47 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 73286400A884;
	Mon,  4 May 2026 15:49:46 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 1/9] clk: renesas: r9a09g057: Add USB3.0 clocks/resets
Date: Mon,  4 May 2026 06:49:35 +0000
Message-ID: <20260504064943.7237-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504064943.7237-1-ovidiu.panait.rb@renesas.com>
References: <20260504064943.7237-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 06:49:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22848

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 4ecc8ccde5b488eb7284c1e674f274850eb039a6 upstream.

Add USB3.0 clock and reset entries.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251101050034.738807-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a09g057-cpg.c
index 1bee9df6b63f..f5715947e845 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -17,7 +17,7 @@
 
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
-	LAST_DT_CORE_CLK = R9A09G057_SPI_CLK_SPI,
+	LAST_DT_CORE_CLK = R9A09G057_USB3_1_CLKCORE,
 
 	/* External Input Clocks */
 	CLK_AUDIO_EXTAL,
@@ -236,6 +236,10 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __initconst = {
 		  CLK_PLLETH_DIV_125_FIX, 1, 1),
 	DEF_FIXED_MOD_STATUS("spi_clk_spi", R9A09G057_SPI_CLK_SPI, CLK_PLLCM33_XSPI, 1, 2,
 			     FIXED_MOD_CONF_XSPI),
+	DEF_FIXED("usb3_0_ref_alt_clk_p", R9A09G057_USB3_0_REF_ALT_CLK_P, CLK_QEXTAL, 1, 1),
+	DEF_FIXED("usb3_0_core_clk", R9A09G057_USB3_0_CLKCORE, CLK_QEXTAL, 1, 1),
+	DEF_FIXED("usb3_1_ref_alt_clk_p", R9A09G057_USB3_1_REF_ALT_CLK_P, CLK_QEXTAL, 1, 1),
+	DEF_FIXED("usb3_1_core_clk", R9A09G057_USB3_1_CLKCORE, CLK_QEXTAL, 1, 1),
 };
 
 static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst = {
@@ -361,6 +365,14 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst = {
 						BUS_MSTOP(8, BIT(4))),
 	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14,
 						BUS_MSTOP(8, BIT(4))),
+	DEF_MOD("usb3_0_aclk",			CLK_PLLDTY_DIV8, 10, 15, 5, 15,
+						BUS_MSTOP(7, BIT(12))),
+	DEF_MOD("usb3_0_pclk_usbtst",		CLK_PLLDTY_ACPU_DIV4, 11, 0, 5, 16,
+						BUS_MSTOP(7, BIT(14))),
+	DEF_MOD("usb3_1_aclk",			CLK_PLLDTY_DIV8, 11, 1, 5, 17,
+						BUS_MSTOP(7, BIT(13))),
+	DEF_MOD("usb3_1_pclk_usbtst",		CLK_PLLDTY_ACPU_DIV4, 11, 2, 5, 18,
+						BUS_MSTOP(7, BIT(15))),
 	DEF_MOD("usb2_0_u2h0_hclk",		CLK_PLLDTY_DIV8, 11, 3, 5, 19,
 						BUS_MSTOP(7, BIT(7))),
 	DEF_MOD("usb2_0_u2h1_hclk",		CLK_PLLDTY_DIV8, 11, 4, 5, 20,
@@ -494,6 +506,8 @@ static const struct rzv2h_reset r9a09g057_resets[] __initconst = {
 	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
 	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
 	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
+	DEF_RST(10, 10, 4, 27),		/* USB3_0_ARESETN */
+	DEF_RST(10, 11, 4, 28),		/* USB3_1_ARESETN */
 	DEF_RST(10, 12, 4, 29),		/* USB2_0_U2H0_HRESETN */
 	DEF_RST(10, 13, 4, 30),		/* USB2_0_U2H1_HRESETN */
 	DEF_RST(10, 14, 4, 31),		/* USB2_0_U2P_EXL_SYSRST */
-- 
2.34.1


