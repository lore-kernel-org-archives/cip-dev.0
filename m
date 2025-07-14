Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D33EC83F21
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:17:10 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74994.1752488220107045642
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:17:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: yZ9q2UcWQBqqriFNPuH2Lg==
X-CSE-MsgGUID: 7/zKxpBcSc6usN9OI419yA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:17:09 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5A8E8400D4C7;
	Mon, 14 Jul 2025 19:17:08 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 08/36] clk: renesas: rzv2h: Sort compatible list based on SoC part number
Date: Mon, 14 Jul 2025 11:16:08 +0100
Message-ID: <20250714101650.80381-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:17:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19494

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
index 81aed6ba76372..7962466cd51ba 100644
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


