Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D79EE3F16
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 19:59:35 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.448.1694548760878224845
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 12:59:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,141,1688396400"; 
   d="scan'208";a="175845692"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Sep 2023 04:59:26 +0900
Received: from localhost.localdomain (unknown [10.226.93.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4E72940A488A;
	Wed, 13 Sep 2023 04:59:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 03/15] clk: renesas: r9a07g043: Add MTU3a clock and reset entry
Date: Tue, 12 Sep 2023 20:59:03 +0100
Message-Id: <20230912195915.607664-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
References: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 19:59:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13077

commit 2fd3f06b527e6ffaa929129a267386961e20a86c upstream.

Add MTU3a clock and reset entry to CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230714075649.146978-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 99f72bf590fa..1a7a6d60aca4 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -154,6 +154,8 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x534, 1),
 	DEF_MOD("ostm2_pclk",	R9A07G043_OSTM2_PCLK, R9A07G043_CLK_P0,
 				0x534, 2),
+	DEF_MOD("mtu_x_mck",	R9A07G043_MTU_X_MCK_MTU3, R9A07G043_CLK_P0,
+				0x538, 0),
 	DEF_MOD("wdt0_pclk",	R9A07G043_WDT0_PCLK, R9A07G043_CLK_P0,
 				0x548, 0),
 	DEF_MOD("wdt0_clk",	R9A07G043_WDT0_CLK, R9A07G043_OSCCLK,
@@ -264,6 +266,7 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_OSTM0_PRESETZ, 0x834, 0),
 	DEF_RST(R9A07G043_OSTM1_PRESETZ, 0x834, 1),
 	DEF_RST(R9A07G043_OSTM2_PRESETZ, 0x834, 2),
+	DEF_RST(R9A07G043_MTU_X_PRESET_MTU3, 0x838, 0),
 	DEF_RST(R9A07G043_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A07G043_SPI_RST, 0x850, 0),
 	DEF_RST(R9A07G043_SDHI0_IXRST, 0x854, 0),
-- 
2.25.1


