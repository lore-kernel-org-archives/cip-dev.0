Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D720CA0EDC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:20 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.15332.1755679615607846173
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:47:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: ifOUv1ebRlWUh5OhuwKtVQ==
X-CSE-MsgGUID: d6S5YLywQ0+h6vkgwwc+ng==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:47:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 59CC4400B524;
	Wed, 20 Aug 2025 17:47:12 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/23] clk: renesas: rzv2h: Drop redundant base pointer from pll_clk
Date: Wed, 20 Aug 2025 09:45:55 +0100
Message-ID: <20250820084645.6988-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:47:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19804

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8250a8a9b10f459a40460104e6d6064c98283d1e upstream.

The base address can be accessed via the priv pointer already present in
struct pll_clk, making the separate base field redundant. Remove the base
member and its assignment.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250624153049.462535-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 47b1f1e0cae86..54330e6c526b9 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -101,7 +101,6 @@ struct rzv2h_cpg_priv {
 
 struct pll_clk {
 	struct rzv2h_cpg_priv *priv;
-	void __iomem *base;
 	struct clk_hw hw;
 	struct pll pll;
 };
@@ -230,7 +229,6 @@ rzv2h_cpg_pll_clk_register(const struct cpg_core_clk *core,
 			   struct rzv2h_cpg_priv *priv,
 			   const struct clk_ops *ops)
 {
-	void __iomem *base = priv->base;
 	struct device *dev = priv->dev;
 	struct clk_init_data init;
 	const struct clk *parent;
@@ -255,7 +253,6 @@ rzv2h_cpg_pll_clk_register(const struct cpg_core_clk *core,
 
 	pll_clk->hw.init = &init;
 	pll_clk->pll = core->cfg.pll;
-	pll_clk->base = base;
 	pll_clk->priv = priv;
 
 	ret = devm_clk_hw_register(dev, &pll_clk->hw);
-- 
2.43.0


