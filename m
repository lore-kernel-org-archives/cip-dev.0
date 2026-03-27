Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAA910A88E5
	for <webhook@archiver.kernel.org>; Fri, 27 Mar 2026 09:42:47 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.68197.1774604556949459002
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Mar 2026 02:42:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: qTr3eaZESE6bdKMZxSuWmA==
X-CSE-MsgGUID: CKdpl4DjREGHuHfvZNPvRw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Mar 2026 18:42:37 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.114])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 61B2E401265F;
	Fri, 27 Mar 2026 18:42:36 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/5] clk: renesas: r9a09g056: Add entries for CANFD
Date: Fri, 27 Mar 2026 09:42:28 +0000
Message-ID: <20260327094231.34974-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327094231.34974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260327094231.34974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Mar 2026 09:42:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22591

commit c2922664613277c61922bbe577f25092a85fb27e upstream.

Add clock and reset entries for the CANFD IP.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251224165049.3384870-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: fixed merge conflicts]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g056-cpg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g056-cpg.c b/drivers/clk/renesas/r9a09g056-cpg.c
index b1e8ae47e7f94..651f5efc34bcd 100644
--- a/drivers/clk/renesas/r9a09g056-cpg.c
+++ b/drivers/clk/renesas/r9a09g056-cpg.c
@@ -45,6 +45,7 @@ enum clk_ids {
 	CLK_PLLCLN_DIV2,
 	CLK_PLLCLN_DIV8,
 	CLK_PLLCLN_DIV16,
+	CLK_PLLCLN_DIV20,
 	CLK_PLLDTY_ACPU,
 	CLK_PLLDTY_ACPU_DIV2,
 	CLK_PLLDTY_ACPU_DIV4,
@@ -169,6 +170,7 @@ static const struct cpg_core_clk r9a09g056_core_clks[] __initconst = {
 	DEF_FIXED(".pllcln_div2", CLK_PLLCLN_DIV2, CLK_PLLCLN, 1, 2),
 	DEF_FIXED(".pllcln_div8", CLK_PLLCLN_DIV8, CLK_PLLCLN, 1, 8),
 	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
+	DEF_FIXED(".pllcln_div20", CLK_PLLCLN_DIV20, CLK_PLLCLN, 1, 20),
 
 	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dtable_2_64),
 	DEF_FIXED(".plldty_acpu_div2", CLK_PLLDTY_ACPU_DIV2, CLK_PLLDTY_ACPU, 1, 2),
@@ -284,6 +286,12 @@ static const struct rzv2h_mod_clk r9a09g056_mod_clks[] __initconst = {
 						BUS_MSTOP(1, BIT(7))),
 	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27,
 						BUS_MSTOP(1, BIT(8))),
+	DEF_MOD("canfd_0_pclk",			CLK_PLLCLN_DIV16, 9, 12, 4, 28,
+						BUS_MSTOP(10, BIT(14))),
+	DEF_MOD("canfd_0_clk_ram",		CLK_PLLCLN_DIV8, 9, 13, 4, 29,
+						BUS_MSTOP(10, BIT(14))),
+	DEF_MOD("canfd_0_clkc",			CLK_PLLCLN_DIV20, 9, 14, 4, 30,
+						BUS_MSTOP(10, BIT(14))),
 	DEF_MOD("spi_hclk",			CLK_PLLCM33_GEAR, 9, 15, 4, 31,
 						BUS_MSTOP(4, BIT(5))),
 	DEF_MOD("spi_aclk",			CLK_PLLCM33_GEAR, 10, 0, 5, 0,
@@ -400,6 +408,8 @@ static const struct rzv2h_reset r9a09g056_resets[] __initconst = {
 	DEF_RST(9, 14, 4, 15),		/* RIIC_6_MRST */
 	DEF_RST(9, 15, 4, 16),		/* RIIC_7_MRST */
 	DEF_RST(10, 0, 4, 17),		/* RIIC_8_MRST */
+	DEF_RST(10, 1, 4, 18),		/* CANFD_0_RSTP_N */
+	DEF_RST(10, 2, 4, 19),		/* CANFD_0_RSTC_N */
 	DEF_RST(10, 3, 4, 20),          /* SPI_HRESETN */
 	DEF_RST(10, 4, 4, 21),          /* SPI_ARESETN */
 	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
-- 
2.43.0


