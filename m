Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA37C433F5
	for <webhook@archiver.kernel.org>; Wed, 30 Mar 2022 18:55:36 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.2184.1648666535724720346
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Mar 2022 11:55:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,223,1643641200";
   d="scan'208";a="116211135"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 31 Mar 2022 03:55:35 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 32C0540D4D0B;
	Thu, 31 Mar 2022 03:55:34 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 29/39] clk: renesas: rzg2l: propagate return value
 of_genpd_add_provider_simple()
Date: Wed, 30 Mar 2022 19:54:44 +0100
Message-Id: <20220330185454.10887-30-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220330185454.10887-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Mar 2022 18:55:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7880

commit 33748744f15a110a233b6ae0380f476006e770f0  upstream.

of_genpd_add_provider_simple() might fail, this patch makes sure we check
the return value of of_genpd_add_provider_simple() by propagating the
return value to the caller of rzg2l_cpg_add_clk_domain().

Fixes: ef3c613ccd68a ("clk: renesas: Add CPG core wrapper for RZ/G2L SoC")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20211117115101.28281-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 1b1555deb20b..edd0abe34a37 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -879,8 +879,7 @@ static int __init rzg2l_cpg_add_clk_domain(struct device *dev)
 	if (ret)
 		return ret;
 
-	of_genpd_add_provider_simple(np, genpd);
-	return 0;
+	return of_genpd_add_provider_simple(np, genpd);
 }
 
 static int __init rzg2l_cpg_probe(struct platform_device *pdev)
-- 
2.17.1


