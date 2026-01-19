Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7D8D489A5
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 12:52:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34123.1768827110577540923
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 04:51:52 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: s9xMwsAORcWC4MstmVaLzQ==
X-CSE-MsgGUID: B6dhGssDSsCR0uB6inRsxw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jan 2026 21:51:51 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 68461401BC13;
	Mon, 19 Jan 2026 21:51:50 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 1/6] clk: renesas: r9a09g056: Add clock and reset entries for USB2.0
Date: Mon, 19 Jan 2026 12:51:42 +0000
Message-ID: <20260119125147.32175-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119125147.32175-1-ovidiu.panait.rb@renesas.com>
References: <20260119125147.32175-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 12:52:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21653

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit e6b6e3e08f012f967bb0babf4b0da4535d7f617b upstream.

Add clock and reset entries for USB2.0.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250528132558.167178-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/r9a09g056-cpg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g056-cpg.c b/drivers/clk/renesas/r9a09g056-cpg.c
index 7e34c4259a6c..75059c436334 100644
--- a/drivers/clk/renesas/r9a09g056-cpg.c
+++ b/drivers/clk/renesas/r9a09g056-cpg.c
@@ -127,6 +127,7 @@ static const struct cpg_core_clk r9a09g056_core_clks[] __initconst = {
 	DEF_DDIV("ca55_0_coreclk3", R9A09G056_CA55_0_CORE_CLK3, CLK_PLLCA55,
 		 CDDIV1_DIVCTL3, dtable_1_8),
 	DEF_FIXED("iotop_0_shclk", R9A09G056_IOTOP_0_SHCLK, CLK_PLLCM33_DIV16, 1, 1),
+	DEF_FIXED("usb2_0_clk_core0", R9A09G056_USB2_0_CLK_CORE0, CLK_QEXTAL, 1, 1),
 	DEF_FIXED("gbeth_0_clk_ptp_ref_i", R9A09G056_GBETH_0_CLK_PTP_REF_I,
 		  CLK_PLLETH_DIV_125_FIX, 1, 1),
 	DEF_FIXED("gbeth_1_clk_ptp_ref_i", R9A09G056_GBETH_1_CLK_PTP_REF_I,
@@ -212,6 +213,12 @@ static const struct rzv2h_mod_clk r9a09g056_mod_clks[] __initconst = {
 						BUS_MSTOP(8, BIT(4))),
 	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14,
 						BUS_MSTOP(8, BIT(4))),
+	DEF_MOD("usb2_0_u2h0_hclk",		CLK_PLLDTY_DIV8, 11, 3, 5, 19,
+						BUS_MSTOP(7, BIT(7))),
+	DEF_MOD("usb2_0_u2p_exr_cpuclk",	CLK_PLLDTY_ACPU_DIV4, 11, 5, 5, 21,
+						BUS_MSTOP(7, BIT(9))),
+	DEF_MOD("usb2_0_pclk_usbtst0",		CLK_PLLDTY_ACPU_DIV4, 11, 6, 5, 22,
+						BUS_MSTOP(7, BIT(10))),
 	DEF_MOD_MUX_EXTERNAL("gbeth_0_clk_tx_i", CLK_SMUX2_GBE0_TXCLK, 11, 8, 5, 24,
 						BUS_MSTOP(8, BIT(5)), 1),
 	DEF_MOD_MUX_EXTERNAL("gbeth_0_clk_rx_i", CLK_SMUX2_GBE0_RXCLK, 11, 9, 5, 25,
@@ -267,6 +274,9 @@ static const struct rzv2h_reset r9a09g056_resets[] __initconst = {
 	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
 	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
 	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
+	DEF_RST(10, 12, 4, 29),		/* USB2_0_U2H0_HRESETN */
+	DEF_RST(10, 14, 4, 31),		/* USB2_0_U2P_EXL_SYSRST */
+	DEF_RST(10, 15, 5, 0),		/* USB2_0_PRESETN */
 	DEF_RST(11, 0, 5, 1),		/* GBETH_0_ARESETN_I */
 	DEF_RST(11, 1, 5, 2),		/* GBETH_1_ARESETN_I */
 };
-- 
2.51.0


