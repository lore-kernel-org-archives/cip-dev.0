Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB19FC46CA9
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:47:16 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.83960.1701956825767216182
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:47:09 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="185670968"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2023 22:47:09 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 51B8C42B1D15;
	Thu,  7 Dec 2023 22:47:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/18] media: vsp1: Fix WPF macro names
Date: Thu,  7 Dec 2023 13:46:43 +0000
Message-Id: <20231207134657.371420-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
References: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:47:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13847

From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

commit e73396fee2614145e2f77a88cafbfc25183994f8 upstream.

The WPF IRQ enable and status macros have been incorrectly named WFP.
Fix them accordingly, and update all uses of the macros.

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/media/platform/vsp1/vsp1_drv.c  | 4 ++--
 drivers/media/platform/vsp1/vsp1_regs.h | 8 ++++----
 drivers/media/platform/vsp1/vsp1_wpf.c  | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/vsp1/vsp1_drv.c b/drivers/media/platform/vsp1/vsp1_drv.c
index 8acd6d45d8d0..bb256e36bda4 100644
--- a/drivers/media/platform/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/vsp1/vsp1_drv.c
@@ -44,7 +44,7 @@
 
 static irqreturn_t vsp1_irq_handler(int irq, void *data)
 {
-	u32 mask = VI6_WFP_IRQ_STA_DFE | VI6_WFP_IRQ_STA_FRE;
+	u32 mask = VI6_WPF_IRQ_STA_DFE | VI6_WPF_IRQ_STA_FRE;
 	struct vsp1_device *vsp1 = data;
 	irqreturn_t ret = IRQ_NONE;
 	unsigned int i;
@@ -59,7 +59,7 @@ static irqreturn_t vsp1_irq_handler(int irq, void *data)
 		status = vsp1_read(vsp1, VI6_WPF_IRQ_STA(i));
 		vsp1_write(vsp1, VI6_WPF_IRQ_STA(i), ~status & mask);
 
-		if (status & VI6_WFP_IRQ_STA_DFE) {
+		if (status & VI6_WPF_IRQ_STA_DFE) {
 			vsp1_pipeline_frame_end(wpf->entity.pipe);
 			ret = IRQ_HANDLED;
 		}
diff --git a/drivers/media/platform/vsp1/vsp1_regs.h b/drivers/media/platform/vsp1/vsp1_regs.h
index fe3130db1fa2..97942436868c 100644
--- a/drivers/media/platform/vsp1/vsp1_regs.h
+++ b/drivers/media/platform/vsp1/vsp1_regs.h
@@ -32,12 +32,12 @@
 #define VI6_STATUS_SYS_ACT(n)		BIT((n) + 8)
 
 #define VI6_WPF_IRQ_ENB(n)		(0x0048 + (n) * 12)
-#define VI6_WFP_IRQ_ENB_DFEE		BIT(1)
-#define VI6_WFP_IRQ_ENB_FREE		BIT(0)
+#define VI6_WPF_IRQ_ENB_DFEE		BIT(1)
+#define VI6_WPF_IRQ_ENB_FREE		BIT(0)
 
 #define VI6_WPF_IRQ_STA(n)		(0x004c + (n) * 12)
-#define VI6_WFP_IRQ_STA_DFE		BIT(1)
-#define VI6_WFP_IRQ_STA_FRE		BIT(0)
+#define VI6_WPF_IRQ_STA_DFE		BIT(1)
+#define VI6_WPF_IRQ_STA_FRE		BIT(0)
 
 #define VI6_DISP_IRQ_ENB(n)		(0x0078 + (n) * 60)
 #define VI6_DISP_IRQ_ENB_DSTE		BIT(8)
diff --git a/drivers/media/platform/vsp1/vsp1_wpf.c b/drivers/media/platform/vsp1/vsp1_wpf.c
index 208498fa6ed7..94e91d7bb56c 100644
--- a/drivers/media/platform/vsp1/vsp1_wpf.c
+++ b/drivers/media/platform/vsp1/vsp1_wpf.c
@@ -342,7 +342,7 @@ static void wpf_configure_stream(struct vsp1_entity *entity,
 	/* Enable interrupts. */
 	vsp1_dl_body_write(dlb, VI6_WPF_IRQ_STA(index), 0);
 	vsp1_dl_body_write(dlb, VI6_WPF_IRQ_ENB(index),
-			   VI6_WFP_IRQ_ENB_DFEE);
+			   VI6_WPF_IRQ_ENB_DFEE);
 
 	/*
 	 * Configure writeback for display pipelines (the wpf writeback flag is
-- 
2.25.1


