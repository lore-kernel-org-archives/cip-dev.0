Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04947C433FE
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:51 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.30873.1641817453955248146
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:24:50 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106554316"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 21:24:49 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A241542AC9F7;
	Mon, 10 Jan 2022 21:24:48 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 59/61] clk: renesas: r9a07g044: Add GbEthernet
 clock/reset
Date: Mon, 10 Jan 2022 12:23:29 +0000
Message-Id: <20220110122331.24114-60-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7424

From: Biju Das <biju.das.jz@bp.renesas.com>

commit c11d7f5126b7c5da41f8fb7f69fc86fece65b2b3 upstream.

Add ETH{0,1} clock/reset entries to CPG driver.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210922155145.28156-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index ce2c40a0213a..3c518b56c5a6 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -138,6 +138,14 @@ static struct rzg2l_mod_clk r9a07g044_mod_clks[] = {
 				0x578, 2),
 	DEF_MOD("usb_pclk",	R9A07G044_USB_PCLK, R9A07G044_CLK_P1,
 				0x578, 3),
+	DEF_COUPLED("eth0_axi",	R9A07G044_ETH0_CLK_AXI, R9A07G044_CLK_M0,
+				0x57c, 0),
+	DEF_COUPLED("eth0_chi",	R9A07G044_ETH0_CLK_CHI, R9A07G044_CLK_ZT,
+				0x57c, 0),
+	DEF_COUPLED("eth1_axi",	R9A07G044_ETH1_CLK_AXI, R9A07G044_CLK_M0,
+				0x57c, 1),
+	DEF_COUPLED("eth1_chi",	R9A07G044_ETH1_CLK_CHI, R9A07G044_CLK_ZT,
+				0x57c, 1),
 	DEF_MOD("i2c0",		R9A07G044_I2C0_PCLK, R9A07G044_CLK_P0,
 				0x580, 0),
 	DEF_MOD("i2c1",		R9A07G044_I2C1_PCLK, R9A07G044_CLK_P0,
@@ -182,6 +190,8 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_USB_U2H1_HRESETN, 0x878, 1),
 	DEF_RST(R9A07G044_USB_U2P_EXL_SYSRST, 0x878, 2),
 	DEF_RST(R9A07G044_USB_PRESETN, 0x878, 3),
+	DEF_RST(R9A07G044_ETH0_RST_HW_N, 0x87c, 0),
+	DEF_RST(R9A07G044_ETH1_RST_HW_N, 0x87c, 1),
 	DEF_RST(R9A07G044_I2C0_MRST, 0x880, 0),
 	DEF_RST(R9A07G044_I2C1_MRST, 0x880, 1),
 	DEF_RST(R9A07G044_I2C2_MRST, 0x880, 2),
-- 
2.17.1


