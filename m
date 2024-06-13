Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A3EC27C7B
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 10:45:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.5304.1718275499259771666
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 03:45:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.08,234,1712588400"; 
   d="scan'208";a="207786236"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Jun 2024 19:45:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.168])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4FCDA42DCC01;
	Thu, 13 Jun 2024 19:45:04 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 4/7] usb: renesas_usbhs: Improve usbhsc_default_pipe[] for isochronous transfers
Date: Thu, 13 Jun 2024 11:44:50 +0100
Message-Id: <20240613104453.422524-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613104453.422524-1-biju.das.jz@bp.renesas.com>
References: <20240613104453.422524-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 10:45:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16206

commit 790effae39cf368a9ff029406b8033ab6618ff90 upstream.

As per the hardware manual, double buffer setting results in fewer
interrupts for high-speed data transfers. Improve usbhsc_default_pipe[]
for isochronous transfers by updating the table from single->double
buffering and update the pipe number accordingly.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240319105356.87287-4-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 548c8a9417fe..e93eaf559963 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -366,11 +366,11 @@ static void usbhsc_clk_disable_unprepare(struct usbhs_priv *priv)
 /* commonly used on old SH-Mobile SoCs */
 static struct renesas_usbhs_driver_pipe_config usbhsc_default_pipe[] = {
 	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_CONTROL, 64, 0x00, false),
-	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_ISOC, 1024, 0x08, false),
-	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_ISOC, 1024, 0x18, false),
-	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0x28, true),
-	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0x38, true),
+	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_ISOC, 1024, 0x08, true),
+	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_ISOC, 1024, 0x28, true),
 	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0x48, true),
+	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0x58, true),
+	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_BULK, 512, 0x68, true),
 	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_INT, 64, 0x04, false),
 	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_INT, 64, 0x05, false),
 	RENESAS_USBHS_PIPE(USB_ENDPOINT_XFER_INT, 64, 0x06, false),
-- 
2.25.1


