Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7FDC3F6B0
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 10:13:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.9106.1660299202951792196
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 03:13:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,231,1654527600";
   d="scan'208";a="131210700"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 12 Aug 2022 19:13:31 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6EC374243969;
	Fri, 12 Aug 2022 19:13:30 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/11] memory: renesas-rpc-if: simplify
 platform_get_resource_byname()
Date: Fri, 12 Aug 2022 11:13:12 +0100
Message-Id: <20220812101317.12380-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 10:13:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9178

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 2ca47b33a7794ce92ae881d6d62affea953814cd upstream.

Use devm_platform_ioremap_resource_byname() instead of
platform_get_resource_byname() and devm_ioremap_resource().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220419142859.380566-7-krzysztof.kozlowski@linaro.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 54ed31b862d4..6a096a033651 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -260,8 +260,7 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 
 	rpc->dev = dev;
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	rpc->base = devm_ioremap_resource(&pdev->dev, res);
+	rpc->base = devm_platform_ioremap_resource_byname(pdev, "regs");
 	if (IS_ERR(rpc->base))
 		return PTR_ERR(rpc->base);
 
-- 
2.17.1


