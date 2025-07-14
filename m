Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DEAC83F2A
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:08:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.74839.1752487690444208022
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:08:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: 7qHULX0yQSSNbY17PdCAVw==
X-CSE-MsgGUID: gMa7mfhaQu6o4y6ro+u3jg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:08:11 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6EBB541D45A9;
	Mon, 14 Jul 2025 19:08:10 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 03/57] clk: renesas: rzv2h: Remove unused `type` field from `struct pll_clk`
Date: Mon, 14 Jul 2025 11:06:44 +0100
Message-ID: <20250714100802.80035-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:08:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19431

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 18510fd7bfe66218a07024fb9f2a204e0f623794 upstream.

Remove the redundant `type` field from `struct pll_clk`, as it is not used
in the PLL clock handling logic.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250309211402.80886-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 6853db08e8e5..3eb0f7d5c19a 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -97,7 +97,6 @@ struct pll_clk {
 	void __iomem *base;
 	struct clk_hw hw;
 	struct pll pll;
-	unsigned int type;
 };
 
 #define to_pll(_hw)	container_of(_hw, struct pll_clk, hw)
@@ -199,7 +198,6 @@ rzv2h_cpg_pll_clk_register(const struct cpg_core_clk *core,
 	pll_clk->pll = core->cfg.pll;
 	pll_clk->base = base;
 	pll_clk->priv = priv;
-	pll_clk->type = core->type;
 
 	ret = devm_clk_hw_register(dev, &pll_clk->hw);
 	if (ret)
-- 
2.43.0


