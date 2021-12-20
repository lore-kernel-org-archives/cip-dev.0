Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8660AC433EF
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 13:31:52 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5236.1640007107229541697
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Dec 2021 05:31:52 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,220,1635174000";
   d="scan'208";a="104578463"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Dec 2021 22:31:51 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AB715400493F;
	Mon, 20 Dec 2021 22:31:50 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 08/22] clk: renesas: r9a07g044: Add I2C
 clocks/resets
Date: Mon, 20 Dec 2021 13:31:25 +0000
Message-Id: <20211220133139.21624-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 13:31:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7205

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 1962dd36db4ffe0411e3cb06f0797b7aacf0ca99 upstream.

Add I2C{0,1,2,3} clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210626081344.5783-9-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index ad3bc21d26c1..39658c315b32 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -90,6 +90,14 @@ static struct rzg2l_mod_clk r9a07g044_mod_clks[] = {
 				0x518, 0),
 	DEF_MOD("ia55_clk",	R9A07G044_IA55_CLK, R9A07G044_CLK_P1,
 				0x518, 1),
+	DEF_MOD("i2c0",		R9A07G044_I2C0_PCLK, R9A07G044_CLK_P0,
+				0x580, 0),
+	DEF_MOD("i2c1",		R9A07G044_I2C1_PCLK, R9A07G044_CLK_P0,
+				0x580, 1),
+	DEF_MOD("i2c2",		R9A07G044_I2C2_PCLK, R9A07G044_CLK_P0,
+				0x580, 2),
+	DEF_MOD("i2c3",		R9A07G044_I2C3_PCLK, R9A07G044_CLK_P0,
+				0x580, 3),
 	DEF_MOD("scif0",	R9A07G044_SCIF0_CLK_PCK, R9A07G044_CLK_P0,
 				0x584, 0),
 	DEF_MOD("scif1",	R9A07G044_SCIF1_CLK_PCK, R9A07G044_CLK_P0,
@@ -110,6 +118,10 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_GIC600_GICRESET_N, 0x814, 0),
 	DEF_RST(R9A07G044_GIC600_DBG_GICRESET_N, 0x814, 1),
 	DEF_RST(R9A07G044_IA55_RESETN, 0x818, 0),
+	DEF_RST(R9A07G044_I2C0_MRST, 0x880, 0),
+	DEF_RST(R9A07G044_I2C1_MRST, 0x880, 1),
+	DEF_RST(R9A07G044_I2C2_MRST, 0x880, 2),
+	DEF_RST(R9A07G044_I2C3_MRST, 0x880, 3),
 	DEF_RST(R9A07G044_SCIF0_RST_SYSTEM_N, 0x884, 0),
 	DEF_RST(R9A07G044_SCIF1_RST_SYSTEM_N, 0x884, 1),
 	DEF_RST(R9A07G044_SCIF2_RST_SYSTEM_N, 0x884, 2),
-- 
2.17.1


