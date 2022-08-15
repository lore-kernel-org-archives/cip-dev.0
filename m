Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65EEC00140
	for <webhook@archiver.kernel.org>; Mon, 15 Aug 2022 16:37:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4469.1660581443659508777
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Aug 2022 09:37:29 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,238,1654527600";
   d="scan'208";a="129583877"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 01:37:28 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3FBAE40171F2;
	Tue, 16 Aug 2022 01:37:26 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 4/4] dmaengine: sh: rz-dmac: Add device_synchronize
 callback
Date: Mon, 15 Aug 2022 17:37:18 +0100
Message-Id: <20220815163718.24056-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220815163718.24056-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220815163718.24056-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Aug 2022 16:37:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9216

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 7d3a3aaaa9cc8ec53e9ef4f3e1711827107f76c5 upstream.

Some on-chip peripheral modules(for eg:- rspi) on RZ/G2L SoC
use the same signal for both interrupt and DMA transfer requests.
The signal works as a DMA transfer request signal by setting
DMARS, and subsequent interrupt requests to the interrupt controller
are masked.

We can re-enable the interrupt by clearing the DMARS.

This patch adds device_synchronize callback for clearing
DMARS and thereby allowing DMA consumers to switch to
interrupt mode.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20220722084430.969333-1-biju.das.jz@bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index ee2872e7d64c..476847a4916b 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -12,6 +12,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
+#include <linux/iopoll.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -630,6 +631,21 @@ static void rz_dmac_virt_desc_free(struct virt_dma_desc *vd)
 	 */
 }
 
+static void rz_dmac_device_synchronize(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	struct rz_dmac *dmac = to_rz_dmac(chan->device);
+	u32 chstat;
+	int ret;
+
+	ret = read_poll_timeout(rz_dmac_ch_readl, chstat, !(chstat & CHSTAT_EN),
+				100, 100000, false, channel, CHSTAT, 1);
+	if (ret < 0)
+		dev_warn(dmac->dev, "DMA Timeout");
+
+	rz_dmac_set_dmars_register(dmac, channel->index, 0);
+}
+
 /*
  * -----------------------------------------------------------------------------
  * IRQ handling
@@ -909,6 +925,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_config = rz_dmac_config;
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
+	engine->device_synchronize = rz_dmac_device_synchronize;
 
 	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
 	dma_set_max_seg_size(engine->dev, U32_MAX);
-- 
2.17.1


