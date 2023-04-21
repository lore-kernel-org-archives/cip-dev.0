Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58995C77B78
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.6182.1682061511783976826
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:18:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="160252464"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Apr 2023 16:18:30 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7F7B741AA88B;
	Fri, 21 Apr 2023 16:18:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 23/33] ravb: Separate handling of irq enable/disable regs into feature
Date: Fri, 21 Apr 2023 08:17:19 +0100
Message-Id: <20230421071729.130347-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11296

From: Phil Edworthy <phil.edworthy@renesas.com>

commit cb99badde146c327f150773921ffe080abe1eb44 upstream.

Currently, when the HW has a single interrupt, the driver uses the
GIC, TIC, RIC0 registers to enable and disable interrupts.
When the HW has multiple interrupts, it uses the GIE, GID, TIE, TID,
RIE0, RID0 registers.

However, other devices, e.g. RZ/V2M, have multiple irqs and only have
the GIC, TIC, RIC0 registers.
Therefore, split this into a separate feature.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 1 +
 drivers/net/ethernet/renesas/ravb_main.c | 5 +++--
 drivers/net/ethernet/renesas/ravb_ptp.c  | 6 +++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 76ae3b5c568e..80401b932c37 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1035,6 +1035,7 @@ struct ravb_hw_info {
 	unsigned tx_counters:1;		/* E-MAC has TX counters */
 	unsigned carrier_counters:1;	/* E-MAC has carrier counters */
 	unsigned multi_irqs:1;		/* AVB-DMAC and E-MAC has multiple irqs */
+	unsigned irq_en_dis:1;		/* Has separate irq enable and disable regs */
 	unsigned gptp:1;		/* AVB-DMAC has gPTP support */
 	unsigned ccc_gac:1;		/* AVB-DMAC has gPTP support active in config mode */
 	unsigned nc_queues:1;		/* AVB-DMAC has RX and TX NC queues */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 1d09ecd412e4..84c7b7570a77 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1127,7 +1127,7 @@ static bool ravb_queue_interrupt(struct net_device *ndev, int q)
 	if (((ris0 & ric0) & BIT(q)) || ((tis  & tic)  & BIT(q))) {
 		if (napi_schedule_prep(&priv->napi[q])) {
 			/* Mask RX and TX interrupts */
-			if (!info->multi_irqs) {
+			if (!info->irq_en_dis) {
 				ravb_write(ndev, ric0 & ~BIT(q), RIC0);
 				ravb_write(ndev, tic & ~BIT(q), TIC);
 			} else {
@@ -1309,7 +1309,7 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 
 	/* Re-enable RX/TX interrupts */
 	spin_lock_irqsave(&priv->lock, flags);
-	if (!info->multi_irqs) {
+	if (!info->irq_en_dis) {
 		ravb_modify(ndev, RIC0, mask, mask);
 		ravb_modify(ndev, TIC,  mask, mask);
 	} else {
@@ -2419,6 +2419,7 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.internal_delay = 1,
 	.tx_counters = 1,
 	.multi_irqs = 1,
+	.irq_en_dis = 1,
 	.ccc_gac = 1,
 	.nc_queues = 1,
 	.magic_pkt = 1,
diff --git a/drivers/net/ethernet/renesas/ravb_ptp.c b/drivers/net/ethernet/renesas/ravb_ptp.c
index c099656dd75b..87c4306d66ec 100644
--- a/drivers/net/ethernet/renesas/ravb_ptp.c
+++ b/drivers/net/ethernet/renesas/ravb_ptp.c
@@ -198,7 +198,7 @@ static int ravb_ptp_extts(struct ptp_clock_info *ptp,
 	priv->ptp.extts[req->index] = on;
 
 	spin_lock_irqsave(&priv->lock, flags);
-	if (!info->multi_irqs)
+	if (!info->irq_en_dis)
 		ravb_modify(ndev, GIC, GIC_PTCE, on ? GIC_PTCE : 0);
 	else if (on)
 		ravb_write(ndev, GIE_PTCS, GIE);
@@ -254,7 +254,7 @@ static int ravb_ptp_perout(struct ptp_clock_info *ptp,
 		error = ravb_ptp_update_compare(priv, (u32)start_ns);
 		if (!error) {
 			/* Unmask interrupt */
-			if (!info->multi_irqs)
+			if (!info->irq_en_dis)
 				ravb_modify(ndev, GIC, GIC_PTME, GIC_PTME);
 			else
 				ravb_write(ndev, GIE_PTMS0, GIE);
@@ -266,7 +266,7 @@ static int ravb_ptp_perout(struct ptp_clock_info *ptp,
 		perout->period = 0;
 
 		/* Mask interrupt */
-		if (!info->multi_irqs)
+		if (!info->irq_en_dis)
 			ravb_modify(ndev, GIC, GIC_PTME, 0);
 		else
 			ravb_write(ndev, GID_PTMD0, GID);
-- 
2.25.1


