Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65D2C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 12:55:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.10105.1639659291122281966
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 04:55:11 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,211,1635174000";
   d="scan'208";a="103722240"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Dec 2021 21:55:11 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 60576401225B;
	Thu, 16 Dec 2021 21:55:10 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 17/24] clk: renesas: rzg2l: Fix a double free on
 error
Date: Thu, 16 Dec 2021 12:54:39 +0000
Message-Id: <20211216125446.15451-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 12:55:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7140

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 36aaa3a0d9bc13e302dc146a20f022fb6891b605 upstream.

The "pll_clk" and "clock" pointers are allocated with devm_kzalloc() so
freeing them with kfree() will lead to a double free.  This would only
happen if probe failed, and the system is not bootable.

Fixes: ef3c613ccd68 ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/YMtYs7LVveYH4eRe@mwanda
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/renesas-rzg2l-cpg.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/renesas/renesas-rzg2l-cpg.c b/drivers/clk/renesas/renesas-rzg2l-cpg.c
index 0ce84a24198c..6808390f8ee0 100644
--- a/drivers/clk/renesas/renesas-rzg2l-cpg.c
+++ b/drivers/clk/renesas/renesas-rzg2l-cpg.c
@@ -175,7 +175,6 @@ rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 	struct clk_init_data init;
 	const char *parent_name;
 	struct pll_clk *pll_clk;
-	struct clk *clk;
 
 	parent = clks[core->parent & 0xffff];
 	if (IS_ERR(parent))
@@ -198,11 +197,7 @@ rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 	pll_clk->priv = priv;
 	pll_clk->type = core->type;
 
-	clk = clk_register(NULL, &pll_clk->hw);
-	if (IS_ERR(clk))
-		kfree(pll_clk);
-
-	return clk;
+	return clk_register(NULL, &pll_clk->hw);
 }
 
 static struct clk
@@ -471,7 +466,6 @@ rzg2l_cpg_register_mod_clk(const struct rzg2l_mod_clk *mod,
 fail:
 	dev_err(dev, "Failed to register %s clock %s: %ld\n", "module",
 		mod->name, PTR_ERR(clk));
-	kfree(clock);
 }
 
 #define rcdev_to_priv(x)	container_of(x, struct rzg2l_cpg_priv, rcdev)
-- 
2.17.1


