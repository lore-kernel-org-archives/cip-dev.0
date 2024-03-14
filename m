Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33340C54E6E
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 19:30:02 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.1808.1710444597208809443
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 12:30:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.07,126,1708354800"; 
   d="scan'208";a="197762400"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Mar 2024 04:30:00 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2E9DC4001B5F;
	Fri, 15 Mar 2024 04:29:58 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 4.19.y-cip 4/9] memory: renesas-rpc-if: Return error in case devm_ioremap_resource() fails
Date: Thu, 14 Mar 2024 19:29:45 +0000
Message-Id: <20240314192950.27343-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 19:30:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15312

commit 818fdfa89baac77a8df5a2c30f4fb798cc937aa0 upstream.

Make sure we return error in case devm_ioremap_resource() fails for dirmap
resource.

Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211025205631.21151-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 24eb3a5799c6..68b6efc0c428 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -274,7 +274,7 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
 	rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rpc->dirmap))
-		rpc->dirmap = NULL;
+		return PTR_ERR(rpc->dirmap);
 	rpc->size = resource_size(res);
 
 	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-- 
2.34.1


