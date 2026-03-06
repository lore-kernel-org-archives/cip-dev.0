Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88D9FCC041
	for <webhook@archiver.kernel.org>; Fri,  6 Mar 2026 17:18:32 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.74548.1772817507868725562
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Mar 2026 09:18:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: kkEsna/WS8WkiJHOm1gJVw==
X-CSE-MsgGUID: eAAt021sQXK4MsJrLnJvoA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Mar 2026 02:18:32 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.180])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E0E3E4031FE8;
	Sat,  7 Mar 2026 02:18:30 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip v2 04/17] clk: renesas: r9a09g077: Add SPI module clocks
Date: Fri,  6 Mar 2026 19:17:22 +0200
Message-ID: <20260306171735.226034-5-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260306171735.226034-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2026 17:18:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22129

commit 5fb2f67341bd4b7c482f2bbda6b78244a51c3923 upstream.

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have four SPI
peripherals, each with their own clock divider, which divides PLL4 by
either 24, 25, 30 or 32, similar to the SCI peripheral.

The dividers feed into the usual module clocks.

Add them all.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251105104151.1489281-2-cosmin-gabriel.tanislav.xa@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * remove internal Reviewed-by tags

 drivers/clk/renesas/r9a09g077-cpg.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index af49565a544e..a1d420254ca6 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -46,12 +46,15 @@
 #define DIVCA55C2	CONF_PACK(SCKCR2, 10, 1)
 #define DIVCA55C3	CONF_PACK(SCKCR2, 11, 1)
 #define DIVCA55S	CONF_PACK(SCKCR2, 12, 1)
+#define DIVSPI3ASYNC	CONF_PACK(SCKCR2, 16, 2)
 
+#define DIVSPI0ASYNC	CONF_PACK(SCKCR3, 0, 2)
+#define DIVSPI1ASYNC	CONF_PACK(SCKCR3, 2, 2)
+#define DIVSPI2ASYNC	CONF_PACK(SCKCR3, 4, 2)
 #define DIVSCI0ASYNC	CONF_PACK(SCKCR3, 6, 2)
 
 #define SEL_PLL		CONF_PACK(SCKCR, 22, 1)
 
-
 enum rzt2h_clk_types {
 	CLK_TYPE_RZT2H_DIV = CLK_TYPE_CUSTOM,	/* Clock with divider */
 	CLK_TYPE_RZT2H_MUX,			/* Clock with clock source selector */
@@ -84,6 +87,10 @@ enum clk_ids {
 	CLK_SEL_CLK_PLL4,
 	CLK_PLL4D1,
 	CLK_SCI0ASYNC,
+	CLK_SPI0ASYNC,
+	CLK_SPI1ASYNC,
+	CLK_SPI2ASYNC,
+	CLK_SPI3ASYNC,
 
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -134,6 +141,15 @@ static const struct cpg_core_clk r9a09g077_core_clks[] __initconst = {
 	DEF_DIV(".sci0async", CLK_SCI0ASYNC, CLK_PLL4D1, DIVSCI0ASYNC,
 		dtable_24_25_30_32),
 
+	DEF_DIV(".spi0async", CLK_SPI0ASYNC, CLK_PLL4D1, DIVSPI0ASYNC,
+		dtable_24_25_30_32),
+	DEF_DIV(".spi1async", CLK_SPI1ASYNC, CLK_PLL4D1, DIVSPI1ASYNC,
+		dtable_24_25_30_32),
+	DEF_DIV(".spi2async", CLK_SPI2ASYNC, CLK_PLL4D1, DIVSPI2ASYNC,
+		dtable_24_25_30_32),
+	DEF_DIV(".spi3async", CLK_SPI3ASYNC, CLK_PLL4D1, DIVSPI3ASYNC,
+		dtable_24_25_30_32),
+
 	/* Core output clk */
 	DEF_DIV("CA55C0", R9A09G077_CLK_CA55C0, CLK_SEL_CLK_PLL0, DIVCA55C0,
 		dtable_1_2),
@@ -156,10 +172,14 @@ static const struct mssr_mod_clk r9a09g077_mod_clks[] __initconst = {
 	DEF_MOD("sci0fck", 8, CLK_SCI0ASYNC),
 	DEF_MOD("iic0", 100, R9A09G077_CLK_PCLKL),
 	DEF_MOD("iic1", 101, R9A09G077_CLK_PCLKL),
+	DEF_MOD("spi0", 104, CLK_SPI0ASYNC),
+	DEF_MOD("spi1", 105, CLK_SPI1ASYNC),
+	DEF_MOD("spi2", 106, CLK_SPI2ASYNC),
 	DEF_MOD("adc0", 206, R9A09G077_CLK_PCLKH),
 	DEF_MOD("adc1", 207, R9A09G077_CLK_PCLKH),
 	DEF_MOD("adc2", 225, R9A09G077_CLK_PCLKM),
 	DEF_MOD("iic2", 601, R9A09G077_CLK_PCLKL),
+	DEF_MOD("spi3", 602, CLK_SPI3ASYNC),
 	DEF_MOD("sdhi0", 1212, R9A09G077_CLK_PCLKAM),
 	DEF_MOD("sdhi1", 1213, R9A09G077_CLK_PCLKAM),
 };
-- 
2.53.0

