Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF3C7EE26
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:47 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.20942.1684484501476517633
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="163489811"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 May 2023 17:21:40 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 011BF419EC47;
	Fri, 19 May 2023 17:21:38 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 15/23] clk: renesas: r9a09g011: Add IIC clock and reset entries
Date: Fri, 19 May 2023 09:20:50 +0100
Message-Id: <20230519082058.109760-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11547

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 425e9e04ae5d94fd140f48b1e1bd1c4e4de533e9 upstream.

Add IIC groups clock and reset entries to CPG driver.
IIC Group A consists of IIC0 and IIC1. IIC Group B consists of
IIC2 and IIC3. To confuse things, IIC_PCLK0 is used by group A
and IIC_PCLK1 is used by group B.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Link: https://lore.kernel.org/r/20220819193944.337599-2-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g011-cpg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g011-cpg.c b/drivers/clk/renesas/r9a09g011-cpg.c
index 7922d68a8c6e..4dfc4e10107a 100644
--- a/drivers/clk/renesas/r9a09g011-cpg.c
+++ b/drivers/clk/renesas/r9a09g011-cpg.c
@@ -132,6 +132,7 @@ static const struct rzg2l_mod_clk r9a09g011_mod_clks[] __initconst = {
 	DEF_COUPLED("eth_chi",	R9A09G011_ETH0_CLK_CHI,	 CLK_PLL2_100, 0x40c, 8),
 	DEF_MOD("eth_clk_gptp",	R9A09G011_ETH0_GPTP_EXT, CLK_PLL2_100, 0x40c, 9),
 	DEF_MOD("syc_cnt_clk",	R9A09G011_SYC_CNT_CLK,	 CLK_MAIN_24,  0x41c, 12),
+	DEF_MOD("iic_pclk0",	R9A09G011_IIC_PCLK0,	 CLK_SEL_E,    0x420, 12),
 	DEF_MOD("cperi_grpb",	R9A09G011_CPERI_GRPB_PCLK, CLK_SEL_E,  0x424, 0),
 	DEF_MOD("tim_clk_8",	R9A09G011_TIM8_CLK,	 CLK_MAIN_2,   0x424, 4),
 	DEF_MOD("tim_clk_9",	R9A09G011_TIM9_CLK,	 CLK_MAIN_2,   0x424, 5),
@@ -141,6 +142,7 @@ static const struct rzg2l_mod_clk r9a09g011_mod_clks[] __initconst = {
 	DEF_MOD("tim_clk_13",	R9A09G011_TIM13_CLK,	 CLK_MAIN_2,   0x424, 9),
 	DEF_MOD("tim_clk_14",	R9A09G011_TIM14_CLK,	 CLK_MAIN_2,   0x424, 10),
 	DEF_MOD("tim_clk_15",	R9A09G011_TIM15_CLK,	 CLK_MAIN_2,   0x424, 11),
+	DEF_MOD("iic_pclk1",	R9A09G011_IIC_PCLK1,	 CLK_SEL_E,    0x424, 12),
 	DEF_MOD("cperi_grpc",	R9A09G011_CPERI_GRPC_PCLK, CLK_SEL_E,  0x428, 0),
 	DEF_MOD("tim_clk_16",	R9A09G011_TIM16_CLK,	 CLK_MAIN_2,   0x428, 4),
 	DEF_MOD("tim_clk_17",	R9A09G011_TIM17_CLK,	 CLK_MAIN_2,   0x428, 5),
@@ -163,6 +165,8 @@ static const struct rzg2l_reset r9a09g011_resets[] = {
 	DEF_RST_MON(R9A09G011_SYC_RST_N,	0x610, 9,  13),
 	DEF_RST(R9A09G011_TIM_GPB_PRESETN,	0x614, 1),
 	DEF_RST(R9A09G011_TIM_GPC_PRESETN,	0x614, 2),
+	DEF_RST(R9A09G011_IIC_GPA_PRESETN,	0x614, 8),
+	DEF_RST(R9A09G011_IIC_GPB_PRESETN,	0x614, 9),
 	DEF_RST_MON(R9A09G011_WDT0_PRESETN,	0x614, 12, 19),
 };
 
-- 
2.25.1


