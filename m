Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03933C6FA85
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:44:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.4674.1662111876828858051
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:44:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="131460926"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Sep 2022 18:44:36 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 14F28400A11F;
	Fri,  2 Sep 2022 18:44:33 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/25] clk: renesas: r9a07g043: Add RSPI clock and
 reset entries
Date: Fri,  2 Sep 2022 10:44:04 +0100
Message-Id: <20220902094427.116227-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:44:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9428

commit 14d8857d8266bce49dc4ee0d71e6cd79335d7c8c upstream.

Add RSPI{0,1,2} clock and reset entries to CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220501083450.26541-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 57b9eb9e0d2b..21cf82ad7de3 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -230,6 +230,12 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x588, 0),
 	DEF_MOD("sci1",		R9A07G043_SCI1_CLKP, R9A07G043_CLK_P0,
 				0x588, 1),
+	DEF_MOD("rspi0",	R9A07G043_RSPI0_CLKB, R9A07G043_CLK_P0,
+				0x590, 0),
+	DEF_MOD("rspi1",	R9A07G043_RSPI1_CLKB, R9A07G043_CLK_P0,
+				0x590, 1),
+	DEF_MOD("rspi2",	R9A07G043_RSPI2_CLKB, R9A07G043_CLK_P0,
+				0x590, 2),
 	DEF_MOD("canfd",	R9A07G043_CANFD_PCLK, R9A07G043_CLK_P0,
 				0x594, 0),
 	DEF_MOD("gpio",		R9A07G043_GPIO_HCLK, R9A07G043_OSCCLK,
@@ -271,6 +277,9 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_SCIF4_RST_SYSTEM_N, 0x884, 4),
 	DEF_RST(R9A07G043_SCI0_RST, 0x888, 0),
 	DEF_RST(R9A07G043_SCI1_RST, 0x888, 1),
+	DEF_RST(R9A07G043_RSPI0_RST, 0x890, 0),
+	DEF_RST(R9A07G043_RSPI1_RST, 0x890, 1),
+	DEF_RST(R9A07G043_RSPI2_RST, 0x890, 2),
 	DEF_RST(R9A07G043_CANFD_RSTP_N, 0x894, 0),
 	DEF_RST(R9A07G043_CANFD_RSTC_N, 0x894, 1),
 	DEF_RST(R9A07G043_GPIO_RSTN, 0x898, 0),
-- 
2.25.1


