Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29624C27C75
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 10:45:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5304.1718275499259771666
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 03:45:11 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,234,1712588400"; 
   d="scan'208";a="207786252"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Jun 2024 19:45:10 +0900
Received: from localhost.localdomain (unknown [10.226.92.168])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E39D142E076C;
	Thu, 13 Jun 2024 19:45:08 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 6/7] usb: renesas_usbhs: Remove trailing comma in the terminator entry for OF table
Date: Thu, 13 Jun 2024 11:44:52 +0100
Message-Id: <20240613104453.422524-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613104453.422524-1-biju.das.jz@bp.renesas.com>
References: <20240613104453.422524-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 10:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16208

commit de9700f44d41d5ebdcbc0c5b5e1ffe7861eaffb1 upstream.

Remove the trailing comma in the terminator entry for the OF table
making code robust against (theoretical) misrebases or other similar
things where the new entry goes _after_ the termination without the
compiler noticing.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240319105356.87287-6-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 7ae6fa76e179..889c8909e497 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -597,7 +597,7 @@ static const struct of_device_id usbhs_of_match[] = {
 		.compatible = "renesas,rzg2l-usbhs",
 		.data = &usbhs_rzg2l_plat_info,
 	},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, usbhs_of_match);
 
-- 
2.25.1


