Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8808D3E2C7
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 20:04:04 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.2544.1730145836643399470
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Oct 2024 13:03:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,239,1725289200"; 
   d="scan'208";a="227219248"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Oct 2024 05:03:54 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.179])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1867E408D216;
	Tue, 29 Oct 2024 05:03:52 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/27] media: i2c: ov5645: Drop fetching the clk reference by name
Date: Mon, 28 Oct 2024 20:03:23 +0000
Message-ID: <20241028200349.9620-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Oct 2024 20:04:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17083

commit 9084e2c8617a63c478b48810ff7a8985de55f308 upstream.

The OV5645 sensor has a single clock source, so just drop fetching the
clk reference by name.

This is in preparation to drop the "clock-names" property from the DT
binding.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/ov5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index a6c17d15d7547..75baf5a67a691 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -1088,7 +1088,7 @@ static int ov5645_probe(struct i2c_client *client)
 	}
 
 	/* get system clock (xclk) */
-	ov5645->xclk = devm_clk_get(dev, "xclk");
+	ov5645->xclk = devm_clk_get(dev, NULL);
 	if (IS_ERR(ov5645->xclk)) {
 		dev_err(dev, "could not get xclk");
 		return PTR_ERR(ov5645->xclk);
-- 
2.43.0


