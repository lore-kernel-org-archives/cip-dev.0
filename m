Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B41C77B7F
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.6182.1682061511783976826
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="160252479"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:32 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 039EB41AA88B;
	Fri, 21 Apr 2023 16:18:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 24/33] ravb: Support separate Line0 (Desc), Line1 (Err) and Line2 (Mgmt) irqs
Date: Fri, 21 Apr 2023 08:17:20 +0100
Message-Id: <20230421071729.130347-25-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11297

From: Phil Edworthy <phil.edworthy@renesas.com>

commit b0265dcba3d6c1689e6ce315bed09192fb587403 upstream.

R-Car has a combined interrupt line, ch22 = Line0_DiA | Line1_A | Line2_A.
RZ/V2M has separate interrupt lines for each of these, so add a feature
that allows the driver to get these interrupts and call the common handler.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  3 ++
 drivers/net/ethernet/renesas/ravb_main.c | 56 +++++++++++++++++++++---
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 80401b932c37..d96bdf8d36a7 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1036,6 +1036,7 @@ struct ravb_hw_info {
 	unsigned carrier_counters:1;	/* E-MAC has carrier counters */
 	unsigned multi_irqs:1;		/* AVB-DMAC and E-MAC has multiple irqs */
 	unsigned irq_en_dis:1;		/* Has separate irq enable and disable regs */
+	unsigned err_mgmt_irqs:1;	/* Line1 (Err) and Line2 (Mgmt) irqs are separate */
 	unsigned gptp:1;		/* AVB-DMAC has gPTP support */
 	unsigned ccc_gac:1;		/* AVB-DMAC has gPTP support active in config mode */
 	unsigned nc_queues:1;		/* AVB-DMAC has RX and TX NC queues */
@@ -1086,6 +1087,8 @@ struct ravb_private {
 	int msg_enable;
 	int speed;
 	int emac_irq;
+	int erra_irq;
+	int mgmta_irq;
 	int rx_irqs[NUM_RX_QUEUE];
 	int tx_irqs[NUM_TX_QUEUE];
 
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 84c7b7570a77..e4d6dd1547ed 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1803,12 +1803,23 @@ static int ravb_open(struct net_device *ndev)
 				      ndev, dev, "ch19:tx_nc");
 		if (error)
 			goto out_free_irq_nc_rx;
+
+		if (info->err_mgmt_irqs) {
+			error = ravb_hook_irq(priv->erra_irq, ravb_multi_interrupt,
+					      ndev, dev, "err_a");
+			if (error)
+				goto out_free_irq_nc_tx;
+			error = ravb_hook_irq(priv->mgmta_irq, ravb_multi_interrupt,
+					      ndev, dev, "mgmt_a");
+			if (error)
+				goto out_free_irq_erra;
+		}
 	}
 
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
-		goto out_free_irq_nc_tx;
+		goto out_free_irq_mgmta;
 	ravb_emac_init(ndev);
 
 	/* Initialise PTP Clock driver */
@@ -1828,9 +1839,15 @@ static int ravb_open(struct net_device *ndev)
 	/* Stop PTP Clock driver */
 	if (info->gptp)
 		ravb_ptp_stop(ndev);
-out_free_irq_nc_tx:
+out_free_irq_mgmta:
 	if (!info->multi_irqs)
 		goto out_free_irq;
+	if (info->err_mgmt_irqs)
+		free_irq(priv->mgmta_irq, ndev);
+out_free_irq_erra:
+	if (info->err_mgmt_irqs)
+		free_irq(priv->erra_irq, ndev);
+out_free_irq_nc_tx:
 	free_irq(priv->tx_irqs[RAVB_NC], ndev);
 out_free_irq_nc_rx:
 	free_irq(priv->rx_irqs[RAVB_NC], ndev);
@@ -2171,6 +2188,10 @@ static int ravb_close(struct net_device *ndev)
 		free_irq(priv->tx_irqs[RAVB_BE], ndev);
 		free_irq(priv->rx_irqs[RAVB_BE], ndev);
 		free_irq(priv->emac_irq, ndev);
+		if (info->err_mgmt_irqs) {
+			free_irq(priv->erra_irq, ndev);
+			free_irq(priv->mgmta_irq, ndev);
+		}
 	}
 	free_irq(ndev->irq, ndev);
 
@@ -2605,10 +2626,14 @@ static int ravb_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	if (info->multi_irqs)
-		irq = platform_get_irq_byname(pdev, "ch22");
-	else
+	if (info->multi_irqs) {
+		if (info->err_mgmt_irqs)
+			irq = platform_get_irq_byname(pdev, "dia");
+		else
+			irq = platform_get_irq_byname(pdev, "ch22");
+	} else {
 		irq = platform_get_irq(pdev, 0);
+	}
 	if (irq < 0) {
 		error = irq;
 		goto out_release;
@@ -2650,7 +2675,10 @@ static int ravb_probe(struct platform_device *pdev)
 		of_property_read_bool(np, "renesas,ether-link-active-low");
 
 	if (info->multi_irqs) {
-		irq = platform_get_irq_byname(pdev, "ch24");
+		if (info->err_mgmt_irqs)
+			irq = platform_get_irq_byname(pdev, "line3");
+		else
+			irq = platform_get_irq_byname(pdev, "ch24");
 		if (irq < 0) {
 			error = irq;
 			goto out_release;
@@ -2672,6 +2700,22 @@ static int ravb_probe(struct platform_device *pdev)
 			}
 			priv->tx_irqs[i] = irq;
 		}
+
+		if (info->err_mgmt_irqs) {
+			irq = platform_get_irq_byname(pdev, "err_a");
+			if (irq < 0) {
+				error = irq;
+				goto out_release;
+			}
+			priv->erra_irq = irq;
+
+			irq = platform_get_irq_byname(pdev, "mgmt_a");
+			if (irq < 0) {
+				error = irq;
+				goto out_release;
+			}
+			priv->mgmta_irq = irq;
+		}
 	}
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.25.1


