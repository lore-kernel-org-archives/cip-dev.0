Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC217C433EF
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 13:31:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.5196.1640007103306700648
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Dec 2021 05:31:44 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,220,1635174000";
   d="scan'208";a="104578451"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Dec 2021 22:31:43 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B1CD840001CB;
	Mon, 20 Dec 2021 22:31:42 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/22] clk: renesas: r9a07g044: Add GPIO clock and
 reset entries
Date: Mon, 20 Dec 2021 13:31:19 +0000
Message-Id: <20211220133139.21624-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211220133139.21624-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 13:31:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7198

commit d85b82f09a03c2e1f06da740c6c47dd098b16ca5 upstream.

Add GPIO clock and reset entries in CPG driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20210712194422.12405-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a07g044-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index fb8e199c7409..ad3bc21d26c1 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -102,6 +102,8 @@ static struct rzg2l_mod_clk r9a07g044_mod_clks[] = {
 				0x584, 4),
 	DEF_MOD("sci0",		R9A07G044_SCI0_CLKP, R9A07G044_CLK_P0,
 				0x588, 0),
+	DEF_MOD("gpio",		R9A07G044_GPIO_HCLK, R9A07G044_OSCCLK,
+				0x598, 0),
 };
 
 static struct rzg2l_reset r9a07g044_resets[] = {
@@ -114,6 +116,9 @@ static struct rzg2l_reset r9a07g044_resets[] = {
 	DEF_RST(R9A07G044_SCIF3_RST_SYSTEM_N, 0x884, 3),
 	DEF_RST(R9A07G044_SCIF4_RST_SYSTEM_N, 0x884, 4),
 	DEF_RST(R9A07G044_SCI0_RST, 0x888, 0),
+	DEF_RST(R9A07G044_GPIO_RSTN, 0x898, 0),
+	DEF_RST(R9A07G044_GPIO_PORT_RESETN, 0x898, 1),
+	DEF_RST(R9A07G044_GPIO_SPARE_RESETN, 0x898, 2),
 };
 
 static const unsigned int r9a07g044_crit_mod_clks[] __initconst = {
-- 
2.17.1


