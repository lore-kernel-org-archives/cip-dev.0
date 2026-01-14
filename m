Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855A5D2A004
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 12:53:34 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9221.1768395209402849745
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 04:53:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: qVv99GG3R6+RIkk0Im5rZw==
X-CSE-MsgGUID: CjYtkxguQxqLzRMa4IKyuA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jan 2026 21:53:28 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 99E89400D0FA;
	Wed, 14 Jan 2026 21:53:27 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 1/4] clk: renesas: r9a09g056: Add clock and reset entries for RIIC controllers
Date: Wed, 14 Jan 2026 12:53:21 +0000
Message-ID: <20260114125324.8630-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114125324.8630-1-ovidiu.panait.rb@renesas.com>
References: <20260114125324.8630-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 12:53:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21548

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d3c25dd1612da7ddf5857190e92b0c36d803c4d9 upstream.

Add module clock and reset definitions for RIIC controllers 0-8, which
are available on the RZ/V2N (R9A09G056) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250513154635.273664-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/r9a09g056-cpg.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g056-cpg.c b/drivers/clk/renesas/r9a09g056-cpg.c
index 6ac4b62a5e56..7e34c4259a6c 100644
--- a/drivers/clk/renesas/r9a09g056-cpg.c
+++ b/drivers/clk/renesas/r9a09g056-cpg.c
@@ -170,6 +170,24 @@ static const struct rzv2h_mod_clk r9a09g056_mod_clks[] __initconst = {
 						BUS_MSTOP(5, BIT(13))),
 	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
 						BUS_MSTOP(3, BIT(14))),
+	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19,
+						BUS_MSTOP(3, BIT(13))),
+	DEF_MOD("riic_0_ckm",			CLK_PLLCLN_DIV16, 9, 4, 4, 20,
+						BUS_MSTOP(1, BIT(1))),
+	DEF_MOD("riic_1_ckm",			CLK_PLLCLN_DIV16, 9, 5, 4, 21,
+						BUS_MSTOP(1, BIT(2))),
+	DEF_MOD("riic_2_ckm",			CLK_PLLCLN_DIV16, 9, 6, 4, 22,
+						BUS_MSTOP(1, BIT(3))),
+	DEF_MOD("riic_3_ckm",			CLK_PLLCLN_DIV16, 9, 7, 4, 23,
+						BUS_MSTOP(1, BIT(4))),
+	DEF_MOD("riic_4_ckm",			CLK_PLLCLN_DIV16, 9, 8, 4, 24,
+						BUS_MSTOP(1, BIT(5))),
+	DEF_MOD("riic_5_ckm",			CLK_PLLCLN_DIV16, 9, 9, 4, 25,
+						BUS_MSTOP(1, BIT(6))),
+	DEF_MOD("riic_6_ckm",			CLK_PLLCLN_DIV16, 9, 10, 4, 26,
+						BUS_MSTOP(1, BIT(7))),
+	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27,
+						BUS_MSTOP(1, BIT(8))),
 	DEF_MOD("sdhi_0_imclk",			CLK_PLLCLN_DIV8, 10, 3, 5, 3,
 						BUS_MSTOP(8, BIT(2))),
 	DEF_MOD("sdhi_0_imclk2",		CLK_PLLCLN_DIV8, 10, 4, 5, 4,
@@ -237,6 +255,15 @@ static const struct rzv2h_reset r9a09g056_resets[] __initconst = {
 	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
 	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
 	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
+	DEF_RST(9, 8, 4, 9),		/* RIIC_0_MRST */
+	DEF_RST(9, 9, 4, 10),		/* RIIC_1_MRST */
+	DEF_RST(9, 10, 4, 11),		/* RIIC_2_MRST */
+	DEF_RST(9, 11, 4, 12),		/* RIIC_3_MRST */
+	DEF_RST(9, 12, 4, 13),		/* RIIC_4_MRST */
+	DEF_RST(9, 13, 4, 14),		/* RIIC_5_MRST */
+	DEF_RST(9, 14, 4, 15),		/* RIIC_6_MRST */
+	DEF_RST(9, 15, 4, 16),		/* RIIC_7_MRST */
+	DEF_RST(10, 0, 4, 17),		/* RIIC_8_MRST */
 	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
 	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
 	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
-- 
2.51.0


