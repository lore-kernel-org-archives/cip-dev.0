Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D38EB64DC
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 13:19:52 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.32221.1688390390259379555
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 06:19:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,178,1684767600"; 
   d="scan'208";a="170242922"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Jul 2023 22:19:48 +0900
Received: from localhost.localdomain (unknown [10.226.93.24])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A59AC4221047;
	Mon,  3 Jul 2023 22:19:46 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip] usb: gadget: udc: renesas_usb3: Fix RZ/V2M {modprobe,bind} error
Date: Mon,  3 Jul 2023 14:19:44 +0100
Message-Id: <20230703131944.353224-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 13:19:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12183

commit 3e6ac852fbc71a234de24b5455086f6b98d3d958 upstream.

Currently {modprobe, bind} after {rmmod, unbind} results in probe failure.

genirq: Flags mismatch irq 22. 00000004 (85070400.usb3drd) vs. 00000004 (85070400.usb3drd)
renesas_usb3: probe of 85070000.usb3peri failed with error -16

The reason is, it is trying to register an interrupt handler for the same
IRQ twice. The devm_request_irq() was called with the parent device.
So the interrupt handler won't be unregistered when the usb3-peri device
is unbound.

Fix this issue by replacing "parent dev"->"dev" as the irq resource
is managed by this driver.

Fixes: 9cad72dfc556 ("usb: gadget: Add support for RZ/V2M USB3DRD driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Message-ID: <20230530161720.179927-1-biju.das.jz@bp.renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/gadget/udc/renesas_usb3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index a301af66bd91..50d3d4c55fac 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2898,9 +2898,9 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 		struct rzv2m_usb3drd *ddata = dev_get_drvdata(pdev->dev.parent);
 
 		usb3->drd_reg = ddata->reg;
-		ret = devm_request_irq(ddata->dev, ddata->drd_irq,
+		ret = devm_request_irq(&pdev->dev, ddata->drd_irq,
 				       renesas_usb3_otg_irq, 0,
-				       dev_name(ddata->dev), usb3);
+				       dev_name(&pdev->dev), usb3);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.25.1


