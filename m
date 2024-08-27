Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30AEC5473D
	for <webhook@archiver.kernel.org>; Tue, 27 Aug 2024 21:06:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.1432.1724792789935437196
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Aug 2024 14:06:30 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.10,181,1719846000"; 
   d="scan'208";a="220720171"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Aug 2024 06:06:29 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.135])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 85CAE40031E0;
	Wed, 28 Aug 2024 06:06:27 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y cip v2 7/9] net: ravb: Use NAPI threaded mode on 1-core CPUs with GbEth IP
Date: Tue, 27 Aug 2024 22:06:07 +0100
Message-Id: <20240827210609.12695-8-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
References: <20240827210609.12695-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Aug 2024 21:06:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16826

commit 65c482bc226ab25a7884ee6fd1cc09bb08cbd1be upstream.

NAPI Threaded mode (along with the previously enabled SW IRQ Coalescing)
is required to improve network stack performance for single core SoCs
using the GbEth IP (currently the RZ/G2L SoC family and the RZ/G3S SoC).

This patch gives the following improvements during testing with iperf3.

  * RZ/G2UL:
    * TCP TX: +32% bandwidth (638Mbps -> 841Mbps)
    * TXP RX: +8.8% bandwidth (667Mbps -> 726Mbps)
    * UDP RX: +104% bandwidth (53Mbps -> 108Mbps)

  * RZ/G3S:
    * TCP TX: 29% bandwidth (529Mbps -> 681Mbps)
    * UDP RX: +1290% bandwidth (6.46Mbps -> 90Mbps)

  * RZ/Five:
    * UDP RX: Test no longer crashes (0 -> 20 Mbps)

This patch gives the following reductions in performance in the same
testing:

  * RZ/G2UL:
    * UDP TX: -7.5% bandwidth (594Mbps -> 549Mbps)

  * RZ/G3S:
    * UDP TX: -5% bandwidth (625Mbps -> 594Mbps)

These losses are considered acceptable given the benefits shown above.
If UDP TX bandwidth must be maximised for a particular use case, NAPI
threaded mode can be disabled at runtime via sysfs writes.

The improvement of UDP RX bandwidth for the single core SoCs (RZ/G2UL &
RZ/G3S) is particularly critical.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index cdc3c3be9c4c..fb34491d1fd0 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2953,8 +2953,11 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->nc_queues)
 		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll);
 
-	if (info->coalesce_irqs)
+	if (info->coalesce_irqs) {
 		netdev_sw_irq_coalesce_default_on(ndev);
+		if (num_present_cpus() == 1)
+			dev_set_threaded(ndev, true);
+	}
 
 	/* Network device register */
 	error = register_netdev(ndev);
-- 
2.43.0


