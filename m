Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC182C46CA0
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 10:55:35 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.81315.1701946517933410769
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 02:55:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="185659852"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2023 19:55:33 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1FE5A420A72E;
	Thu,  7 Dec 2023 19:55:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 10/12] clk: renesas: r9a07g044: Add GPT clock and reset entry
Date: Thu,  7 Dec 2023 10:55:06 +0000
Message-Id: <20231207105508.171162-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
References: <20231207105508.171162-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 10:55:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13822

commit 1fb7a9fb6295220eb96c490581316b35fce180fe upstream.

Add GPT clock and reset entry to CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220510110653.7326-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index ab546d57cb60..c61ff71b60eb 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -182,7 +182,7 @@ static const struct {
 };
 
 static const struct {
-	struct rzg2l_mod_clk common[70];
+	struct rzg2l_mod_clk common[71];
 #ifdef CONFIG_CLK_R9A07G054
 	struct rzg2l_mod_clk drp[0];
 #endif
@@ -206,6 +206,8 @@ static const struct {
 					0x534, 2),
 		DEF_MOD("mtu_x_mck",	R9A07G044_MTU_X_MCK_MTU3, R9A07G044_CLK_P0,
 					0x538, 0),
+		DEF_MOD("gpt_pclk",	R9A07G044_GPT_PCLK, R9A07G044_CLK_P0,
+					0x540, 0),
 		DEF_MOD("wdt0_pclk",	R9A07G044_WDT0_PCLK, R9A07G044_CLK_P0,
 					0x548, 0),
 		DEF_MOD("wdt0_clk",	R9A07G044_WDT0_CLK, R9A07G044_OSCCLK,
@@ -345,6 +347,7 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_OSTM1_PRESETZ, 0x834, 1),
 	DEF_RST(R9A07G044_OSTM2_PRESETZ, 0x834, 2),
 	DEF_RST(R9A07G044_MTU_X_PRESET_MTU3, 0x838, 0),
+	DEF_RST(R9A07G044_GPT_RST_C, 0x840, 0),
 	DEF_RST(R9A07G044_WDT0_PRESETN, 0x848, 0),
 	DEF_RST(R9A07G044_WDT1_PRESETN, 0x848, 1),
 	DEF_RST(R9A07G044_SPI_RST, 0x850, 0),
-- 
2.25.1


