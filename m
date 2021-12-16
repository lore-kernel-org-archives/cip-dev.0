Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E0EC433FE
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 12:55:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.10105.1639659291122281966
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 04:55:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,211,1635174000";
   d="scan'208";a="103722237"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Dec 2021 21:55:10 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 16A414012258;
	Thu, 16 Dec 2021 21:55:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 16/24] clk: renesas: rzg2l: Fix return value and
 unused assignment
Date: Thu, 16 Dec 2021 12:54:38 +0000
Message-Id: <20211216125446.15451-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 12:55:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7139

From: Yang Li <yang.lee@linux.alibaba.com>

commit 97c29755598f98c6c91f68f12bdd3f517e457890 upstream.

Currently the function returns NULL on error, so exact error code is
lost.  This patch changes return convention of the function to use
ERR_PTR() on error instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Link: https://lore.kernel.org/r/1623896524-102058-1-git-send-email-yang.lee@linux.alibaba.com
[geert: Drop curly braces]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/renesas-rzg2l-cpg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/renesas-rzg2l-cpg.c b/drivers/clk/renesas/renesas-rzg2l-cpg.c
index a0bb8b20797d..0ce84a24198c 100644
--- a/drivers/clk/renesas/renesas-rzg2l-cpg.c
+++ b/drivers/clk/renesas/renesas-rzg2l-cpg.c
@@ -182,10 +182,8 @@ rzg2l_cpg_pll_clk_register(const struct cpg_core_clk *core,
 		return ERR_CAST(parent);
 
 	pll_clk = devm_kzalloc(dev, sizeof(*pll_clk), GFP_KERNEL);
-	if (!pll_clk) {
-		clk = ERR_PTR(-ENOMEM);
-		return NULL;
-	}
+	if (!pll_clk)
+		return ERR_PTR(-ENOMEM);
 
 	parent_name = __clk_get_name(parent);
 	init.name = core->name;
-- 
2.17.1


