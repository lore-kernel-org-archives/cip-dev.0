Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A7CC83F1A
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.74854.1752487713503831357
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: W4EKUUTITzyrUYwztEtqOw==
X-CSE-MsgGUID: A3Vp2JQgRIe2Ucc0FTFkQA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:37 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B3AD241D45A9;
	Mon, 14 Jul 2025 19:08:35 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 15/57] clk: renesas: rzv2h: Use both CLK_ON and CLK_MON bits for clock state validation
Date: Mon, 14 Jul 2025 11:06:56 +0100
Message-ID: <20250714100802.80035-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19443

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ef224dd26ca3554ba810996710bcf671bc1c6be9 upstream.

Update the clock enable/disable logic to follow the latest hardware
manual's guidelines, ensuring that both CLK_ON and CLK_MON bits are used
to confirm the clock state.

According to the manual, enabling a clock requires setting the
CPG_CLK_ON bit and verifying the clock has started using the CPG_CLK_MON
bit.  Similarly, disabling a clock requires clearing the CPG_CLK_ON bit
and confirming the clock has stopped via the CPG_CLK_MON bit.

Modify `rzv2h_mod_clock_is_enabled()` to check CLK_MON first and then
validate CLK_ON for a more accurate clock status evaluation.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407165202.197570-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 99a26f893252..a3d680ab89b6 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -573,11 +573,14 @@ static int rzv2h_mod_clock_is_enabled(struct clk_hw *hw)
 	if (clock->mon_index >= 0) {
 		offset = GET_CLK_MON_OFFSET(clock->mon_index);
 		bitmask = BIT(clock->mon_bit);
-	} else {
-		offset = GET_CLK_ON_OFFSET(clock->on_index);
-		bitmask = BIT(clock->on_bit);
+
+		if (!(readl(priv->base + offset) & bitmask))
+			return 0;
 	}
 
+	offset = GET_CLK_ON_OFFSET(clock->on_index);
+	bitmask = BIT(clock->on_bit);
+
 	return readl(priv->base + offset) & bitmask;
 }
 
-- 
2.43.0


