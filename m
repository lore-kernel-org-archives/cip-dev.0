Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB37EE674A9
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 14:15:55 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.39016.1730470552520763213
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Nov 2024 07:15:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,250,1725289200"; 
   d="scan'208";a="227647411"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Nov 2024 23:15:51 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.182])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5882442147B8;
	Fri,  1 Nov 2024 23:15:41 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 1/2] media: rzg2l-cru: Remove unneeded semicolon
Date: Fri,  1 Nov 2024 14:15:37 +0000
Message-ID: <20241101141538.34849-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101141538.34849-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241101141538.34849-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Nov 2024 14:15:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17165

From: Yang Li <yang.lee@linux.alibaba.com>

commit 7206fcc59399729667260d58c63e3db4503ac511 upstream.

./drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c:409:2-3: Unneeded semicolon
./drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c:407:2-3: Unneeded semicolon

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3273

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c  | 2 +-
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index e1668a4d12561..3f16058dc6365 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -411,7 +411,7 @@ static int rzg2l_csi2_mipi_link_disable(struct rzg2l_csi2 *csi2)
 		if (!(rzg2l_csi2_read(csi2, CSI2nRTST) & CSI2nRTST_VSRSTS))
 			break;
 		usleep_range(100, 200);
-	};
+	}
 
 	if (!timeout)
 		dev_err(csi2->dev, "Clearing CSI2nRTST.VSRSTS timed out\n");
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 96ccc0edfa702..33a38528dbc0c 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -404,7 +404,7 @@ void rzg2l_cru_stop_image_processing(struct rzg2l_cru_dev *cru)
 			break;
 
 		usleep_range(10, 20);
-	};
+	}
 
 	/* Notify that AXI bus can not stop here */
 	if (!retries)
-- 
2.43.0


