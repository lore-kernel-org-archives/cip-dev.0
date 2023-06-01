Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305ADC77B7E
	for <webhook@archiver.kernel.org>; Thu,  1 Jun 2023 15:05:01 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.35000.1685631890331750789
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jun 2023 08:04:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,210,1681138800"; 
   d="scan'208";a="165350537"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Jun 2023 00:04:49 +0900
Received: from localhost.localdomain (unknown [10.226.93.19])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D3F7940078AA;
	Fri,  2 Jun 2023 00:04:47 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 14/19] usb: host: xhci-plat: Remove useless DMA-32 fallback configuration
Date: Thu,  1 Jun 2023 16:04:05 +0100
Message-Id: <20230601150410.124773-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
References: <20230601150410.124773-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Jun 2023 15:05:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11744

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 8729a2a2b1d6f112d5b286ec7b255d229a0f6eec upstream.

As stated in [1], dma_set_mask() with a 64-bit mask never fails if
dev->dma_mask is non-NULL.
So, if it fails, the 32 bits case will also fail for the same reason.

Simplify code and remove some dead code accordingly.

[1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/178f859197bebb385609a7c9458fb972ed312e5d.1642233968.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/usb/host/xhci-plat.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index a224e7e2f7d5..456656b37488 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -238,20 +238,13 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	if (!sysdev)
 		sysdev = &pdev->dev;
 
-	/* Try to set 64-bit DMA first */
 	if (WARN_ON(!sysdev->dma_mask))
 		/* Platform did not initialize dma_mask */
-		ret = dma_coerce_mask_and_coherent(sysdev,
-						   DMA_BIT_MASK(64));
+		ret = dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
 	else
 		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
-
-	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
-	if (ret) {
-		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(32));
-		if (ret)
-			return ret;
-	}
+	if (ret)
+		return ret;
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.25.1


