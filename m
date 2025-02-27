Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3847C282C1
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 15:34:40 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.13489.1740670477142947630
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 07:34:39 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: vmLmZLEeS660q/gOvbLdyA==
X-CSE-MsgGUID: irKygROyRqes85MlGMNS+A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2025 00:34:38 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3D9EA402CEAC;
	Fri, 28 Feb 2025 00:34:36 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 07/12] net: ravb: Simplify types in RX csum validation
Date: Thu, 27 Feb 2025 15:34:08 +0000
Message-ID: <20250227153413.686812-8-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
References: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 15:34:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17971

commit faacdbba01802c89f7043f9a47ad442c1195d307 upstream.

The hardware checksum value is used as a 16-bit flag, it is zero when
the checksum has been validated and non-zero otherwise. Therefore we
don't need to treat this as an actual __wsum type or call csum_unfold(),
we can just use a u16 pointer.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 26 +++++++++++-------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e9a1c7e0a709..ad480e2d61e7 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -752,11 +752,11 @@ static void ravb_get_tx_tstamp(struct net_device *ndev)
 static void ravb_rx_csum_gbeth(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
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
@@ -764,24 +764,22 @@ static void ravb_rx_csum_gbeth(struct sk_buff *skb)
 	 * The last 2 bytes are the protocol checksum status which will be zero
 	 * if the checksum has been validated.
 	 */
-	if (unlikely(skb->len < sizeof(__sum16) * 2))
+	csum_len = sizeof(*hw_csum) * 2;
+	if (unlikely(skb->len < csum_len))
 		return;
 
 	if (skb_is_nonlinear(skb)) {
 		skb_frag_t *last_frag = &shinfo->frags[shinfo->nr_frags - 1];
 
-		hw_csum = skb_frag_address(last_frag) +
-			  skb_frag_size(last_frag);
-		skb_frag_size_sub(last_frag, 2 * sizeof(__sum16));
+		hw_csum = (u16 *)(skb_frag_address(last_frag) +
+				  skb_frag_size(last_frag));
+		skb_frag_size_sub(last_frag, csum_len);
 	} else {
-		hw_csum = skb_tail_pointer(skb);
-		skb_trim(skb, skb->len - 2 * sizeof(__sum16));
+		hw_csum = (u16 *)skb_tail_pointer(skb);
+		skb_trim(skb, skb->len - csum_len);
 	}
 
-	hw_csum -= sizeof(__sum16);
-	csum_proto = csum_unfold((__force __sum16)get_unaligned_le16(hw_csum));
-
-	if (!csum_proto)
+	if (!get_unaligned(--hw_csum))
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 }
 
-- 
2.43.0


