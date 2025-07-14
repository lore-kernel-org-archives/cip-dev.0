Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFEBC83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74767.1752487694931488184
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:20 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: oqTMfgQvR8CwuVz9kPH08A==
X-CSE-MsgGUID: qz4yQtgnSWmS9KgUizE90w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:20 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D926041D45A9;
	Mon, 14 Jul 2025 19:08:18 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 07/57] clk: renesas: rzv2h: Simplify rzv2h_cpg_assert()/rzv2h_cpg_deassert()
Date: Mon, 14 Jul 2025 11:06:48 +0100
Message-ID: <20250714100802.80035-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19435

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

commit b224c42568bc4e0d99bb4735c66123202e8b0e7f upstream.

rzv2h_cpg_assert() and rzv2h_cpg_deassert() functions are similar. Share
this code via __rzv2h_cpg_assert(). This avoid code duplication.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/cip-dev/Z9QA9rwuXCuVbOXp@duo.ucw.cz/
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250317083213.371614-4-tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 34 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 8800d54ede4f..ff9d81e71704 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -709,8 +709,8 @@ rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk *mod,
 		mod->name, PTR_ERR(clk));
 }
 
-static int rzv2h_cpg_assert(struct reset_controller_dev *rcdev,
-			    unsigned long id)
+static int __rzv2h_cpg_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id, bool assert)
 {
 	struct rzv2h_cpg_priv *priv = rcdev_to_priv(rcdev);
 	unsigned int reg = GET_RST_OFFSET(priv->resets[id].reset_index);
@@ -718,35 +718,31 @@ static int rzv2h_cpg_assert(struct reset_controller_dev *rcdev,
 	u8 monbit = priv->resets[id].mon_bit;
 	u32 value = mask << 16;
 
-	dev_dbg(rcdev->dev, "assert id:%ld offset:0x%x\n", id, reg);
+	dev_dbg(rcdev->dev, "%s id:%ld offset:0x%x\n",
+		assert ? "assert" : "deassert", id, reg);
 
+	if (!assert)
+		value |= mask;
 	writel(value, priv->base + reg);
 
 	reg = GET_RST_MON_OFFSET(priv->resets[id].mon_index);
 	mask = BIT(monbit);
 
 	return readl_poll_timeout_atomic(priv->base + reg, value,
-					 value & mask, 10, 200);
+					 assert ? (value & mask) : !(value & mask),
+					 10, 200);
+}
+
+static int rzv2h_cpg_assert(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	return __rzv2h_cpg_assert(rcdev, id, true);
 }
 
 static int rzv2h_cpg_deassert(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
-	struct rzv2h_cpg_priv *priv = rcdev_to_priv(rcdev);
-	unsigned int reg = GET_RST_OFFSET(priv->resets[id].reset_index);
-	u32 mask = BIT(priv->resets[id].reset_bit);
-	u8 monbit = priv->resets[id].mon_bit;
-	u32 value = (mask << 16) | mask;
-
-	dev_dbg(rcdev->dev, "deassert id:%ld offset:0x%x\n", id, reg);
-
-	writel(value, priv->base + reg);
-
-	reg = GET_RST_MON_OFFSET(priv->resets[id].mon_index);
-	mask = BIT(monbit);
-
-	return readl_poll_timeout_atomic(priv->base + reg, value,
-					 !(value & mask), 10, 200);
+	return __rzv2h_cpg_assert(rcdev, id, false);
 }
 
 static int rzv2h_cpg_reset(struct reset_controller_dev *rcdev,
-- 
2.43.0


