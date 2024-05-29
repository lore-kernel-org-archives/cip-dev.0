Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7AE5C27C44
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:17 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.8693.1716970514613394209
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=QDgR7eTr;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4210aa012e5so16633915e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970513; x=1717575313; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHMVjLd7RP3eKSJm0+rbG7gR51jKSkKylI+vHBocuxw=;
        b=QDgR7eTr8brP70mE1ui5yAZHUCLEfNiy81dw6/AlFW097s3CJfLPlBRKOV8qJKAYMY
         0+5AhzS/zIeTSRTROj6lT4UlxAp0mIk3zV6fHPp7jPPJcfyX9LZz719nQ5r+/gcd9zh6
         m0JDM3bUGjfYTj+Q+Z/upABxCBWRJl5QFXJ3jBkLZWkv1V4pVHho0wR9pxo2dD6zvvHo
         CrDH3kR5UbOCqopFbm5fvYIPYVQM3rkPQ+bOo1WAPeGnX7NHOHc1Ad21hSTI+O7RmdQz
         9nJg5YoGbLFQ0Zbs8CByjFLj2UZeuV0kGC4u9hr51UBFK7ZWftcsxkqtBwoa532QkX7T
         swxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970513; x=1717575313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHMVjLd7RP3eKSJm0+rbG7gR51jKSkKylI+vHBocuxw=;
        b=Z/gj2SAMYvZDcqTqU1cgi5Wm4gJZYRBJJ6mvPziPrflpBS6VN52z+qLa1il4CSL6aB
         DUfxh8jf6Vnux3kk+HH/IxdKjEzJ6SKuJqLVnA2VMqjggaw8AYZAMDbntyyiV/6yZJkL
         2alhRv6E5WZ1vSBkMUOOpK9CAnagPyvL2cDspVOLSy3/2mMMngwFhtUEi5Lgr5pahzHO
         FyvxKomK7JyERnq1QjK5o668GyT4dpSVv240VbDU29B4PljQjVEoQBAAXryXyiFRyUgK
         3Qfa8sI5h6QNgK6yheYwwDFKLmRFrhz7vD6eERUeHrpH8UjRSUvExSvoDiZWCiNv/A5t
         yMgA==
X-Gm-Message-State: AOJu0YxLCvZ4+fPgMmZNKHWy1sfpTi4ugMTzMnbxrwLTaHB9skA2aRGd
	ULHRe5S9M/IyYG47DGZxm9pkTlqedIYSPLhM0ppDSOUIEnGbQWXM1uVQzN09oEw=
X-Google-Smtp-Source: AGHT+IFuW/XPYxGdttDYkBmkL1Wm3MgE+g/8xXam5YIxG8B6CY5IqcI+o0eiRQdOJqfRyMpvt3M+Gg==
X-Received: by 2002:a05:600c:19ca:b0:418:3eb7:e8c6 with SMTP id 5b1f17b1804b1-42108a4f6a5mr107698565e9.5.1716970513064;
        Wed, 29 May 2024 01:15:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:12 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 22/33] ravb: Add Tx checksum offload support for GbEth
Date: Wed, 29 May 2024 11:14:23 +0300
Message-Id: <20240529081434.639519-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16050

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 6c8e2803ef36d3c0c20c7019a19c668c3b0ac1d1 upstream.

TOE has hardware support for calculating IP header and TCP/UDP/ICMP
checksum for both IPv4 and IPv6.

Add Tx checksum offload supported by TOE for IPv4 and TCP/UDP.

For Tx, the result of checksum calculation is set to the checksum field of
each IPv4 Header/TCP/UDP/ICMP of ethernet frames. For the unsupported
frames, those fields are not changed. If a transmission frame is an UDPv4
frame and its checksum value in the UDP header field is 0x0000, TOE does
not calculate checksum for UDP part of this frame as it is optional
function as per standards.

We can test this functionality by the below commands

ethtool -K eth0 tx on --> to turn on Tx checksum offload
ethtool -K eth0 tx off --> to turn off Tx checksum offload

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20240207092838.160627-3-biju.das.jz@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb.h      | 15 +++++
 drivers/net/ethernet/renesas/ravb_main.c | 71 +++++++++++++++++++++---
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index b98677c7c8e1..35e642fc4b2a 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -208,6 +208,7 @@ enum ravb_reg {
 
 	/* TOE registers (RZ/G2L only) */
 	CSR0    = 0x0800,
+	CSR1    = 0x0804,
 	CSR2    = 0x0808,
 };
 
@@ -981,6 +982,20 @@ enum CSR0_BIT {
 	CSR0_RPE	= 0x00000020,
 };
 
+enum CSR1_BIT {
+	CSR1_TIP4	= 0x00000001,
+	CSR1_TTCP4	= 0x00000010,
+	CSR1_TUDP4	= 0x00000020,
+	CSR1_TICMP4	= 0x00000040,
+	CSR1_TTCP6	= 0x00100000,
+	CSR1_TUDP6	= 0x00200000,
+	CSR1_TICMP6	= 0x00400000,
+	CSR1_THOP	= 0x01000000,
+	CSR1_TROUT	= 0x02000000,
+	CSR1_TAHD	= 0x04000000,
+	CSR1_TDHD	= 0x08000000,
+};
+
 enum CSR2_BIT {
 	CSR2_RIP4	= 0x00000001,
 	CSR2_RTCP4	= 0x00000010,
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index d5d660edd481..548bd436c51a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -31,6 +31,7 @@
 #include <linux/sys_soc.h>
 #include <linux/reset.h>
 #include <linux/math64.h>
+#include <net/ip.h>
 
 #include "ravb.h"
 
@@ -516,16 +517,28 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 
 static void ravb_csum_init_gbeth(struct net_device *ndev)
 {
-	if (!(ndev->features & NETIF_F_RXCSUM))
+	bool tx_enable = ndev->features & NETIF_F_HW_CSUM;
+	bool rx_enable = ndev->features & NETIF_F_RXCSUM;
+
+	if (!(tx_enable || rx_enable))
 		goto done;
 
 	ravb_write(ndev, 0, CSR0);
-	if (ravb_wait(ndev, CSR0, CSR0_RPE, 0)) {
+	if (ravb_wait(ndev, CSR0, CSR0_TPE | CSR0_RPE, 0)) {
 		netdev_err(ndev, "Timeout enabling hardware checksum\n");
-		ndev->features &= ~NETIF_F_RXCSUM;
+
+		if (tx_enable)
+			ndev->features &= ~NETIF_F_HW_CSUM;
+
+		if (rx_enable)
+			ndev->features &= ~NETIF_F_RXCSUM;
 	} else {
-		ravb_write(ndev, CSR2_RIP4 | CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4,
-			   CSR2);
+		if (tx_enable)
+			ravb_write(ndev, CSR1_TIP4 | CSR1_TTCP4 | CSR1_TUDP4, CSR1);
+
+		if (rx_enable)
+			ravb_write(ndev, CSR2_RIP4 | CSR2_RTCP4 | CSR2_RUDP4 | CSR2_RICMP4,
+				   CSR2);
 	}
 
 done:
@@ -2073,6 +2086,36 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	rtnl_unlock();
 }
 
+static bool ravb_can_tx_csum_gbeth(struct sk_buff *skb)
+{
+	struct iphdr *ip = ip_hdr(skb);
+
+	/* TODO: Need to add support for VLAN tag 802.1Q */
+	if (skb_vlan_tag_present(skb))
+		return false;
+
+	/* TODO: Need to add hardware checksum for IPv6 */
+	if (skb->protocol != htons(ETH_P_IP))
+		return false;
+
+	switch (ip->protocol) {
+	case IPPROTO_TCP:
+		break;
+	case IPPROTO_UDP:
+		/* If the checksum value in the UDP header field is 0, TOE does
+		 * not calculate checksum for UDP part of this frame as it is
+		 * optional function as per standards.
+		 */
+		if (udp_hdr(skb)->check == 0)
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 /* Packet transmit function for Ethernet AVB */
 static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
@@ -2088,6 +2131,9 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	u32 entry;
 	u32 len;
 
+	if (skb->ip_summed == CHECKSUM_PARTIAL && !ravb_can_tx_csum_gbeth(skb))
+		skb_checksum_help(skb);
+
 	spin_lock_irqsave(&priv->lock, flags);
 	if (priv->cur_tx[q] - priv->dirty_tx[q] > (priv->num_tx_ring[q] - 1) *
 	    num_tx_desc) {
@@ -2493,6 +2539,17 @@ static int ravb_set_features_gbeth(struct net_device *ndev,
 			goto done;
 	}
 
+	if (changed & NETIF_F_HW_CSUM) {
+		if (features & NETIF_F_HW_CSUM)
+			val = CSR1_TIP4 | CSR1_TTCP4 | CSR1_TUDP4;
+		else
+			val = 0;
+
+		ret = ravb_endisable_csum_gbeth(ndev, CSR1, val, CSR0_TPE);
+		if (ret)
+			goto done;
+	}
+
 	ndev->features = features;
 done:
 	spin_unlock_irqrestore(&priv->lock, flags);
@@ -2677,8 +2734,8 @@ static const struct ravb_hw_info gbeth_hw_info = {
 	.emac_init = ravb_emac_init_gbeth,
 	.gstrings_stats = ravb_gstrings_stats_gbeth,
 	.gstrings_size = sizeof(ravb_gstrings_stats_gbeth),
-	.net_hw_features = NETIF_F_RXCSUM,
-	.net_features = NETIF_F_RXCSUM,
+	.net_hw_features = NETIF_F_RXCSUM | NETIF_F_HW_CSUM,
+	.net_features = NETIF_F_RXCSUM | NETIF_F_HW_CSUM,
 	.stats_len = ARRAY_SIZE(ravb_gstrings_stats_gbeth),
 	.max_rx_len = ALIGN(GBETH_RX_BUFF_MAX, RAVB_ALIGN),
 	.tccr_mask = TCCR_TSRQ0,
-- 
2.39.2


