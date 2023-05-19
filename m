Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE19C7EE2A
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:27 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.20929.1684484478558708880
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:18 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="163489757"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 May 2023 17:21:16 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 92205419E629;
	Fri, 19 May 2023 17:21:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 06/23] clk: renesas: r9a09g011: Add WDT clock and reset entries
Date: Fri, 19 May 2023 09:20:41 +0100
Message-Id: <20230519082058.109760-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11538

From: Phil Edworthy <phil.edworthy@renesas.com>

commit efded37b426f4e1b7b004b1e9924ff4bf16ec0fd upstream.

Add WDT0 clock and reset entries to CPG driver.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Link: https://lore.kernel.org/r/20220518150105.48167-1-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g011-cpg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g011-cpg.c b/drivers/clk/renesas/r9a09g011-cpg.c
index 0fae2cc8018f..7922d68a8c6e 100644
--- a/drivers/clk/renesas/r9a09g011-cpg.c
+++ b/drivers/clk/renesas/r9a09g011-cpg.c
@@ -150,6 +150,8 @@ static const struct rzg2l_mod_clk r9a09g011_mod_clks[] __initconst = {
 	DEF_MOD("tim_clk_21",	R9A09G011_TIM21_CLK,	 CLK_MAIN_2,   0x428, 9),
 	DEF_MOD("tim_clk_22",	R9A09G011_TIM22_CLK,	 CLK_MAIN_2,   0x428, 10),
 	DEF_MOD("tim_clk_23",	R9A09G011_TIM23_CLK,	 CLK_MAIN_2,   0x428, 11),
+	DEF_MOD("wdt0_pclk",	R9A09G011_WDT0_PCLK,	 CLK_SEL_E,    0x428, 12),
+	DEF_MOD("wdt0_clk",	R9A09G011_WDT0_CLK,	 CLK_MAIN,     0x428, 13),
 	DEF_MOD("urt_pclk",	R9A09G011_URT_PCLK,	 CLK_SEL_E,    0x438, 4),
 	DEF_MOD("urt0_clk",	R9A09G011_URT0_CLK,	 CLK_SEL_W0,   0x438, 5),
 	DEF_MOD("ca53",		R9A09G011_CA53_CLK,	 CLK_DIV_A,    0x448, 0),
@@ -161,6 +163,7 @@ static const struct rzg2l_reset r9a09g011_resets[] = {
 	DEF_RST_MON(R9A09G011_SYC_RST_N,	0x610, 9,  13),
 	DEF_RST(R9A09G011_TIM_GPB_PRESETN,	0x614, 1),
 	DEF_RST(R9A09G011_TIM_GPC_PRESETN,	0x614, 2),
+	DEF_RST_MON(R9A09G011_WDT0_PRESETN,	0x614, 12, 19),
 };
 
 static const unsigned int r9a09g011_crit_mod_clks[] __initconst = {
-- 
2.25.1


