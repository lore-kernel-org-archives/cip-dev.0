Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819D8ECAAD4
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:47:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.1317.1661964430303215688
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:47:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="131240490"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 01:47:15 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6958840457D1;
	Thu,  1 Sep 2022 01:47:13 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 08/26] clk: renesas: r9a07g043: Add I2C
 clocks/resets
Date: Wed, 31 Aug 2022 17:46:27 +0100
Message-Id: <20220831164645.2134258-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:47:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9368

commit a9391e019015e96d4ed40587ce0f648edf1c32d3 upstream.

Add I2C{0,1,2,3} clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220425095244.156720-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 2d6c96789f5c..961216d55e0b 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -152,6 +152,14 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x57c, 1),
 	DEF_COUPLED("eth1_chi",	R9A07G043_ETH1_CLK_CHI, R9A07G043_CLK_ZT,
 				0x57c, 1),
+	DEF_MOD("i2c0",		R9A07G043_I2C0_PCLK, R9A07G043_CLK_P0,
+				0x580, 0),
+	DEF_MOD("i2c1",		R9A07G043_I2C1_PCLK, R9A07G043_CLK_P0,
+				0x580, 1),
+	DEF_MOD("i2c2",		R9A07G043_I2C2_PCLK, R9A07G043_CLK_P0,
+				0x580, 2),
+	DEF_MOD("i2c3",		R9A07G043_I2C3_PCLK, R9A07G043_CLK_P0,
+				0x580, 3),
 	DEF_MOD("scif0",	R9A07G043_SCIF0_CLK_PCK, R9A07G043_CLK_P0,
 				0x584, 0),
 	DEF_MOD("scif1",	R9A07G043_SCIF1_CLK_PCK, R9A07G043_CLK_P0,
@@ -180,6 +188,10 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_SDHI1_IXRST, 0x854, 1),
 	DEF_RST(R9A07G043_ETH0_RST_HW_N, 0x87c, 0),
 	DEF_RST(R9A07G043_ETH1_RST_HW_N, 0x87c, 1),
+	DEF_RST(R9A07G043_I2C0_MRST, 0x880, 0),
+	DEF_RST(R9A07G043_I2C1_MRST, 0x880, 1),
+	DEF_RST(R9A07G043_I2C2_MRST, 0x880, 2),
+	DEF_RST(R9A07G043_I2C3_MRST, 0x880, 3),
 	DEF_RST(R9A07G043_SCIF0_RST_SYSTEM_N, 0x884, 0),
 	DEF_RST(R9A07G043_SCIF1_RST_SYSTEM_N, 0x884, 1),
 	DEF_RST(R9A07G043_SCIF2_RST_SYSTEM_N, 0x884, 2),
-- 
2.25.1


