Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3363C3DA4A
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 16:44:28 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.12769.1722876265945965968
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 09:44:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,265,1716217200"; 
   d="scan'208";a="214739927"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Aug 2024 01:44:25 +0900
Received: from localhost.localdomain (unknown [10.226.92.197])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CDF0640213E1;
	Tue,  6 Aug 2024 01:44:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 19/30] media: platform: rzg2l-cru: rzg2l-video: Fix image processing initialization
Date: Mon,  5 Aug 2024 17:43:12 +0100
Message-ID: <20240805164342.211857-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
References: <20240805164342.211857-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 16:44:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16741

commit 276739485501e61096034ec036337feab4c07dc5 upstream.

As per section 35.3.1 Starting Reception for the MIPI CSI-2 Input on the
latest hardware manual (R01UH0914EJ0140 Rev.1.40) it is mentioned that
initialize the AXI master first and then initialize the image processing.
Fix the start procedure as per the hardware manual.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20240213181233.242316-4-biju.das.jz@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 91b57c7c2e56..6d03b3a2af5e 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -430,13 +430,6 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru_dev *cru)
 
 	spin_lock_irqsave(&cru->qlock, flags);
 
-	/* Initialize image convert */
-	ret = rzg2l_cru_initialize_image_conv(cru, fmt);
-	if (ret) {
-		spin_unlock_irqrestore(&cru->qlock, flags);
-		return ret;
-	}
-
 	/* Select a video input */
 	rzg2l_cru_write(cru, CRUnCTRL, CRUnCTRL_VINSEL(0));
 
@@ -450,6 +443,13 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru_dev *cru)
 	/* Initialize the AXI master */
 	rzg2l_cru_initialize_axi(cru);
 
+	/* Initialize image convert */
+	ret = rzg2l_cru_initialize_image_conv(cru, fmt);
+	if (ret) {
+		spin_unlock_irqrestore(&cru->qlock, flags);
+		return ret;
+	}
+
 	/* Enable interrupt */
 	rzg2l_cru_write(cru, CRUnIE, CRUnIE_EFE);
 
-- 
2.43.0


