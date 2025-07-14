Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57E0C83F1B
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:17:00 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.74897.1752488214061695340
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:16:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: gd1FowjZTw+wEGmJfxgGYw==
X-CSE-MsgGUID: vvAVm6ICTW6ISWFnitvuWA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jul 2025 19:16:55 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CE6B1400CEEA;
	Mon, 14 Jul 2025 19:16:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 01/36] clk: renesas: rzv2h: Adjust for CPG_BUS_m_MSTOP starting from m = 1
Date: Mon, 14 Jul 2025 11:16:01 +0100
Message-ID: <20250714101650.80381-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
References: <20250714101650.80381-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:17:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19487

commit 69ac2acd209a15bd7a61a15c9532a5b505252e1c upstream.

Avoid using the "- 1" for finding mstop_index in all functions accessing
priv->mstop_count, by adjusting its pointer in rzv2h_cpg_probe().

While at it, drop the intermediate local variable index.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/all/CAMuHMdX1gPNCFddg_DyK7Bv0BeFLOLi=5eteT_HhMH=Ph2wVvA@mail.gmail.com/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250222142009.41324-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 54ed7a75be6e9..7e85bfde46dcd 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -450,8 +450,7 @@ static void rzv2h_mod_clock_mstop_enable(struct rzv2h_cpg_priv *priv,
 {
 	unsigned long mstop_mask = FIELD_GET(BUS_MSTOP_BITS_MASK, mstop_data);
 	u16 mstop_index = FIELD_GET(BUS_MSTOP_IDX_MASK, mstop_data);
-	unsigned int index = (mstop_index - 1) * 16;
-	atomic_t *mstop = &priv->mstop_count[index];
+	atomic_t *mstop = &priv->mstop_count[mstop_index * 16];
 	unsigned long flags;
 	unsigned int i;
 	u32 val = 0;
@@ -472,8 +471,7 @@ static void rzv2h_mod_clock_mstop_disable(struct rzv2h_cpg_priv *priv,
 {
 	unsigned long mstop_mask = FIELD_GET(BUS_MSTOP_BITS_MASK, mstop_data);
 	u16 mstop_index = FIELD_GET(BUS_MSTOP_IDX_MASK, mstop_data);
-	unsigned int index = (mstop_index - 1) * 16;
-	atomic_t *mstop = &priv->mstop_count[index];
+	atomic_t *mstop = &priv->mstop_count[mstop_index * 16];
 	unsigned long flags;
 	unsigned int i;
 	u32 val = 0;
@@ -633,8 +631,7 @@ rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk *mod,
 	} else if (clock->mstop_data != BUS_MSTOP_NONE && mod->critical) {
 		unsigned long mstop_mask = FIELD_GET(BUS_MSTOP_BITS_MASK, clock->mstop_data);
 		u16 mstop_index = FIELD_GET(BUS_MSTOP_IDX_MASK, clock->mstop_data);
-		unsigned int index = (mstop_index - 1) * 16;
-		atomic_t *mstop = &priv->mstop_count[index];
+		atomic_t *mstop = &priv->mstop_count[mstop_index * 16];
 		unsigned long flags;
 		unsigned int i;
 		u32 val = 0;
@@ -929,6 +926,9 @@ static int __init rzv2h_cpg_probe(struct platform_device *pdev)
 	if (!priv->mstop_count)
 		return -ENOMEM;
 
+	/* Adjust for CPG_BUS_m_MSTOP starting from m = 1 */
+	priv->mstop_count -= 16;
+
 	priv->resets = devm_kmemdup(dev, info->resets, sizeof(*info->resets) *
 				    info->num_resets, GFP_KERNEL);
 	if (!priv->resets)
-- 
2.43.0


