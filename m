Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E98C7EE2F
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:04:51 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.34577.1685631880118354685
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="165350528"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:42 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 28E374010DC0;
	Fri,  2 Jun 2023 00:04:39 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 11/19] usb: host: xhci-plat: Improve clock handling in probe()
Date: Thu,  1 Jun 2023 16:04:02 +0100
Message-Id: <20230601150410.124773-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:04:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11741

commit 8c6e8b09617915e8af3ab7dbfecd8f0a9c7cf94f upstream.

It is always better to acquire all the clock resources first and
then do the clock operations.

This patch acquires all the optional clocks first and then calls
corresponding prepare_enable().

There is no functional change.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230121145853.4792-8-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/host/xhci-plat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 972a44b2a7f1..9c755d4f3140 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -273,16 +273,16 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		goto put_hcd;
 	}
 
-	ret = clk_prepare_enable(xhci->reg_clk);
-	if (ret)
-		goto put_hcd;
-
 	xhci->clk = devm_clk_get_optional(&pdev->dev, NULL);
 	if (IS_ERR(xhci->clk)) {
 		ret = PTR_ERR(xhci->clk);
-		goto disable_reg_clk;
+		goto put_hcd;
 	}
 
+	ret = clk_prepare_enable(xhci->reg_clk);
+	if (ret)
+		goto put_hcd;
+
 	ret = clk_prepare_enable(xhci->clk);
 	if (ret)
 		goto disable_reg_clk;
-- 
2.25.1


