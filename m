Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7B8E77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 09:11:59 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.33054.1733476314916232608
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 01:11:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: NxUaq9zyQ3SLbiVwYiyWvQ==
X-CSE-MsgGUID: 3DOdD6N1Sd+AuR5ABi0P1Q==
X-IronPort-AV: E=Sophos;i="6.12,213,1728918000"; 
   d="scan'208";a="231085719"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Dec 2024 18:11:54 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0B848419AC7C;
	Fri,  6 Dec 2024 18:11:40 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 09/16] memory: renesas-rpc-if: Always use dev in rpcif_probe()
Date: Fri,  6 Dec 2024 09:11:15 +0000
Message-ID: <20241206091122.67133-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241206091122.67133-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 09:11:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17352

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit d5ab2e8c7dd2cdcc676d7383b6b1b31e2c4d805c upstream.

rpcif_probe() already has a "dev" variable pointing to the right device
structure, so there is no need to take a detour through the platform
device.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://lore.kernel.org/r/298009c43ad119703f564c0f1864743914b4beeb.1669213027.git.geert+renesas@glider.be
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 7343dbb79c9f..03983c5d5d6a 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -684,9 +684,9 @@ static int rpcif_probe(struct platform_device *pdev)
 	const char *name;
 	int ret;
 
-	flash = of_get_next_child(pdev->dev.of_node, NULL);
+	flash = of_get_next_child(dev->of_node, NULL);
 	if (!flash) {
-		dev_warn(&pdev->dev, "no flash node found\n");
+		dev_warn(dev, "no flash node found\n");
 		return -ENODEV;
 	}
 
@@ -696,12 +696,12 @@ static int rpcif_probe(struct platform_device *pdev)
 		name = "rpc-if-hyperflash";
 	} else	{
 		of_node_put(flash);
-		dev_warn(&pdev->dev, "unknown flash type\n");
+		dev_warn(dev, "unknown flash type\n");
 		return -ENODEV;
 	}
 	of_node_put(flash);
 
-	rpc = devm_kzalloc(&pdev->dev, sizeof(*rpc), GFP_KERNEL);
+	rpc = devm_kzalloc(dev, sizeof(*rpc), GFP_KERNEL);
 	if (!rpc)
 		return -ENOMEM;
 
@@ -730,9 +730,9 @@ static int rpcif_probe(struct platform_device *pdev)
 	vdev = platform_device_alloc(name, pdev->id);
 	if (!vdev)
 		return -ENOMEM;
-	vdev->dev.parent = &pdev->dev;
+	vdev->dev.parent = dev;
 
-	rpc->dev = &pdev->dev;
+	rpc->dev = dev;
 	rpc->vdev = vdev;
 	platform_set_drvdata(pdev, rpc);
 
-- 
2.43.0


