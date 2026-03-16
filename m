Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E62F506EA
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:24 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52440.1773673159009042004
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 7fZHrRNpR/WP9bK9jZy80g==
X-CSE-MsgGUID: Q15TreoaShWUNGbnOLfnJg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:23 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F0C7E41B7814;
	Mon, 16 Mar 2026 23:59:21 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/35] clk: renesas: r9a09g077: Add module clocks for SCI1-SCI5
Date: Mon, 16 Mar 2026 14:58:40 +0000
Message-ID: <20260316145915.8580-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22395

commit 07e7ccd804dc2aac6f3f96129a86b02391b5002d upstream.

Add asynchronous core clocks and module clocks for SCI channels 1
through 5 on the RZ/T2H SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250812171720.3245851-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: resolve merge conflict]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g077-cpg.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index cb06b2eb7834..0b141ee2c5de 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -47,11 +47,16 @@
 #define DIVCA55C3	CONF_PACK(SCKCR2, 11, 1)
 #define DIVCA55S	CONF_PACK(SCKCR2, 12, 1)
 #define DIVSPI3ASYNC	CONF_PACK(SCKCR2, 16, 2)
+#define DIVSCI5ASYNC	CONF_PACK(SCKCR2, 18, 2)
 
 #define DIVSPI0ASYNC	CONF_PACK(SCKCR3, 0, 2)
 #define DIVSPI1ASYNC	CONF_PACK(SCKCR3, 2, 2)
 #define DIVSPI2ASYNC	CONF_PACK(SCKCR3, 4, 2)
 #define DIVSCI0ASYNC	CONF_PACK(SCKCR3, 6, 2)
+#define DIVSCI1ASYNC	CONF_PACK(SCKCR3, 8, 2)
+#define DIVSCI2ASYNC	CONF_PACK(SCKCR3, 10, 2)
+#define DIVSCI3ASYNC	CONF_PACK(SCKCR3, 12, 2)
+#define DIVSCI4ASYNC	CONF_PACK(SCKCR3, 14, 2)
 
 #define SEL_PLL		CONF_PACK(SCKCR, 22, 1)
 
@@ -87,6 +92,11 @@ enum clk_ids {
 	CLK_SEL_CLK_PLL4,
 	CLK_PLL4D1,
 	CLK_SCI0ASYNC,
+	CLK_SCI1ASYNC,
+	CLK_SCI2ASYNC,
+	CLK_SCI3ASYNC,
+	CLK_SCI4ASYNC,
+	CLK_SCI5ASYNC,
 	CLK_SPI0ASYNC,
 	CLK_SPI1ASYNC,
 	CLK_SPI2ASYNC,
@@ -140,6 +150,16 @@ static const struct cpg_core_clk r9a09g077_core_clks[] __initconst = {
 	DEF_FIXED(".pll4d1", CLK_PLL4D1, CLK_SEL_CLK_PLL4, 1, 1),
 	DEF_DIV(".sci0async", CLK_SCI0ASYNC, CLK_PLL4D1, DIVSCI0ASYNC,
 		dtable_24_25_30_32),
+	DEF_DIV(".sci1async", CLK_SCI1ASYNC, CLK_PLL4D1, DIVSCI1ASYNC,
+		dtable_24_25_30_32),
+	DEF_DIV(".sci2async", CLK_SCI2ASYNC, CLK_PLL4D1, DIVSCI2ASYNC,
+		dtable_24_25_30_32),
+	DEF_DIV(".sci3async", CLK_SCI3ASYNC, CLK_PLL4D1, DIVSCI3ASYNC,
+		dtable_24_25_30_32),
+	DEF_DIV(".sci4async", CLK_SCI4ASYNC, CLK_PLL4D1, DIVSCI4ASYNC,
+		dtable_24_25_30_32),
+	DEF_DIV(".sci5async", CLK_SCI5ASYNC, CLK_PLL4D1, DIVSCI5ASYNC,
+		dtable_24_25_30_32),
 
 	DEF_DIV(".spi0async", CLK_SPI0ASYNC, CLK_PLL4D1, DIVSPI0ASYNC,
 		dtable_24_25_30_32),
@@ -171,6 +191,10 @@ static const struct cpg_core_clk r9a09g077_core_clks[] __initconst = {
 
 static const struct mssr_mod_clk r9a09g077_mod_clks[] __initconst = {
 	DEF_MOD("sci0fck", 8, CLK_SCI0ASYNC),
+	DEF_MOD("sci1fck", 9, CLK_SCI1ASYNC),
+	DEF_MOD("sci2fck", 10, CLK_SCI2ASYNC),
+	DEF_MOD("sci3fck", 11, CLK_SCI3ASYNC),
+	DEF_MOD("sci4fck", 12, CLK_SCI4ASYNC),
 	DEF_MOD("iic0", 100, R9A09G077_CLK_PCLKL),
 	DEF_MOD("iic1", 101, R9A09G077_CLK_PCLKL),
 	DEF_MOD("spi0", 104, CLK_SPI0ASYNC),
@@ -180,6 +204,7 @@ static const struct mssr_mod_clk r9a09g077_mod_clks[] __initconst = {
 	DEF_MOD("adc1", 207, R9A09G077_CLK_PCLKH),
 	DEF_MOD("adc2", 225, R9A09G077_CLK_PCLKM),
 	DEF_MOD("usb", 408, R9A09G077_CLK_PCLKAM),
+	DEF_MOD("sci5fck", 600, CLK_SCI5ASYNC),
 	DEF_MOD("iic2", 601, R9A09G077_CLK_PCLKL),
 	DEF_MOD("spi3", 602, CLK_SPI3ASYNC),
 	DEF_MOD("sdhi0", 1212, R9A09G077_CLK_PCLKAM),
-- 
2.43.0


