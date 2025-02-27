Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44197C1B0FF
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:57:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.12357.1740668257062443821
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:57:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: X0F1D5dATdWeqAWO4A4fEg==
X-CSE-MsgGUID: fpMf5w2ARw6MpaqTX0ThDw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 27 Feb 2025 23:57:36 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E111A435C42A;
	Thu, 27 Feb 2025 23:57:34 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 05/11] net: ravb: Drop IP protocol check from RX csum verification
Date: Thu, 27 Feb 2025 14:57:14 +0000
Message-ID: <20250227145720.229324-6-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
References: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:57:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17956

commit 8d2109c1a51525c3586c5bf6f78ab1ce3c2908f8 upstream.

We do not need to confirm that the protocol is IPv4. If the hardware
encounters an unsupported protocol, it will set the checksum value to
0xFFFF.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index c0462fa633c8..156e441fb308 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -731,8 +731,7 @@ static void ravb_rx_csum_gbeth(struct sk_buff *skb)
 
 	skb_trim(skb, skb->len - 2 * sizeof(__sum16));
 
-	/* TODO: IPV6 Rx checksum */
-	if (skb->protocol == htons(ETH_P_IP) && !csum_proto)
+	if (!csum_proto)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 }
 
-- 
2.43.0


