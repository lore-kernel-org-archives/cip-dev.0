Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8FCD1A609
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 12:17:27 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8787.1767961041818980139
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 04:17:24 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: iYSBH/wHQFKVGrXBLuH1hA==
X-CSE-MsgGUID: Z31Ler4/RPqiX2owMT4JUw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 09 Jan 2026 21:17:24 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.57])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 20EB04172F36;
	Fri,  9 Jan 2026 21:17:22 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 2/8] clk: renesas: r9a09g057: Add clock and reset entries for RTC
Date: Fri,  9 Jan 2026 12:17:12 +0000
Message-ID: <20260109121718.46056-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109121718.46056-1-ovidiu.panait.rb@renesas.com>
References: <20260109121718.46056-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 12:17:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21518

commit 7a03ef9f8223434f19e19a37acc32dcb581ab475 upstream.

Add module clock and reset entries for the RTC module on the Renesas RZ/V2H
(R9A09G057) SoC.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251021080705.18116-2-ovidiu.panait.rb@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a09g057-cpg.c
index bd27e2933e4c..007dbbe08eb3 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -240,6 +240,8 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst = {
 						BUS_MSTOP(5, BIT(13))),
 	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18,
 						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("rtc_0_clk_rtc",		CLK_PLLCM33_DIV16, 5, 3, 2, 19,
+						BUS_MSTOP(3, BIT(11) | BIT(12))),
 	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
 						BUS_MSTOP(3, BIT(14))),
 	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19,
@@ -382,6 +384,8 @@ static const struct rzv2h_reset r9a09g057_resets[] __initconst = {
 	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
 	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
 	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
+	DEF_RST(7, 9, 3, 10),		/* RTC_0_RST_RTC */
+	DEF_RST(7, 10, 3, 11),		/* RTC_0_RST_RTC_V */
 	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
 	DEF_RST(9, 8, 4, 9),		/* RIIC_0_MRST */
 	DEF_RST(9, 9, 4, 10),		/* RIIC_1_MRST */
-- 
2.51.0


