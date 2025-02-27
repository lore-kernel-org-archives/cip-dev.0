Return-Path: <paul.barker.ct@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3404C19F32
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 15:34:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.13399.1740670465718438509
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 07:34:32 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: paul.barker.ct@bp.renesas.com)
X-CSE-ConnectionGUID: eGlKrvp2ROeNfS6cclqYkg==
X-CSE-MsgGUID: 9qny+gz9Sxy/r8cgJaVaCw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Feb 2025 00:34:32 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 71E95402CEAC;
	Fri, 28 Feb 2025 00:34:30 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 04/12] net: ravb: Disable IP header RX checksum offloading
Date: Thu, 27 Feb 2025 15:34:05 +0000
Message-ID: <20250227153413.686812-5-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
References: <20250227153413.686812-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 15:34:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17968

commit c4e347a02b14fa2425337473fcb120c62936cbc5 upstream.

For IPv4 packets, the header checksum will always be checked in software
in the RX path (inet_gro_receive() calls ip_fast_csum() unconditionally)
so there is no advantage in asking the hardware to also calculate this
checksum.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      |  2 +-
 drivers/net/ethernet/renesas/ravb_main.c | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index e3a8c3fa8d08..510e70fc0125 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1013,7 +1013,7 @@ enum CSR2_BIT {
 	CSR2_RDHD	= 0x08000000,
 };
 
-#define CSR2_CSUM_ENABLE (CSR2_RIP4 | CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4)
+#define CSR2_CSUM_ENABLE (CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4)
 
 #define DBAT_ENTRY_NUM	22
 #define RX_QUEUE_OFFSET	4
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 72578e84bd83..c88be3ea9579 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -752,13 +752,18 @@ static void ravb_get_tx_tstamp(struct net_device *ndev)
 static void ravb_rx_csum_gbeth(struct sk_buff *skb)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
-	__wsum csum_ip_hdr, csum_proto;
+	__wsum csum_proto;
 	skb_frag_t *last_frag;
 	u8 *hw_csum;
 
 	/* The hardware checksum status is contained in sizeof(__sum16) * 2 = 4
-	 * bytes appended to packet data. First 2 bytes is ip header checksum
-	 * and last 2 bytes is protocol checksum.
+	 * bytes appended to packet data.
+	 *
+	 * For ipv4, the first 2 bytes are the ip header checksum status. We can
+	 * ignore this as it will always be re-checked in inet_gro_receive().
+	 *
+	 * The last 2 bytes are the protocol checksum status which will be zero
+	 * if the checksum has been validated.
 	 */
 	if (unlikely(skb->len < sizeof(__sum16) * 2))
 		return;
@@ -774,16 +779,13 @@ static void ravb_rx_csum_gbeth(struct sk_buff *skb)
 	hw_csum -= sizeof(__sum16);
 	csum_proto = csum_unfold((__force __sum16)get_unaligned_le16(hw_csum));
 
-	hw_csum -= sizeof(__sum16);
-	csum_ip_hdr = csum_unfold((__force __sum16)get_unaligned_le16(hw_csum));
-
 	if (skb_is_nonlinear(skb))
 		skb_frag_size_sub(last_frag, 2 * sizeof(__sum16));
 	else
 		skb_trim(skb, skb->len - 2 * sizeof(__sum16));
 
 	/* TODO: IPV6 Rx checksum */
-	if (skb->protocol == htons(ETH_P_IP) && !csum_ip_hdr && !csum_proto)
+	if (skb->protocol == htons(ETH_P_IP) && !csum_proto)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 }
 
-- 
2.43.0


