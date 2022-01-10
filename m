Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A3CC433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 12:24:00 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.31021.1641817424386543755
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 04:23:59 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106011148"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Jan 2022 21:23:59 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4CCB141E4D1E;
	Mon, 10 Jan 2022 21:23:58 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 20/61] ravb: Add multi_irq to struct ravb_hw_info
Date: Mon, 10 Jan 2022 12:22:50 +0000
Message-Id: <20220110122331.24114-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110122331.24114-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 12:24:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7385

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 6de19fa0e9f7d8d1033810df1e53ae5b0c7b0d65 upstream.

R-Car Gen3 supports separate interrupts for E-MAC and DMA queues,
whereas R-Car Gen2 and RZ/G2L have a single interrupt instead.

Add a multi_irq hw feature bit to struct ravb_hw_info to enable
this only for R-Car Gen3.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  1 +
 drivers/net/ethernet/renesas/ravb_main.c | 22 ++++++++++++++--------
 drivers/net/ethernet/renesas/ravb_ptp.c  |  8 +++++---
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index a0e19a45b2a0..a74bd63ba3be 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -998,6 +998,7 @@ struct ravb_hw_info {
 	/* hardware features */
 	unsigned internal_delay:1;	/* AVB-DMAC has internal delays */
 	unsigned tx_counters:1;		/* E-MAC has TX counters */
+	unsigned multi_irqs:1;		/* AVB-DMAC and E-MAC has multiple irqs */
 };
 
 struct ravb_private {
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index a8007c5cdd35..5e41c2b04083 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -425,6 +425,7 @@ static void ravb_emac_init(struct net_device *ndev)
 static int ravb_dmac_init(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	int error;
 
 	/* Set CONFIG mode */
@@ -456,7 +457,7 @@ static int ravb_dmac_init(struct net_device *ndev)
 	ravb_write(ndev, TCCR_TFEN, TCCR);
 
 	/* Interrupt init: */
-	if (priv->chip_id == RCAR_GEN3) {
+	if (info->multi_irqs) {
 		/* Clear DIL.DPLx */
 		ravb_write(ndev, 0, DIL);
 		/* Set queue specific interrupt */
@@ -756,6 +757,7 @@ static void ravb_error_interrupt(struct net_device *ndev)
 static bool ravb_queue_interrupt(struct net_device *ndev, int q)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	u32 ris0 = ravb_read(ndev, RIS0);
 	u32 ric0 = ravb_read(ndev, RIC0);
 	u32 tis  = ravb_read(ndev, TIS);
@@ -764,7 +766,7 @@ static bool ravb_queue_interrupt(struct net_device *ndev, int q)
 	if (((ris0 & ric0) & BIT(q)) || ((tis  & tic)  & BIT(q))) {
 		if (napi_schedule_prep(&priv->napi[q])) {
 			/* Mask RX and TX interrupts */
-			if (priv->chip_id == RCAR_GEN2) {
+			if (!info->multi_irqs) {
 				ravb_write(ndev, ric0 & ~BIT(q), RIC0);
 				ravb_write(ndev, tic & ~BIT(q), TIC);
 			} else {
@@ -907,6 +909,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 {
 	struct net_device *ndev = napi->dev;
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	unsigned long flags;
 	int q = napi - priv->napi;
 	int mask = BIT(q);
@@ -930,7 +933,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 
 	/* Re-enable RX/TX interrupts */
 	spin_lock_irqsave(&priv->lock, flags);
-	if (priv->chip_id == RCAR_GEN2) {
+	if (!info->multi_irqs) {
 		ravb_modify(ndev, RIC0, mask, mask);
 		ravb_modify(ndev, TIC,  mask, mask);
 	} else {
@@ -1336,6 +1339,7 @@ static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
 static int ravb_open(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	struct platform_device *pdev = priv->pdev;
 	struct device *dev = &pdev->dev;
 	int error;
@@ -1343,7 +1347,7 @@ static int ravb_open(struct net_device *ndev)
 	napi_enable(&priv->napi[RAVB_BE]);
 	napi_enable(&priv->napi[RAVB_NC]);
 
-	if (priv->chip_id == RCAR_GEN2) {
+	if (!info->multi_irqs) {
 		error = request_irq(ndev->irq, ravb_interrupt, IRQF_SHARED,
 				    ndev->name, ndev);
 		if (error) {
@@ -1401,7 +1405,7 @@ static int ravb_open(struct net_device *ndev)
 	if (priv->chip_id == RCAR_GEN2)
 		ravb_ptp_stop(ndev);
 out_free_irq_nc_tx:
-	if (priv->chip_id == RCAR_GEN2)
+	if (!info->multi_irqs)
 		goto out_free_irq;
 	free_irq(priv->tx_irqs[RAVB_NC], ndev);
 out_free_irq_nc_rx:
@@ -1678,6 +1682,7 @@ static int ravb_close(struct net_device *ndev)
 {
 	struct device_node *np = ndev->dev.parent->of_node;
 	struct ravb_private *priv = netdev_priv(ndev);
+	const struct ravb_hw_info *info = priv->info;
 	struct ravb_tstamp_skb *ts_skb, *ts_skb2;
 
 	netif_tx_stop_all_queues(ndev);
@@ -1711,7 +1716,7 @@ static int ravb_close(struct net_device *ndev)
 			of_phy_deregister_fixed_link(np);
 	}
 
-	if (priv->chip_id != RCAR_GEN2) {
+	if (info->multi_irqs) {
 		free_irq(priv->tx_irqs[RAVB_NC], ndev);
 		free_irq(priv->rx_irqs[RAVB_NC], ndev);
 		free_irq(priv->tx_irqs[RAVB_BE], ndev);
@@ -1937,6 +1942,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.max_rx_len = RX_BUF_SZ + RAVB_ALIGN - 1,
 	.internal_delay = 1,
 	.tx_counters = 1,
+	.multi_irqs = 1,
 };
 
 static const struct ravb_hw_info ravb_gen2_hw_info = {
@@ -2075,7 +2081,7 @@ static int ravb_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	if (info->chip_id == RCAR_GEN3)
+	if (info->multi_irqs)
 		irq = platform_get_irq_byname(pdev, "ch22");
 	else
 		irq = platform_get_irq(pdev, 0);
@@ -2115,7 +2121,7 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->avb_link_active_low =
 		of_property_read_bool(np, "renesas,ether-link-active-low");
 
-	if (info->chip_id == RCAR_GEN3) {
+	if (info->multi_irqs) {
 		irq = platform_get_irq_byname(pdev, "ch24");
 		if (irq < 0) {
 			error = irq;
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index 6984bd5b7da9..c099656dd75b 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -179,6 +179,7 @@ static int ravb_ptp_extts(struct ptp_clock_info *ptp,
 {
 	struct ravb_private *priv = container_of(ptp, struct ravb_private,
 						 ptp.info);
+	const struct ravb_hw_info *info = priv->info;
 	struct net_device *ndev = priv->ndev;
 	unsigned long flags;
 
@@ -197,7 +198,7 @@ static int ravb_ptp_extts(struct ptp_clock_info *ptp,
 	priv->ptp.extts[req->index] = on;
 
 	spin_lock_irqsave(&priv->lock, flags);
-	if (priv->chip_id == RCAR_GEN2)
+	if (!info->multi_irqs)
 		ravb_modify(ndev, GIC, GIC_PTCE, on ? GIC_PTCE : 0);
 	else if (on)
 		ravb_write(ndev, GIE_PTCS, GIE);
@@ -213,6 +214,7 @@ static int ravb_ptp_perout(struct ptp_clock_info *ptp,
 {
 	struct ravb_private *priv = container_of(ptp, struct ravb_private,
 						 ptp.info);
+	const struct ravb_hw_info *info = priv->info;
 	struct net_device *ndev = priv->ndev;
 	struct ravb_ptp_perout *perout;
 	unsigned long flags;
@@ -252,7 +254,7 @@ static int ravb_ptp_perout(struct ptp_clock_info *ptp,
 		error = ravb_ptp_update_compare(priv, (u32)start_ns);
 		if (!error) {
 			/* Unmask interrupt */
-			if (priv->chip_id == RCAR_GEN2)
+			if (!info->multi_irqs)
 				ravb_modify(ndev, GIC, GIC_PTME, GIC_PTME);
 			else
 				ravb_write(ndev, GIE_PTMS0, GIE);
@@ -264,7 +266,7 @@ static int ravb_ptp_perout(struct ptp_clock_info *ptp,
 		perout->period = 0;
 
 		/* Mask interrupt */
-		if (priv->chip_id == RCAR_GEN2)
+		if (!info->multi_irqs)
 			ravb_modify(ndev, GIC, GIC_PTME, 0);
 		else
 			ravb_write(ndev, GID_PTMD0, GID);
-- 
2.17.1


