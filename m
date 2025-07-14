Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8A8C83F21
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74839.1752487690444208022
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: ZJ97NLbyQ6qY6oCoOo8KwQ==
X-CSE-MsgGUID: Lf4NOqPSQmOJB32WtNQgig==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:09 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5E85941D45A9;
	Mon, 14 Jul 2025 19:08:08 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 02/57] clk: renesas: rzv2h: Update error message
Date: Mon, 14 Jul 2025 11:06:43 +0100
Message-ID: <20250714100802.80035-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19430

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 43961f7ee3f31c97209157bd19420ea8a65b1181 upstream.

Update the error message in `rzv2h_mod_clock_endisable()` to provide
clearer debugging information. Instead of printing only the register
address, include both the `GET_CLK_ON_OFFSET(reg)` offset and the
corresponding `clk` name (`%pC`). This enhances readability and aids
in debugging clock enable failures.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250211105603.195905-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 28473bfa3971..6853db08e8e5 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -542,8 +542,8 @@ static int rzv2h_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	error = readl_poll_timeout_atomic(priv->base + reg, value,
 					  value & bitmask, 0, 10);
 	if (error)
-		dev_err(dev, "Failed to enable CLK_ON %p\n",
-			priv->base + reg);
+		dev_err(dev, "Failed to enable CLK_ON 0x%x/%pC\n",
+			GET_CLK_ON_OFFSET(clock->on_index), hw->clk);
 
 	return error;
 }
-- 
2.43.0


