Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B24C19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:57:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.12486.1740668248506296267
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:57:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: m8E8QoDeRdSHeiXAt3XONw==
X-CSE-MsgGUID: gJQtTV+JTq+9kp2TPsO6Pw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 27 Feb 2025 23:57:38 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1F320434774C;
	Thu, 27 Feb 2025 23:57:36 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 06/11] net: ravb: Simplify types in RX csum validation
Date: Thu, 27 Feb 2025 14:57:15 +0000
Message-ID: <20250227145720.229324-7-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
References: <20250227145720.229324-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:57:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17957

commit faacdbba01802c89f7043f9a47ad442c1195d307 upstream.

The hardware checksum value is used as a 16-bit flag, it is zero when
the checksum has been validated and non-zero otherwise. Therefore we
don't need to treat this as an actual __wsum type or call csum_unfold(),
we can just use a u16 pointer.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
[Modified to apply to linux-5.10.y-cip which lacks skb fragment handling
 as we've chosen not to backport 966726324b7b ("net: ravb: Allocate RX
 buffers via page pool")]
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 156e441fb308..9602e0b3a16c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -711,11 +711,11 @@ static void ravb_get_tx_tstamp(struct net_device *ndev)
 
 static void ravb_rx_csum_gbeth(struct sk_buff *skb)
 {
-	__wsum csum_proto;
-	u8 *hw_csum;
+	size_t csum_len;
+	u16 *hw_csum;
 
-	/* The hardware checksum status is contained in sizeof(__sum16) * 2 = 4
-	 * bytes appended to packet data.
+	/* The hardware checksum status is contained in 4 bytes appended to
+	 * packet data.
 	 *
 	 * For ipv4, the first 2 bytes are the ip header checksum status. We can
 	 * ignore this as it will always be re-checked in inet_gro_receive().
@@ -723,15 +723,14 @@ static void ravb_rx_csum_gbeth(struct sk_buff *skb)
 	 * The last 2 bytes are the protocol checksum status which will be zero
 	 * if the checksum has been validated.
 	 */
-	if (unlikely(skb->len < sizeof(__sum16) * 2))
+	csum_len = sizeof(*hw_csum) * 2;
+	if (unlikely(skb->len < csum_len))
 		return;
 
-	hw_csum = skb_tail_pointer(skb) - sizeof(__sum16);
-	csum_proto = csum_unfold((__force __sum16)get_unaligned_le16(hw_csum));
-
-	skb_trim(skb, skb->len - 2 * sizeof(__sum16));
+	hw_csum = (u16 *)skb_tail_pointer(skb);
+	skb_trim(skb, skb->len - csum_len);
 
-	if (!csum_proto)
+	if (!get_unaligned(--hw_csum))
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 }
 
-- 
2.43.0


