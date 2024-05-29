Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E47DC41513
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:16 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.8574.1716970269103757782
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=inCVSpeG;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42120e3911eso12040355e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970267; x=1717575067; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFn52GZj4zA/bx2lr0z33NXuStNVJOwxX4B6CDIZEts=;
        b=inCVSpeGbKcP4KHN0e7GtLdOssRWrIq/FOjaJ0NIs/DKQN1zZfeZIDUekcCjZQKXen
         XvjPcdxXhziwW4GDcz4ZElREijKB5uV24MyiqaCIqMtn3g6wjihYrHIKveKllfIqBgZ+
         6n9DKgklj8YUbkIK1HAqBw9MDSY8uNdadx1r4cZYGXiufMj9FOdpmC2kiIwUM3sbp8vB
         Nz+9NLtBU7qKLGq6OthlWH/3JZVxgHKB8USIV7GLtgU5HA2G48mMAVJ9AP4hTxOZMOZP
         7wxpNTrkEwzCQtlKe53uQzZIiUftoSX/dnKpqEQ5etgSVNOLR9OREDn9cmyjYcORbS0S
         5Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970267; x=1717575067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFn52GZj4zA/bx2lr0z33NXuStNVJOwxX4B6CDIZEts=;
        b=CZJ0jpTADVc5XKjCnwPQzypLiWgfjgtulSYRrJfPkL+97mEG1GGUm1hK8QqENWSRBR
         UjwEvmP+oLUPEqsPTWyipuD5jqOXWhNpljESce59EfGv8o+r3vP63cj/zIM/aL5xG9Xv
         hlyp+5S9Jcyc/EoFxFNawt9QYmyQ9UV5ZKhy90AHOaopRWef5kjvVjDFmN7VfrUp7HIO
         yp+bApHwoa6U+jMyUbUhzDM8O/Y2kGZApKkx/gb5J3CESSAVloXYFMGaD4CvG1fUiK91
         0THvUr4zba1I7n3zeP9yfQQJuxbV6Bv7JUjkD2RsHoahpFCmKzk+lSnrjY/6xIA2NKP5
         VwAQ==
X-Gm-Message-State: AOJu0YzzS5PWTqEmMFbmtIOvZ05kfIZ57e/+i05+LAMWaYr1n10cjDcE
	JaiXkuU1nJcnLeylpjfE6IzAz9UPLzl21YTDZC85r3F5S0srhFk3cgMFDvKRZ4o=
X-Google-Smtp-Source: AGHT+IGxdbWRotKTlNg+r2FiJnQQeXrTNtJfnIqTxtnlBmSgclMS2pJcpzpiKsbM6dEIdfWecxbZag==
X-Received: by 2002:a05:600c:4f0d:b0:421:1e47:f80a with SMTP id 5b1f17b1804b1-4211e47f85fmr29174115e9.41.1716970267616;
        Wed, 29 May 2024 01:11:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:07 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 15/47] net: ravb: Count packets instead of descriptors in GbEth RX path
Date: Wed, 29 May 2024 11:10:07 +0300
Message-Id: <20240529081039.639010-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15995

From: Paul Barker <paul.barker.ct@bp.renesas.com>

commit ed4adc07207d9165a4b3b36199231a22e9f51a55 upstream.

The units of "work done" in the RX path should be packets instead of
descriptors, as large packets can be spread over multiple descriptors.

Fixes: 1c59eb678cbd ("ravb: Fillup ravb_rx_gbeth() stub")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Link: https://lore.kernel.org/r/20240214151204.2976-1-paul.barker.ct@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 1420c41b6480..6cc3dc8d85f4 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -771,29 +771,25 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	struct ravb_rx_desc *desc;
 	struct sk_buff *skb;
 	dma_addr_t dma_addr;
+	int rx_packets = 0;
 	u8  desc_status;
-	int boguscnt;
 	u16 pkt_len;
 	u8  die_dt;
 	int entry;
 	int limit;
+	int i;
 
 	entry = priv->cur_rx[q] % priv->num_rx_ring[q];
-	boguscnt = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
+	limit = priv->dirty_rx[q] + priv->num_rx_ring[q] - priv->cur_rx[q];
 	stats = &priv->stats[q];
 
-	boguscnt = min(boguscnt, *quota);
-	limit = boguscnt;
 	desc = &priv->gbeth_rx_ring[entry];
-	while (desc->die_dt != DT_FEMPTY) {
+	for (i = 0; i < limit && rx_packets < *quota && desc->die_dt != DT_FEMPTY; i++) {
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
 		pkt_len = le16_to_cpu(desc->ds_cc) & RX_DS;
 
-		if (--boguscnt < 0)
-			break;
-
 		/* We use 0-byte descriptors to mark the DMA mapping errors */
 		if (!pkt_len)
 			continue;
@@ -819,7 +815,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				skb_put(skb, pkt_len);
 				skb->protocol = eth_type_trans(skb, ndev);
 				napi_gro_receive(&priv->napi[q], skb);
-				stats->rx_packets++;
+				rx_packets++;
 				stats->rx_bytes += pkt_len;
 				break;
 			case DT_FSTART:
@@ -847,7 +843,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 					eth_type_trans(priv->rx_1st_skb, ndev);
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
-				stats->rx_packets++;
+				rx_packets++;
 				stats->rx_bytes += pkt_len;
 				break;
 			}
@@ -886,9 +882,9 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 		desc->die_dt = DT_FEMPTY;
 	}
 
-	*quota -= limit - (++boguscnt);
-
-	return boguscnt <= 0;
+	stats->rx_packets += rx_packets;
+	*quota -= rx_packets;
+	return *quota == 0;
 }
 
 /* Packet receive function for Ethernet AVB */
-- 
2.39.2


