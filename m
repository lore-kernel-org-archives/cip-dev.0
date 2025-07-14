Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C859C83F1A
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74767.1752487694931488184
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: V7yN4qy6Tt6JH9tRDTascw==
X-CSE-MsgGUID: RXPEbxUFRGmf8to5uMqhCg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:18 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B7F6841D4BDE;
	Mon, 14 Jul 2025 19:08:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 06/57] clk: renesas: rzv2h: Improve rzv2h_ddiv_set_rate()
Date: Mon, 14 Jul 2025 11:06:47 +0100
Message-ID: <20250714100802.80035-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19434

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

commit ce0a97ff7127312aaee137fcdb159d8ddd14ede4 upstream.

Remove duplicate code into rzv2h_ddiv_set_rate().

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/cip-dev/Z9QBZo4GgtMjid0v@duo.ucw.cz/
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250317083213.371614-3-tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 3a61365263b7..8800d54ede4f 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -329,12 +329,6 @@ static int rzv2h_ddiv_set_rate(struct clk_hw *hw, unsigned long rate,
 	writel(val, divider->reg);
 
 	ret = rzv2h_cpg_wait_ddiv_clk_update_done(priv->base, ddiv->mon);
-	if (ret)
-		goto ddiv_timeout;
-
-	spin_unlock_irqrestore(divider->lock, flags);
-
-	return 0;
 
 ddiv_timeout:
 	spin_unlock_irqrestore(divider->lock, flags);
-- 
2.43.0


