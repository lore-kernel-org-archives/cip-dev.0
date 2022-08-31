Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D746ECAAD3
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:47:27 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.1254.1661964443153041755
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:47:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="131240501"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 01:47:25 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3A5D040457CD;
	Thu,  1 Sep 2022 01:47:22 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 11/26] clk: renesas: r9a07g043: Add clock and reset
 entries for CANFD
Date: Wed, 31 Aug 2022 17:46:30 +0100
Message-Id: <20220831164645.2134258-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:47:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9371

commit 1cbda37757ab5581a18214b62e83a914acfcf3e8 upstream.

Add clock and reset entries for CANFD in CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220425095244.156720-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index ea826f000d8d..59d5405474a5 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -100,6 +100,7 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 		CLK_DIVIDER_HIWORD_MASK),
 	DEF_DIV("P0", R9A07G043_CLK_P0, CLK_PLL2_DIV2_8, DIVPL2A,
 		dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
+	DEF_FIXED("P0_DIV2", R9A07G043_CLK_P0_DIV2, R9A07G043_CLK_P0, 1, 2),
 	DEF_DIV("P1", R9A07G043_CLK_P1, CLK_PLL3_DIV2_4,
 		DIVPL3B, dtable_1_32, CLK_DIVIDER_HIWORD_MASK),
 	DEF_FIXED("P1_DIV2", CLK_P1_DIV2, R9A07G043_CLK_P1, 1, 2),
@@ -198,6 +199,8 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x588, 0),
 	DEF_MOD("sci1",		R9A07G043_SCI1_CLKP, R9A07G043_CLK_P0,
 				0x588, 1),
+	DEF_MOD("canfd",	R9A07G043_CANFD_PCLK, R9A07G043_CLK_P0,
+				0x594, 0),
 	DEF_MOD("gpio",		R9A07G043_GPIO_HCLK, R9A07G043_OSCCLK,
 				0x598, 0),
 };
@@ -231,6 +234,8 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_SCIF4_RST_SYSTEM_N, 0x884, 4),
 	DEF_RST(R9A07G043_SCI0_RST, 0x888, 0),
 	DEF_RST(R9A07G043_SCI1_RST, 0x888, 1),
+	DEF_RST(R9A07G043_CANFD_RSTP_N, 0x894, 0),
+	DEF_RST(R9A07G043_CANFD_RSTC_N, 0x894, 1),
 	DEF_RST(R9A07G043_GPIO_RSTN, 0x898, 0),
 	DEF_RST(R9A07G043_GPIO_PORT_RESETN, 0x898, 1),
 	DEF_RST(R9A07G043_GPIO_SPARE_RESETN, 0x898, 2),
-- 
2.25.1


