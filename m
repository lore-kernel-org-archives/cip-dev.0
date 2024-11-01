Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA29E6B26C
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 12:58:25 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.37238.1730465903481230836
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Nov 2024 05:58:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,249,1725289200"; 
   d="scan'208";a="223655324"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 Nov 2024 21:58:24 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.182])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1E019400720A;
	Fri,  1 Nov 2024 21:58:17 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 16/28] media: rzg2l-cru: Remove unneeded semicolon
Date: Fri,  1 Nov 2024 12:57:34 +0000
Message-ID: <20241101125746.33222-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241101125746.33222-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Nov 2024 12:58:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17149

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
index e73c44385cd5e..b413ad7ff6388 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -403,7 +403,7 @@ static void rzg2l_csi2_mipi_link_disable(struct rzg2l_csi2 *csi2)
 		if (!(rzg2l_csi2_read(csi2, CSI2nRTST) & CSI2nRTST_VSRSTS))
 			break;
 		usleep_range(100, 200);
-	};
+	}
 
 	if (!timeout)
 		dev_err(csi2->dev, "Clearing CSI2nRTST.VSRSTS timed out\n");
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 0f50dcc713217..1ab0cc741c05b 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -406,7 +406,7 @@ void rzg2l_cru_stop_image_processing(struct rzg2l_cru_dev *cru)
 			break;
 
 		usleep_range(10, 20);
-	};
+	}
 
 	/* Notify that AXI bus can not stop here */
 	if (!retries)
-- 
2.43.0


