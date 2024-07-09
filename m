Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB9EC3DA41
	for <webhook@archiver.kernel.org>; Tue,  9 Jul 2024 11:18:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.10611.1720523880943811051
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Jul 2024 04:18:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,194,1716217200"; 
   d="scan'208";a="214758049"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Jul 2024 20:18:02 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.66])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DB76D4005473;
	Tue,  9 Jul 2024 20:17:59 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH RESEND 6.1.y-cip 1/1] net: ravb: Fix GbEth jumbo packet RX checksum handling
Date: Tue,  9 Jul 2024 12:17:47 +0100
Message-Id: <20240709111747.247-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240709111747.247-1-paul.barker.ct@bp.renesas.com>
References: <20240709111747.247-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Jul 2024 11:18:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16442

commit c7c449502b51c5b5de79f97a42be750b28f6ecee upstream.

Sending a 7kB ping packet to the RZ/G2L in v6.9-rc2 causes the following
backtrace:

	WARNING: CPU: 0 PID: 0 at include/linux/skbuff.h:3127 skb_trim+0x30/0x38
	Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
	pc : skb_trim+0x30/0x38
	lr : ravb_rx_csum_gbeth+0x40/0x90
	Call trace:
	 skb_trim+0x30/0x38
	 ravb_rx_gbeth+0x56c/0x5cc
	 ravb_poll+0xa0/0x204
	 __napi_poll+0x38/0x17c

This is caused by ravb_rx_gbeth() calling ravb_rx_csum_gbeth() with the
wrong skb for a packet which spans multiple descriptors. To fix this,
use the correct skb.

Fixes: c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

[backported to 6.1.y-cip]
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Reviewed-by: Pavel Machek <pavel@denx.de>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index dda7fb410657..07771bdf0fc7 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -897,7 +897,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				priv->rx_1st_skb->protocol =
 					eth_type_trans(priv->rx_1st_skb, ndev);
 				if (ndev->features & NETIF_F_RXCSUM)
-					ravb_rx_csum_gbeth(skb);
+					ravb_rx_csum_gbeth(priv->rx_1st_skb);
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
 				stats->rx_packets++;
-- 
2.39.2


