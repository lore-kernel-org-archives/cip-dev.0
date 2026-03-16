Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADA0F506F5
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52447.1773673175962015446
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 1vF1GDyuRSC2phWnGrhJrQ==
X-CSE-MsgGUID: 2FmIig6FRqmOWBho0ruxKw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:40 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4AEF541B7814;
	Mon, 16 Mar 2026 23:59:39 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 13/35] usb: renesas_usbhs: Add support for RZ/T2H SoC
Date: Mon, 16 Mar 2026 14:58:50 +0000
Message-ID: <20260316145915.8580-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22405

commit 015709748ca921975ac1c91b40f664ca8c370eb6 upstream.

Add support for the Renesas RZ/T2H (r9a09g077) SoC by adding a compatible
string to the usbhs_of_match table. The USBHS controller on the RZ/T2H is
functionally similar to the one found on the RZ/G2L. While there are minor
differences in register fields (for example, the AWAIT[8:13] bits in
SYSCFG1 register), the current driver does not configure these, allowing
reuse of the existing usbhs_rzg2l_plat_info for the RZ/T2H.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250805114730.2491238-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/usb/renesas_usbhs/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 7f24fe82292c..8521f4bc0596 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -579,6 +579,10 @@ static const struct of_device_id usbhs_of_match[] = {
 		.compatible = "renesas,usbhs-r9a07g054",
 		.data = &usbhs_rzg2l_plat_info,
 	},
+	{
+		.compatible = "renesas,usbhs-r9a09g077",
+		.data = &usbhs_rzg2l_plat_info,
+	},
 	{
 		.compatible = "renesas,rcar-gen2-usbhs",
 		.data = &usbhs_rcar_gen2_plat_info,
-- 
2.43.0


