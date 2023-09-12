Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E47AEE3F14
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 19:59:25 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.448.1694548760878224845
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 12:59:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,141,1688396400"; 
   d="scan'208";a="175845687"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Sep 2023 04:59:21 +0900
Received: from localhost.localdomain (unknown [10.226.93.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id D6BE040A4AC0;
	Wed, 13 Sep 2023 04:59:19 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 01/15] dmaengine: sh: rz-dmac: Improve cleanup order in probe()/remove()
Date: Tue, 12 Sep 2023 20:59:01 +0100
Message-Id: <20230912195915.607664-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
References: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 19:59:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13075

commit 7ab04b7cffa5aa646bfaf70d63634767dbf87eba upstream.

We usually do cleanup in reverse order of init. Currently, in the
case of error, this is not followed in rz_dmac_probe(), and similar
case for remove().

This patch improves error handling in probe() and cleanup in
reverse order of init in the remove().

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Pavel Machek <pavel@denx.de>
Link: https://lore.kernel.org/r/20230706112150.198941-2-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 9479f29692d3..229f642fde6b 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -947,7 +947,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
 dma_register_err:
 	of_dma_controller_free(pdev->dev.of_node);
 err:
-	reset_control_assert(dmac->rstc);
 	channel_num = i ? i - 1 : 0;
 	for (i = 0; i < channel_num; i++) {
 		struct rz_dmac_chan *channel = &dmac->channels[i];
@@ -958,6 +957,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 				  channel->lmdesc.base_dma);
 	}
 
+	reset_control_assert(dmac->rstc);
 err_pm_runtime_put:
 	pm_runtime_put(&pdev->dev);
 err_pm_disable:
@@ -971,6 +971,8 @@ static int rz_dmac_remove(struct platform_device *pdev)
 	struct rz_dmac *dmac = platform_get_drvdata(pdev);
 	unsigned int i;
 
+	dma_async_device_unregister(&dmac->engine);
+	of_dma_controller_free(pdev->dev.of_node);
 	for (i = 0; i < dmac->n_channels; i++) {
 		struct rz_dmac_chan *channel = &dmac->channels[i];
 
@@ -979,8 +981,6 @@ static int rz_dmac_remove(struct platform_device *pdev)
 				  channel->lmdesc.base,
 				  channel->lmdesc.base_dma);
 	}
-	of_dma_controller_free(pdev->dev.of_node);
-	dma_async_device_unregister(&dmac->engine);
 	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-- 
2.25.1


