Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3904EB64DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 14:06:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.8505.1689689174299622997
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 07:06:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="169767859"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Jul 2023 23:06:17 +0900
Received: from localhost.localdomain (unknown [10.226.92.137])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5D95A42167FE;
	Tue, 18 Jul 2023 23:06:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 03/13] clk: renesas: r9a07g044: Add MTU3a clock and reset entry
Date: Tue, 18 Jul 2023 15:05:58 +0100
Message-Id: <20230718140608.119449-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
References: <20230718140608.119449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 14:06:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12380

commit 576d6b40dcceade7d77e88f63e621349c6937bc3 upstream.

Add MTU3a clock and reset entry to CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20221005111855.553436-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index b31201c7ca7b..29b2a69d58d2 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -151,7 +151,7 @@ static const struct {
 };
 
 static const struct {
-	struct rzg2l_mod_clk common[62];
+	struct rzg2l_mod_clk common[63];
 #ifdef CONFIG_CLK_R9A07G054
 	struct rzg2l_mod_clk drp[0];
 #endif
@@ -173,6 +173,8 @@ static const struct {
 					0x534, 1),
 		DEF_MOD("ostm2_pclk",	R9A07G044_OSTM2_PCLK, R9A07G044_CLK_P0,
 					0x534, 2),
+		DEF_MOD("mtu_x_mck",	R9A07G044_MTU_X_MCK_MTU3, R9A07G044_CLK_P0,
+					0x538, 0),
 		DEF_MOD("wdt0_pclk",	R9A07G044_WDT0_PCLK, R9A07G044_CLK_P0,
 					0x548, 0),
 		DEF_MOD("wdt0_clk",	R9A07G044_WDT0_CLK, R9A07G044_OSCCLK,
@@ -297,6 +299,7 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_OSTM0_PRESETZ, 0x834, 0),
 	DEF_RST(R9A07G044_OSTM1_PRESETZ, 0x834, 1),
 	DEF_RST(R9A07G044_OSTM2_PRESETZ, 0x834, 2),
+	DEF_RST(R9A07G044_MTU_X_PRESET_MTU3, 0x838, 0),
 	DEF_RST(R9A07G044_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A07G044_WDT1_PRESETN, 0x848, 1),
 	DEF_RST(R9A07G044_WDT2_PRESETN, 0x848, 2),
-- 
2.25.1


