Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE37C10DC3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:47:16 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.83960.1701956825767216182
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:47:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="185670981"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2023 22:47:15 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C826842B1D15;
	Thu,  7 Dec 2023 22:47:13 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/18] media: vsp1: mask interrupts before enabling
Date: Thu,  7 Dec 2023 13:46:46 +0000
Message-Id: <20231207134657.371420-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
References: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:47:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13850

From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>

commit c7cfc7b90e25468c98dfb1082474644f2a3e2df7 upstream.

VSP hardware could be used (e.g. by the bootloader) before driver load,
and some interrupts could be left in enabled and pending state. In this
case, setting up VSP interrupt handler without masking interrupts before
causes interrupt handler to be immediately called (and crash due to null
vsp->info dereference).

Fix that by explicitly masking all interrupts before setting the interrupt
handler. To do so, have to set the interrupt handler later, after hw
revision is already detected and number of interrupts to mask gets
known.

Based on patch by Koji Matsuoka <koji.matsuoka.xm@renesas.com> included
in the Renesas BSP kernel.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/platform/vsp1/vsp1_drv.c | 37 ++++++++++++++++++++------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index 936e01c6f752..c59cfd5498da 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -550,6 +550,16 @@ static int vsp1_device_init(struct vsp1_device *vsp1)
 	return 0;
 }
 
+static void vsp1_mask_all_interrupts(struct vsp1_device *vsp1)
+{
+	unsigned int i;
+
+	for (i = 0; i < vsp1->info->lif_count; ++i)
+		vsp1_write(vsp1, VI6_DISP_IRQ_ENB(i), 0);
+	for (i = 0; i < vsp1->info->wpf_count; ++i)
+		vsp1_write(vsp1, VI6_WPF_IRQ_ENB(i), 0);
+}
+
 /*
  * vsp1_device_get - Acquire the VSP1 device
  *
@@ -807,13 +817,6 @@ static int vsp1_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(&pdev->dev, irq, vsp1_irq_handler,
-			       IRQF_SHARED, dev_name(&pdev->dev), vsp1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ\n");
-		return ret;
-	}
-
 	/* FCP (optional). */
 	fcp_node = of_parse_phandle(pdev->dev.of_node, "renesas,fcp", 0);
 	if (fcp_node) {
@@ -843,7 +846,6 @@ static int vsp1_probe(struct platform_device *pdev)
 		goto done;
 
 	vsp1->version = vsp1_read(vsp1, VI6_IP_VERSION);
-	vsp1_device_put(vsp1);
 
 	for (i = 0; i < ARRAY_SIZE(vsp1_device_infos); ++i) {
 		if ((vsp1->version & VI6_IP_VERSION_MODEL_MASK) ==
@@ -856,12 +858,31 @@ static int vsp1_probe(struct platform_device *pdev)
 	if (!vsp1->info) {
 		dev_err(&pdev->dev, "unsupported IP version 0x%08x\n",
 			vsp1->version);
+		vsp1_device_put(vsp1);
 		ret = -ENXIO;
 		goto done;
 	}
 
 	dev_dbg(&pdev->dev, "IP version 0x%08x\n", vsp1->version);
 
+	/*
+	 * Previous use of the hardware (e.g. by the bootloader) could leave
+	 * some interrupts enabled and pending.
+	 *
+	 * TODO: Investigate if this shouldn't be better handled by using the
+	 * device reset provided by the CPG.
+	 */
+	vsp1_mask_all_interrupts(vsp1);
+
+	vsp1_device_put(vsp1);
+
+	ret = devm_request_irq(&pdev->dev, irq, vsp1_irq_handler,
+			       IRQF_SHARED, dev_name(&pdev->dev), vsp1);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to request IRQ\n");
+		goto done;
+	}
+
 	/* Instantiate entities. */
 	ret = vsp1_create_entities(vsp1);
 	if (ret < 0) {
-- 
2.25.1


