Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50EEECDFA1
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 14:41:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.7910.1666708896535930741
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 07:41:39 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.95,212,1661785200"; 
   d="scan'208";a="137874085"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Oct 2022 23:41:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.152])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A32B643684FF;
	Tue, 25 Oct 2022 23:41:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/12] mtd: hyperbus: rpc-if: Fix RPM imbalance in probe error path
Date: Tue, 25 Oct 2022 15:41:21 +0100
Message-Id: <20221025144131.1309463-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
References: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 14:41:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9823

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit c223a38d62e57aa60a890ea7247e3c58a54478e6 upstream.

If rpcif_hw_init() fails, Runtime PM is left enabled.

Fixes: b04cc0d912eb80d3 ("memory: renesas-rpc-if: Add support for RZ/G2L")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/f3070e1af480cb252ae183d479a593dbbf947685.1655457790.git.geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mtd/hyperbus/rpc-if.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
index 15a0be63ede1..d00d30243403 100644
--- a/drivers/mtd/hyperbus/rpc-if.c
+++ b/drivers/mtd/hyperbus/rpc-if.c
@@ -134,7 +134,7 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 
 	error = rpcif_hw_init(&hyperbus->rpc, true);
 	if (error)
-		return error;
+		goto out_disable_rpm;
 
 	hyperbus->hbdev.map.size = hyperbus->rpc.size;
 	hyperbus->hbdev.map.virt = hyperbus->rpc.dirmap;
@@ -145,8 +145,12 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 	hyperbus->hbdev.np = of_get_next_child(pdev->dev.parent->of_node, NULL);
 	error = hyperbus_register_device(&hyperbus->hbdev);
 	if (error)
-		rpcif_disable_rpm(&hyperbus->rpc);
+		goto out_disable_rpm;
+
+	return 0;
 
+out_disable_rpm:
+	rpcif_disable_rpm(&hyperbus->rpc);
 	return error;
 }
 
-- 
2.25.1


