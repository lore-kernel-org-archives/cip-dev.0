Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20827D3E2DE
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 20:04:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.2556.1730145879123798506
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Oct 2024 13:04:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,239,1725289200"; 
   d="scan'208";a="227219319"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Oct 2024 05:04:38 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.179])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A95F7408D1FF;
	Tue, 29 Oct 2024 05:04:28 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 20/27] media: platform: rzg2l-cru: rzg2l-video: Fix image processing initialization
Date: Mon, 28 Oct 2024 20:03:42 +0000
Message-ID: <20241028200349.9620-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Oct 2024 20:04:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17104

From: Biju Das <biju.das.jz@bp.renesas.com>

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
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 1ab0cc741c05b..f8632481cdb82 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -432,13 +432,6 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru_dev *cru)
 
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
 
@@ -452,6 +445,13 @@ int rzg2l_cru_start_image_processing(struct rzg2l_cru_dev *cru)
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


