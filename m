Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA274C83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74848.1752487703025283258
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: 9dhFaOgnR7md153g2+3QXw==
X-CSE-MsgGUID: 487ioHqlQAil/eZM0Kr/vg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:35 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8FC5C41D4BDF;
	Mon, 14 Jul 2025 19:08:33 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 14/57] clk: renesas: rzv2h: Use str_on_off() helper in rzv2h_mod_clock_endisable()
Date: Mon, 14 Jul 2025 11:06:55 +0100
Message-ID: <20250714100802.80035-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19442

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit e6c2b4ed4906c9be9d522af75690dc570fdde5d4 upstream.

Replace hard-coded "ON"/"OFF" strings with the `str_on_off()` helper in
`rzv2h_mod_clock_endisable()`.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407165202.197570-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 1848aac6a4ca..99a26f893252 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -25,6 +25,7 @@
 #include <linux/pm_domain.h>
 #include <linux/refcount.h>
 #include <linux/reset-controller.h>
+#include <linux/string_choices.h>
 
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
 
@@ -592,7 +593,7 @@ static int rzv2h_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	int error;
 
 	dev_dbg(dev, "CLK_ON 0x%x/%pC %s\n", reg, hw->clk,
-		enable ? "ON" : "OFF");
+		str_on_off(enable));
 
 	if (enabled == enable)
 		return 0;
-- 
2.43.0


