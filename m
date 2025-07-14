Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB030C83F22
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:29 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74848.1752487703025283258
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: DOFDIYxURL+gFJC1+MV+dA==
X-CSE-MsgGUID: oQwoVs0fT9STmMZmAZePvA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:22 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id EFF9441D45A9;
	Mon, 14 Jul 2025 19:08:20 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 08/57] clk: renesas: rzv2h: Sort compatible list based on SoC part number
Date: Mon, 14 Jul 2025 11:06:49 +0100
Message-ID: <20250714100802.80035-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19436

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c3400fd7c717e752701e6832175f86ff935b812b upstream.

Reorder the compatible entries in `rzv2h_cpg_match[]` to follow a
numerical sequence based on the SoC part numbers.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407191628.323613-8-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index ff9d81e71704..99877fc65156 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -1014,17 +1014,17 @@ static int __init rzv2h_cpg_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rzv2h_cpg_match[] = {
-#ifdef CONFIG_CLK_R9A09G057
-	{
-		.compatible = "renesas,r9a09g057-cpg",
-		.data = &r9a09g057_cpg_info,
-	},
-#endif
 #ifdef CONFIG_CLK_R9A09G047
 	{
 		.compatible = "renesas,r9a09g047-cpg",
 		.data = &r9a09g047_cpg_info,
 	},
+#endif
+#ifdef CONFIG_CLK_R9A09G057
+	{
+		.compatible = "renesas,r9a09g057-cpg",
+		.data = &r9a09g057_cpg_info,
+	},
 #endif
 	{ /* sentinel */ }
 };
-- 
2.43.0


