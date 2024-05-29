Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F33C25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:17 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.8692.1716970513000531262
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=cRAP6sN5;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4201986d60aso14211315e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970511; x=1717575311; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apkIlgEN6czO8OEvrh6kR9GZjSQkOYIihcsMr9h3UnY=;
        b=cRAP6sN5GGJD9WdQ8YYbeZ0J5oeAxA6QsoZuGufdgM9jfn89UPQ/S0GHYdtjO9ZIYK
         lduVcsD+gGL0648c97qjBVZHdqQUhFm2nWCjrhJTnH4e3hu034MRElhpwQdtiOVjC16S
         d+vdfaV+ApoEKOjd4FY4MpovYWuKigmqH0Y6d9SSe5yYHHg9Pplx18nPrtsZzDSgcBWL
         Afu8nRtVzAvbP4jeMU7aBn+Cb4CdPTPuQ3yVQOzYLjsldQ/6dVARvD1aurzd6ZE1jvuS
         ChS10a7X+/WTjd3zwkIsdQKzc0CXnHj8qfqv0jgoL2FHk2kxDfjTXYHBiNSY66WdAThZ
         0W1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970511; x=1717575311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apkIlgEN6czO8OEvrh6kR9GZjSQkOYIihcsMr9h3UnY=;
        b=G12vd1cNh2vGfkj9+tZywiAu0BjOW1Sfd1WDeXyydmMjf1oOEX6KLXETPsp/NnBVw+
         aFenv9nEGS4RxYg7E/W6HZ/j89SN5z+1fVmSWSCOnRCUp0KfM4prjfyY5jiEzuvrX3jy
         xeRLxDUAtV+6OHQbSXcDtODriND/VLm/qA2u32BIacX/R5NQah+3YWWZ83e2MX3Ffdog
         7IfLZs39FqgSbb2/+avrZpvO+vEi9Fbr+KBaO99eG/rNNlcluYP3zeNEUalclE5HScQD
         e6+u8wDeSB0fm2c89zvuzOeZILjcDaMQw3ydyXHsgPo+iA/gaJ6NH4svham1mZMyKiEi
         tBtQ==
X-Gm-Message-State: AOJu0YxlmsZRHURJ0jmLG4ySMIoNXBTGqO2/r2iqyW7WVoshXzVZ76Cj
	lnlZEa8AhJroq0FJewI1Wp4B2nEcquTRX/j6FwylQGkFoFGd/DU+CEeF+QmMG1I=
X-Google-Smtp-Source: AGHT+IHNugWpCmH0+pCsKzzTZOCmbJ8JAfCB9FlGQP+PgIXWcnclU/UfOVXWbRX8A7KhRtKvt1C8Zg==
X-Received: by 2002:a7b:c5d0:0:b0:420:29dd:84d0 with SMTP id 5b1f17b1804b1-42108a00091mr111444075e9.29.1716970511421;
        Wed, 29 May 2024 01:15:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:10 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 21/33] ravb: Add Rx checksum offload support for GbEth
Date: Wed, 29 May 2024 11:14:22 +0300
Message-Id: <20240529081434.639519-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16049

From: Biju Das <biju.das.jz@bp.renesas.com>

commit c2da9408579d52fdf9b0ec494534d6ac66d4511e upstream.

TOE has hardware support for calculating IP header and TCP/UDP/ICMP
checksum for both IPv4 and IPv6.

Add Rx checksum offload supported by TOE for IPv4 and TCP/UDP protocols.

For Rx, the 4-byte result of checksum calculation is attached to the
Ethernet frames.First 2-bytes is result of IPv4 header checksum and next
2-bytes is TCP/UDP/ICMP checksum.

If a frame does not have checksum error, 0x0000 is attached as checksum
calculation result. For unsupported frames 0xFFFF is attached as checksum
calculation result. In case of an IPv6 packet, IPv4 checksum is always set
to 0xFFFF.

We can test this functionality by the below commands

ethtool -K eth0 rx on --> to turn on Rx checksum offload
ethtool -K eth0 rx off --> to turn off Rx checksum offload

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20240207092838.160627-2-biju.das.jz@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 19 ++++-
 drivers/net/ethernet/renesas/ravb_main.c | 92 +++++++++++++++++++++++-
 2 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 268ccfafe7aa..b98677c7c8e1 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -205,7 +205,10 @@ enum ravb_reg {
 	TLFRCR	= 0x0758,
 	RFCR	= 0x0760,
 	MAFCR	= 0x0778,
-	CSR0    = 0x0800,	/* RZ/G2L only */
+
+	/* TOE registers (RZ/G2L only) */
+	CSR0    = 0x0800,
+	CSR2    = 0x0808,
 };
 
 
@@ -978,6 +981,20 @@ enum CSR0_BIT {
 	CSR0_RPE	= 0x00000020,
 };
 
+enum CSR2_BIT {
+	CSR2_RIP4	= 0x00000001,
+	CSR2_RTCP4	= 0x00000010,
+	CSR2_RUDP4	= 0x00000020,
+	CSR2_RICMP4	= 0x00000040,
+	CSR2_RTCP6	= 0x00100000,
+	CSR2_RUDP6	= 0x00200000,
+	CSR2_RICMP6	= 0x00400000,
+	CSR2_RHOP	= 0x01000000,
+	CSR2_RROUT	= 0x02000000,
+	CSR2_RAHD	= 0x04000000,
+	CSR2_RDHD	= 0x08000000,
+};
+
 #define DBAT_ENTRY_NUM	22
 #define RX_QUEUE_OFFSET	4
 #define NUM_RX_QUEUE	2
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 511352a93cbc..d5d660edd481 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -514,6 +514,24 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 	return -ENOMEM;
 }
 
+static void ravb_csum_init_gbeth(struct net_device *ndev)
+{
+	if (!(ndev->features & NETIF_F_RXCSUM))
+		goto done;
+
+	ravb_write(ndev, 0, CSR0);
+	if (ravb_wait(ndev, CSR0, CSR0_RPE, 0)) {
+		netdev_err(ndev, "Timeout enabling hardware checksum\n");
+		ndev->features &= ~NETIF_F_RXCSUM;
+	} else {
+		ravb_write(ndev, CSR2_RIP4 | CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4,
+			   CSR2);
+	}
+
+done:
+	ravb_write(ndev, CSR0_TPE | CSR0_RPE, CSR0);
+}
+
 static void ravb_emac_init_gbeth(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -545,7 +563,8 @@ static void ravb_emac_init_gbeth(struct net_device *ndev)
 
 	/* E-MAC status register clear */
 	ravb_write(ndev, ECSR_ICD | ECSR_LCHNG | ECSR_PFRI, ECSR);
-	ravb_write(ndev, CSR0_TPE | CSR0_RPE, CSR0);
+
+	ravb_csum_init_gbeth(ndev);
 
 	/* E-MAC interrupt enable register */
 	ravb_write(ndev, ECSIPR_ICDIP, ECSIPR);
@@ -726,6 +745,30 @@ static void ravb_get_tx_tstamp(struct net_device *ndev)
 	}
 }
 
+static void ravb_rx_csum_gbeth(struct sk_buff *skb)
+{
+	__wsum csum_ip_hdr, csum_proto;
+	u8 *hw_csum;
+
+	/* The hardware checksum status is contained in sizeof(__sum16) * 2 = 4
+	 * bytes appended to packet data. First 2 bytes is ip header checksum
+	 * and last 2 bytes is protocol checksum.
+	 */
+	if (unlikely(skb->len < sizeof(__sum16) * 2))
+		return;
+
+	hw_csum = skb_tail_pointer(skb) - sizeof(__sum16);
+	csum_proto = csum_unfold((__force __sum16)get_unaligned_le16(hw_csum));
+
+	hw_csum -= sizeof(__sum16);
+	csum_ip_hdr = csum_unfold((__force __sum16)get_unaligned_le16(hw_csum));
+	skb_trim(skb, skb->len - 2 * sizeof(__sum16));
+
+	/* TODO: IPV6 Rx checksum */
+	if (skb->protocol == htons(ETH_P_IP) && !csum_ip_hdr && !csum_proto)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+}
+
 static void ravb_rx_csum(struct sk_buff *skb)
 {
 	u8 *hw_csum;
@@ -811,6 +854,8 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				skb = ravb_get_skb_gbeth(ndev, entry, desc);
 				skb_put(skb, pkt_len);
 				skb->protocol = eth_type_trans(skb, ndev);
+				if (ndev->features & NETIF_F_RXCSUM)
+					ravb_rx_csum_gbeth(skb);
 				napi_gro_receive(&priv->napi[q], skb);
 				stats->rx_packets++;
 				stats->rx_bytes += pkt_len;
@@ -838,6 +883,8 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				dev_kfree_skb(skb);
 				priv->rx_1st_skb->protocol =
 					eth_type_trans(priv->rx_1st_skb, ndev);
+				if (ndev->features & NETIF_F_RXCSUM)
+					ravb_rx_csum_gbeth(skb);
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
 				stats->rx_packets++;
@@ -2409,11 +2456,48 @@ static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
+static int ravb_endisable_csum_gbeth(struct net_device *ndev, enum ravb_reg reg,
+				     u32 val, u32 mask)
+{
+	u32 csr0 = CSR0_TPE | CSR0_RPE;
+	int ret;
+
+	ravb_write(ndev, csr0 & ~mask, CSR0);
+	ret = ravb_wait(ndev, CSR0, mask, 0);
+	if (!ret)
+		ravb_write(ndev, val, reg);
+
+	ravb_write(ndev, csr0, CSR0);
+
+	return ret;
+}
+
 static int ravb_set_features_gbeth(struct net_device *ndev,
 				   netdev_features_t features)
 {
-	/* Place holder */
-	return 0;
+	netdev_features_t changed = ndev->features ^ features;
+	struct ravb_private *priv = netdev_priv(ndev);
+	unsigned long flags;
+	int ret = 0;
+	u32 val;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	if (changed & NETIF_F_RXCSUM) {
+		if (features & NETIF_F_RXCSUM)
+			val = CSR2_RIP4 | CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4;
+		else
+			val = 0;
+
+		ret = ravb_endisable_csum_gbeth(ndev, CSR2, val, CSR0_RPE);
+		if (ret)
+			goto done;
+	}
+
+	ndev->features = features;
+done:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return ret;
 }
 
 static int ravb_set_features_rcar(struct net_device *ndev,
@@ -2593,6 +2677,8 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.emac_init = ravb_emac_init_gbeth,
 	.gstrings_stats = ravb_gstrings_stats_gbeth,
 	.gstrings_size = sizeof(ravb_gstrings_stats_gbeth),
+	.net_hw_features = NETIF_F_RXCSUM,
+	.net_features = NETIF_F_RXCSUM,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats_gbeth),
 	.max_rx_len = ALIGN(GBETH_RX_BUFF_MAX, RAVB_ALIGN),
 	.tccr_mask = TCCR_TSRQ0,
-- 
2.39.2


