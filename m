Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55BAC3DA61
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:00:58 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.58080.1722265258132494915
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:00:58 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213907139"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jul 2024 00:00:57 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7DE0F4018253;
	Tue, 30 Jul 2024 00:00:55 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y cip 2/8] net: ravb: Align poll function with NAPI docs
Date: Mon, 29 Jul 2024 15:00:43 +0000
Message-Id: <20240729150049.1924352-3-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
References: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:00:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16647

commit b0e0e20dc60e9e37b7e5bc71f0c912f66ad75529 upstream.

Align ravb_poll() with the documentation in
`Documentation/networking/kapi.rst` and
`Documentation/networking/napi.rst`.

The documentation says that we should prefer napi_complete_done() over
napi_complete(), and using the former allows us to properly support busy
polling. We should ensure that napi_complete_done() is only called if
the work budget has not been exhausted, and we should only re-arm
interrupts if it returns true.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 26 ++++++++++--------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ac3b56629910..3e4769af3c84 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1343,23 +1343,19 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	if (priv->rx_fifo_errors != ndev->stats.rx_fifo_errors)
 		ndev->stats.rx_fifo_errors = priv->rx_fifo_errors;
 
-	if (work_done == budget)
-		goto out;
-
-	napi_complete(napi);
-
-	/* Re-enable RX/TX interrupts */
-	spin_lock_irqsave(&priv->lock, flags);
-	if (!info->irq_en_dis) {
-		ravb_modify(ndev, RIC0, mask, mask);
-		ravb_modify(ndev, TIC,  mask, mask);
-	} else {
-		ravb_write(ndev, mask, RIE0);
-		ravb_write(ndev, mask, TIE);
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		/* Re-enable RX/TX interrupts */
+		spin_lock_irqsave(&priv->lock, flags);
+		if (!info->irq_en_dis) {
+			ravb_modify(ndev, RIC0, mask, mask);
+			ravb_modify(ndev, TIC,  mask, mask);
+		} else {
+			ravb_write(ndev, mask, RIE0);
+			ravb_write(ndev, mask, TIE);
+		}
+		spin_unlock_irqrestore(&priv->lock, flags);
 	}
-	spin_unlock_irqrestore(&priv->lock, flags);
 
-out:
 	return work_done;
 }
 
-- 
2.25.1


