Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA0CC7EE26
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 08:54:11 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.84062.1684140842138353029
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 01:54:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,276,1677510000"; 
   d="scan'208";a="159396951"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 May 2023 17:54:01 +0900
Received: from localhost.localdomain (unknown [10.226.93.20])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2C54C4009672;
	Mon, 15 May 2023 17:53:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/4] dmaengine: sh: rz-dmac: Add reset support
Date: Mon, 15 May 2023 09:53:50 +0100
Message-Id: <20230515085352.25794-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
References: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 08:54:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11448

commit d1e71a3a7ab9db0168b6885171e0576383216ac8 upstream.

Add reset support for DMAC module found on RZ/G2L alike SoCs.

For booting the board, reset release of the DMAC module is required
otherwise we don't get GIC interrupts. Currently the reset release
was done by the bootloader now move this to the driver instead.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20230315064501.21491-1-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 476847a4916b..6b62e01ba658 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -20,6 +20,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
@@ -92,6 +93,7 @@ struct rz_dmac_chan {
 struct rz_dmac {
 	struct dma_device engine;
 	struct device *dev;
+	struct reset_control *rstc;
 	void __iomem *base;
 	void __iomem *ext_base;
 
@@ -889,6 +891,11 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	/* Initialize the channels. */
 	INIT_LIST_HEAD(&dmac->engine.channels);
 
+	dmac->rstc = devm_reset_control_array_get_exclusive(&pdev->dev);
+	if (IS_ERR(dmac->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dmac->rstc),
+				     "failed to get resets\n");
+
 	pm_runtime_enable(&pdev->dev);
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
@@ -896,6 +903,10 @@ static int rz_dmac_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
+	ret = reset_control_deassert(dmac->rstc);
+	if (ret)
+		goto err_pm_runtime_put;
+
 	for (i = 0; i < dmac->n_channels; i++) {
 		ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
 		if (ret < 0)
@@ -940,6 +951,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 dma_register_err:
 	of_dma_controller_free(pdev->dev.of_node);
 err:
+	reset_control_assert(dmac->rstc);
 	channel_num = i ? i - 1 : 0;
 	for (i = 0; i < channel_num; i++) {
 		struct rz_dmac_chan *channel = &dmac->channels[i];
@@ -950,6 +962,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 				  channel->lmdesc.base_dma);
 	}
 
+err_pm_runtime_put:
 	pm_runtime_put(&pdev->dev);
 err_pm_disable:
 	pm_runtime_disable(&pdev->dev);
@@ -972,6 +985,7 @@ static int rz_dmac_remove(struct platform_device *pdev)
 	}
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&dmac->engine);
+	reset_control_assert(dmac->rstc);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-- 
2.25.1


