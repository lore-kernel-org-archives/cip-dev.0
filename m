Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5A5C7EE23
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:51 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.34581.1685631885156351648
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:45 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="161816486"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:44 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A3F4E4010DC0;
	Fri,  2 Jun 2023 00:04:42 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 12/19] usb: host: xhci-plat: Add reset support
Date: Thu,  1 Jun 2023 16:04:03 +0100
Message-Id: <20230601150410.124773-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11742

commit 224eb5311d6a8c180932465873d809b48a2470bf upstream.

Add optional reset support. This is in preparation to adding USB xHCI
support for RZ/V2M SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230121145853.4792-9-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/host/xhci-plat.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 9c755d4f3140..6198a09c1066 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/usb/of.h>
+#include <linux/reset.h>
 
 #include "xhci.h"
 #include "xhci-plat.h"
@@ -279,10 +280,20 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		goto put_hcd;
 	}
 
-	ret = clk_prepare_enable(xhci->reg_clk);
+	xhci->reset = devm_reset_control_array_get_optional_shared(&pdev->dev);
+	if (IS_ERR(xhci->reset)) {
+		ret = PTR_ERR(xhci->reset);
+		goto put_hcd;
+	}
+
+	ret = reset_control_deassert(xhci->reset);
 	if (ret)
 		goto put_hcd;
 
+	ret = clk_prepare_enable(xhci->reg_clk);
+	if (ret)
+		goto err_reset;
+
 	ret = clk_prepare_enable(xhci->clk);
 	if (ret)
 		goto disable_reg_clk;
@@ -392,6 +403,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
 disable_reg_clk:
 	clk_disable_unprepare(xhci->reg_clk);
 
+err_reset:
+	reset_control_assert(xhci->reset);
+
 put_hcd:
 	usb_put_hcd(hcd);
 
@@ -422,6 +436,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 
 	clk_disable_unprepare(clk);
 	clk_disable_unprepare(reg_clk);
+	reset_control_assert(xhci->reset);
 	usb_put_hcd(hcd);
 
 	pm_runtime_disable(&dev->dev);
-- 
2.25.1


