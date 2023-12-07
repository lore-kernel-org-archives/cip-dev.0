Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE99DC4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:47:16 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.84360.1701956827359263144
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:47:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="189544035"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Dec 2023 22:47:06 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2929B42B1D15;
	Thu,  7 Dec 2023 22:47:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 03/18] media: vsp1: Make use of the helper function devm_platform_ioremap_resource()
Date: Thu,  7 Dec 2023 13:46:42 +0000
Message-Id: <20231207134657.371420-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
References: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:47:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13846

From: Cai Huoqing <caihuoqing@baidu.com>

commit a24973a60551dab8a4b6cbbe02d64719dc2858a1 upstream.

Use the devm_platform_ioremap_resource() helper instead of
calling platform_get_resource() and devm_ioremap_resource()
separately

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/platform/vsp1/vsp1_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index de442d6c9926..8acd6d45d8d0 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -785,7 +785,6 @@ static int vsp1_probe(struct platform_device *pdev)
 	struct vsp1_device *vsp1;
 	struct device_node *fcp_node;
 	struct resource *irq;
-	struct resource *io;
 	unsigned int i;
 	int ret;
 
@@ -800,8 +799,7 @@ static int vsp1_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, vsp1);
 
 	/* I/O and IRQ resources (clock managed by the clock PM domain). */
-	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	vsp1->mmio = devm_ioremap_resource(&pdev->dev, io);
+	vsp1->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(vsp1->mmio))
 		return PTR_ERR(vsp1->mmio);
 
-- 
2.25.1


