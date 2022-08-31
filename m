Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AA2C3DA6B
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:47:27 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.1238.1661964439509252072
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:47:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="133251664"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2022 01:47:18 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 73FA240457D1;
	Thu,  1 Sep 2022 01:47:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/26] clk: renesas: r9a07g043: Add SSIF-2 clock
 and reset entries
Date: Wed, 31 Aug 2022 17:46:28 +0100
Message-Id: <20220831164645.2134258-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:47:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9369

commit be5b5fcbc779f04a6ad38e9d4772712fe05b6f15 upstream.

Add SSIF-2{0,1,2,3} clock and reset entries in CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220425095244.156720-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 961216d55e0b..d54bccf7b61b 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -144,6 +144,22 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x554, 6),
 	DEF_MOD("sdhi1_aclk",	R9A07G043_SDHI1_ACLK, R9A07G043_CLK_P1,
 				0x554, 7),
+	DEF_MOD("ssi0_pclk",	R9A07G043_SSI0_PCLK2, R9A07G043_CLK_P0,
+				0x570, 0),
+	DEF_MOD("ssi0_sfr",	R9A07G043_SSI0_PCLK_SFR, R9A07G043_CLK_P0,
+				0x570, 1),
+	DEF_MOD("ssi1_pclk",	R9A07G043_SSI1_PCLK2, R9A07G043_CLK_P0,
+				0x570, 2),
+	DEF_MOD("ssi1_sfr",	R9A07G043_SSI1_PCLK_SFR, R9A07G043_CLK_P0,
+				0x570, 3),
+	DEF_MOD("ssi2_pclk",	R9A07G043_SSI2_PCLK2, R9A07G043_CLK_P0,
+				0x570, 4),
+	DEF_MOD("ssi2_sfr",	R9A07G043_SSI2_PCLK_SFR, R9A07G043_CLK_P0,
+				0x570, 5),
+	DEF_MOD("ssi3_pclk",	R9A07G043_SSI3_PCLK2, R9A07G043_CLK_P0,
+				0x570, 6),
+	DEF_MOD("ssi3_sfr",	R9A07G043_SSI3_PCLK_SFR, R9A07G043_CLK_P0,
+				0x570, 7),
 	DEF_COUPLED("eth0_axi",	R9A07G043_ETH0_CLK_AXI, R9A07G043_CLK_M0,
 				0x57c, 0),
 	DEF_COUPLED("eth0_chi",	R9A07G043_ETH0_CLK_CHI, R9A07G043_CLK_ZT,
@@ -186,6 +202,10 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_DMAC_RST_ASYNC, 0x82c, 1),
 	DEF_RST(R9A07G043_SDHI0_IXRST, 0x854, 0),
 	DEF_RST(R9A07G043_SDHI1_IXRST, 0x854, 1),
+	DEF_RST(R9A07G043_SSI0_RST_M2_REG, 0x870, 0),
+	DEF_RST(R9A07G043_SSI1_RST_M2_REG, 0x870, 1),
+	DEF_RST(R9A07G043_SSI2_RST_M2_REG, 0x870, 2),
+	DEF_RST(R9A07G043_SSI3_RST_M2_REG, 0x870, 3),
 	DEF_RST(R9A07G043_ETH0_RST_HW_N, 0x87c, 0),
 	DEF_RST(R9A07G043_ETH1_RST_HW_N, 0x87c, 1),
 	DEF_RST(R9A07G043_I2C0_MRST, 0x880, 0),
-- 
2.25.1


