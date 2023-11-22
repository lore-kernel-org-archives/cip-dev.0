Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9384BC61D97
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 14:28:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.20658.1700663304421656546
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Nov 2023 06:28:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,219,1695654000"; 
   d="scan'208";a="187743096"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Nov 2023 23:28:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.150])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5D0D84010DEB;
	Wed, 22 Nov 2023 23:28:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/11] clk: fixed: Remove Allwinner A10 special-case logic
Date: Wed, 22 Nov 2023 14:28:13 +0000
Message-Id: <20231122142819.203737-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
References: <20231122142819.203737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 14:28:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13617

From: Samuel Holland <samuel@sholland.org>

commit c33ed61249dc54e7cf2137c04462883560375b77 upstream.

This compatible is part of the legacy sunxi clock support, and has not
been used since commit 6b48644b1d29 ("ARM: gr8: Convert to CCU") in
October 2016. Since supporting this compatible adds some overhead to
generic clock code, let's clean it up.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Link: https://lore.kernel.org/r/20220531051742.43273-1-samuel@sholland.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-fixed-factor.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index b65f027dd40c..67229bfec4c0 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -203,16 +203,10 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor);
 
 #ifdef CONFIG_OF
-static const struct of_device_id set_rate_parent_matches[] = {
-	{ .compatible = "allwinner,sun4i-a10-pll3-2x-clk" },
-	{ /* Sentinel */ },
-};
-
 static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 {
 	struct clk_hw *hw;
 	const char *clk_name = node->name;
-	unsigned long flags = 0;
 	u32 div, mult;
 	int ret;
 
@@ -230,11 +224,8 @@ static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	if (of_match_node(set_rate_parent_matches, node))
-		flags |= CLK_SET_RATE_PARENT;
-
 	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, 0,
-					    flags, mult, div, false);
+					    0, mult, div, false);
 	if (IS_ERR(hw)) {
 		/*
 		 * Clear OF_POPULATED flag so that clock registration can be
-- 
2.25.1


