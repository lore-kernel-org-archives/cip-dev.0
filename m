Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA800C25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:46 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.8589.1716970298928933646
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=UxbIY0bb;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-421140314d5so14295215e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970297; x=1717575097; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50CvPeF+dbaUlajr6elNVBAXlqJM5xGsPXFVFovmo0I=;
        b=UxbIY0bboVNznI4XWJkeyNayWfjcfJCcVRIJzbNscrR1rTceXx5hLYZVqig0P3Ul76
         pthDFM1e5KcDVP8lXwHX/LAp4tvV6R69SV+g1VVT7MEFJuXAsRP8a6Y0WtEivD5wb3cY
         T4qPh+JxWmF/B3Xg2ThwPCvs3HBxBsIVlFyR5niHQaesanRr7HWdEXpje0JSmXUnvBno
         s8r5MTuqCyxW9EumgSRScIPyVhr/asiouIhhuIfkdIMgXYaJHccbiM4jxkAykPbcKOb+
         QkLn+Bzb7SNMS3DnwZU769YbBYfrHtYAXtw9VjojnPSKtAf27w/nC2hTMnFQ5s0ovaGj
         YjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970297; x=1717575097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50CvPeF+dbaUlajr6elNVBAXlqJM5xGsPXFVFovmo0I=;
        b=oeEUZUHka/ou1WWBoVuE8VtgXRrvg1r9UHRVNvE96wxOPG9a/YozhEQ9p+jCGXcbcE
         ZHrvCnsgYJ+5Dnx2038WeMzNEHLpbOvk65bIk0MGhQbDJrluufwdDscOvOdfigA4Vneo
         vjXvl8qoV/1JeMhdgy6IJIioWMO3M/JExuJ1esoVzRQIGTSzVap7/WawbnB3J9HmxcY8
         eb1Es0xcHbJY281UujdQBCKHJf8f48d5VWaH8oW7IC6hDnlJi6rEcO6C8WIixhzpPNKA
         AeoMEwTjQv34r52RT9RuM3mDG6YQraKzI8Z6wp3FlS5ri/gvnE3YhbkCSo2jdTcXRroh
         67uA==
X-Gm-Message-State: AOJu0YzKnV1MDHfkPyKP0OBhtiszb43UZNyfq22Av6hIO7FiQj9RDdjW
	3GfZaBhsAjcWOexJdFLVoRkmFNoIIUNK1RI19zhQILmTNFYWdBNWY4kWA8TFSdw=
X-Google-Smtp-Source: AGHT+IGS+7eL6z4DvLjMWyR8jFdAIX4lpdHZNWDw1RYQa1tz+fPQPXqlcaUoW5Y5tqxq0//yHk2Wvg==
X-Received: by 2002:a05:600c:4f89:b0:41b:a670:a9f1 with SMTP id 5b1f17b1804b1-421089ccf68mr106291175e9.7.1716970297447;
        Wed, 29 May 2024 01:11:37 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 34/47] ravb: Add Tx checksum offload support for GbEth
Date: Wed, 29 May 2024 11:10:26 +0300
Message-Id: <20240529081039.639010-35-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16014

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
index 5f573121f941..82fea6f9a3f6 100644
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
index d6c53ca4068d..e3f475b73ea4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -31,6 +31,7 @@
 #include <linux/sys_soc.h>
 #include <linux/reset.h>
 #include <linux/math64.h>
+#include <net/ip.h>
 
 #include "ravb.h"
 
@@ -512,16 +513,28 @@ static int ravb_ring_init(struct net_device *ndev, int q)
 
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
@@ -2063,6 +2076,36 @@ static void ravb_tx_timeout_work(struct work_struct *work)
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
@@ -2078,6 +2121,9 @@ static netdev_tx_t ravb_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	u32 entry;
 	u32 len;
 
+	if (skb->ip_summed == CHECKSUM_PARTIAL && !ravb_can_tx_csum_gbeth(skb))
+		skb_checksum_help(skb);
+
 	spin_lock_irqsave(&priv->lock, flags);
 	if (priv->cur_tx[q] - priv->dirty_tx[q] > (priv->num_tx_ring[q] - 1) *
 	    num_tx_desc) {
@@ -2487,6 +2533,17 @@ static int ravb_set_features_gbeth(struct net_device *ndev,
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
@@ -2661,8 +2718,8 @@ static const struct ravb_hw_info gbeth_hw_info = {
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


