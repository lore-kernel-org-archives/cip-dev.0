Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4861C3DA61
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:01:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.58080.1722265258132494915
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:01:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213907162"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jul 2024 00:01:06 +0900
Received: from ree-du1sdd5.ree.adwin.renesas.com (unknown [10.226.105.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8405D401849C;
	Tue, 30 Jul 2024 00:01:04 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y cip 6/8] net: ravb: Enable SW IRQ Coalescing for GbEth
Date: Mon, 29 Jul 2024 15:00:47 +0000
Message-Id: <20240729150049.1924352-7-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
References: <20240729150049.1924352-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:01:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16651

commit 7b39c1814ce3bcdf95d026bbb27322218840a27d upstream.

Software IRQ Coalescing is required to improve network stack performance
in the RZ/G2L SoC family and the RZ/G3S SoC, i.e. the SoCs which use the
GbEth IP.

This patch gives the following improvements during testing with iperf3:

  * RZ/G2L:
    * TCP RX: same bandwidth with -6% CPU load (76% -> 71%)
    * UDP RX: same bandwidth with -10% CPU load (99% -> 89%)

  * RZ/G2UL:
    * UDP RX: +4200% bandwidth (1.23Mbps -> 53Mbps)

  * RZ/G3S:
    * UDP RX: +425% bandwidth (1.23Mbps -> 6.46Mbps)

The improvement of UDP RX bandwidth for the single core SoCs (RZ/G2UL &
RZ/G3S) is particularly critical.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 1 +
 drivers/net/ethernet/renesas/ravb_main.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 71de2a7aa27c..6a7aa7dd17e6 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1054,6 +1054,7 @@ struct ravb_hw_info {
 	u32 rx_max_desc_use;
 	u32 rx_desc_size;
 	unsigned aligned_tx: 1;
+	unsigned coalesce_irqs:1;	/* Needs software IRQ coalescing */
 
 	/* hardware features */
 	unsigned internal_delay:1;	/* AVB-DMAC has internal delays */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ba3c6150f360..cdc3c3be9c4c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2676,6 +2676,7 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.rx_max_desc_use = 4080,
 	.rx_desc_size = sizeof(struct ravb_rx_desc),
 	.aligned_tx = 1,
+	.coalesce_irqs = 1,
 	.tx_counters = 1,
 	.carrier_counters = 1,
 	.half_duplex = 1,
@@ -2952,6 +2953,9 @@ static int ravb_probe(struct platform_device *pdev)
 	if (info->nc_queues)
 		netif_napi_add(ndev, &priv->napi[RAVB_NC], ravb_poll);
 
+	if (info->coalesce_irqs)
+		netdev_sw_irq_coalesce_default_on(ndev);
+
 	/* Network device register */
 	error = register_netdev(ndev);
 	if (error)
-- 
2.25.1


