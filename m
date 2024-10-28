Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121EED3E2D0
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 20:04:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.2576.1730145879125009277
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Oct 2024 13:04:39 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,239,1725289200"; 
   d="scan'208";a="223233481"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Oct 2024 05:04:38 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.179])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8F20B408D45E;
	Tue, 29 Oct 2024 05:04:34 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 23/27] media: platform: rzg2l-cru: rzg2l-csi2: Add missing MODULE_DEVICE_TABLE
Date: Mon, 28 Oct 2024 20:03:45 +0000
Message-ID: <20241028200349.9620-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Oct 2024 20:04:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17106

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 07668fb0f867388bfdac0b60dbf51a4ad789f8e7 upstream.

The rzg2l-csi2 driver can be compiled as a module, but lacks
MODULE_DEVICE_TABLE() and will therefore not be loaded automatically.
Fix this.

Fixes: 51e8415e39a9 ("media: platform: Add Renesas RZ/G2L MIPI CSI-2 receiver driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20240731164935.308994-1-biju.das.jz@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[PL: manually applied the patch]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index f4805bca05342..245fda83d524d 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -870,6 +870,7 @@ static const struct of_device_id rzg2l_csi2_of_table[] = {
 	{ .compatible = "renesas,rzg2l-csi2", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, rzg2l_csi2_of_table);
 
 static struct platform_driver rzg2l_csi2_pdrv = {
 	.remove	= rzg2l_csi2_remove,
-- 
2.43.0


