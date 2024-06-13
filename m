Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCFAC27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 10:47:42 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5253.1718275650054850559
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 03:47:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,234,1712588400"; 
   d="scan'208";a="211744440"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Jun 2024 19:47:36 +0900
Received: from localhost.localdomain (unknown [10.226.92.168])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 80667400563D;
	Thu, 13 Jun 2024 19:47:34 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 3/7] usb: renesas_usbhs: Simplify obtaining device data
Date: Thu, 13 Jun 2024 11:47:22 +0100
Message-Id: <20240613104726.422783-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613104726.422783-1-biju.das.jz@bp.renesas.com>
References: <20240613104726.422783-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 10:47:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16213

commit a79c5b6f675634387de8e88b0c85a053b9952970 upstream.

Simplify probe() by removing redundant dev->of_node check.

While at it, replace dev_err->dev_err_probe for error path.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240319105356.87287-3-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 3af91b2b8f76..9196461e07ef 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -595,16 +595,11 @@ static int usbhs_probe(struct platform_device *pdev)
 	int ret;
 	u32 tmp;
 
-	/* check device node */
-	if (dev_of_node(dev))
-		info = of_device_get_match_data(dev);
-	else
-		info = renesas_usbhs_get_info(pdev);
-
-	/* check platform information */
+	info = of_device_get_match_data(dev);
 	if (!info) {
-		dev_err(dev, "no platform information\n");
-		return -EINVAL;
+		info = renesas_usbhs_get_info(pdev);
+		if (!info)
+			return dev_err_probe(dev, -EINVAL, "no platform info\n");
 	}
 
 	/* platform data */
-- 
2.25.1


