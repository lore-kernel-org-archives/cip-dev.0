Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181E8C25B7E
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:57 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.8664.1716970311568917415
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fqkAibwe;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-420180b5838so9413495e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970310; x=1717575110; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vS+pq8MH7tDsD9QZljjbHYf+LZeL98CDK0/iuomJdI=;
        b=fqkAibwe6q8lVvI9ak8/qWq/lh21MfdpHeJgeDfTDpuM4GMj2+1jX5Xaq3zKNwx8uC
         6HotqbgLEruQTA9utzTm1LSbukblXgDCF2WJOR8XBW4/HDibf96BU9ps472ywSHgLuOI
         UE8b6vJ8Lp6rWttLegXODZtehXW7Iz2JNZat91gNV2XxKR5svZJIAJF8ph7Sph4o/oL5
         Wh4mDIWdxdImCzu55H68hlvoM3nOIuh0K+BbVX/qwi7NaD7ODM+8/6Or/Em4454Guxbj
         sebZb4srXMkBVlCJaoX+v8eHHRM8KtaDBGZPtZsveT3vR54BWVDUPeRVJJpCazibyHJD
         PcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970310; x=1717575110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vS+pq8MH7tDsD9QZljjbHYf+LZeL98CDK0/iuomJdI=;
        b=YeLAG/Gr5vSLc0s4a7EDbg2HZ3CtlHDmVb6gW3pnSiDEPQVPQQVXrza7fK/BoxzZx8
         qTAInxrzXUlhKuDOKPbIz3yh4AnMv8nrdvkb6z8xcd+iZ0mogYBqeU1XDGZJT5l6NjJw
         QZNoGDu+zPlTBKJ+fJHfgLAFeC9Snr7HeBiaog8MOCTTySAjfgq2m7jrj2m5TOaZGlKw
         J1CUS5F2HmSTNy0C4oSbflgXOys+Zu+PH+Np/Moc+XBKhu/tZTAh7vSZJi8kHY157uUM
         AS4GB4JWFcwQyw3X9Z3OMLqVykO3WRczvAIRmo6mgwDmQ3rUMdkvnN9tPCJI5nFAN86Y
         AcLA==
X-Gm-Message-State: AOJu0Yxy1cro/ubSwjouG35NLLrNkiJLQ85R1XZqmLAOD09DY3FgcXhw
	z5dhwk6QPSPf8N0B6Zznt/vHpObY2J2OUGwFivIGpmHuR0vdu4YlW3lgFsbL3ME=
X-Google-Smtp-Source: AGHT+IFjrDneHBlvV8saQaRWG3iH/Qqns5k5fn7xwQEKQP10L/V5wJDmaGSKC9nprhZEtefMUARVjg==
X-Received: by 2002:a05:600c:4f90:b0:41b:f979:e19b with SMTP id 5b1f17b1804b1-42108a18a20mr133486995e9.39.1716970310123;
        Wed, 29 May 2024 01:11:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 42/47] net: ravb: Fix RX byte accounting for jumbo packets
Date: Wed, 29 May 2024 11:10:34 +0300
Message-Id: <20240529081039.639010-43-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16022

From: Paul Barker <paul.barker.ct@bp.renesas.com>

commit 2e36c9fbc476f95a1b19e3fa0a2cdf408475ff56 upstream.

The RX byte accounting for jumbo packets was changed to fix a potential
use-after-free bug. However, that fix used the wrong variable and so
only accounted for the number of bytes in the final descriptor, not the
number of bytes in the whole packet.

To fix this, we can simply update our stats with the correct number of
bytes before calling napi_gro_receive().

Also rename pkt_len to desc_len in ravb_rx_gbeth() to avoid any future
confusion. The variable name pkt_len is correct in ravb_rx_rcar() as
that function does not handle packets spanning multiple descriptors.

Fixes: 5a5a3e564de6 ("ravb: Fix potential use-after-free in ravb_rx_gbeth()")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index fb0fc86a2239..c4ee77d41329 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -818,7 +818,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 	dma_addr_t dma_addr;
 	int rx_packets = 0;
 	u8  desc_status;
-	u16 pkt_len;
+	u16 desc_len;
 	u8  die_dt;
 	int entry;
 	int limit;
@@ -833,10 +833,10 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 		/* Descriptor type must be checked before all other reads */
 		dma_rmb();
 		desc_status = desc->msc;
-		pkt_len = le16_to_cpu(desc->ds_cc) & RX_DS;
+		desc_len = le16_to_cpu(desc->ds_cc) & RX_DS;
 
 		/* We use 0-byte descriptors to mark the DMA mapping errors */
-		if (!pkt_len)
+		if (!desc_len)
 			continue;
 
 		if (desc_status & MSC_MC)
@@ -857,25 +857,25 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 			switch (die_dt) {
 			case DT_FSINGLE:
 				skb = ravb_get_skb_gbeth(ndev, entry, desc);
-				skb_put(skb, pkt_len);
+				skb_put(skb, desc_len);
 				skb->protocol = eth_type_trans(skb, ndev);
 				if (ndev->features & NETIF_F_RXCSUM)
 					ravb_rx_csum_gbeth(skb);
 				napi_gro_receive(&priv->napi[q], skb);
 				rx_packets++;
-				stats->rx_bytes += pkt_len;
+				stats->rx_bytes += desc_len;
 				break;
 			case DT_FSTART:
 				priv->rx_1st_skb = ravb_get_skb_gbeth(ndev, entry, desc);
-				skb_put(priv->rx_1st_skb, pkt_len);
+				skb_put(priv->rx_1st_skb, desc_len);
 				break;
 			case DT_FMID:
 				skb = ravb_get_skb_gbeth(ndev, entry, desc);
 				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
 							       priv->rx_1st_skb->len,
 							       skb->data,
-							       pkt_len);
-				skb_put(priv->rx_1st_skb, pkt_len);
+							       desc_len);
+				skb_put(priv->rx_1st_skb, desc_len);
 				dev_kfree_skb(skb);
 				break;
 			case DT_FEND:
@@ -883,17 +883,17 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				skb_copy_to_linear_data_offset(priv->rx_1st_skb,
 							       priv->rx_1st_skb->len,
 							       skb->data,
-							       pkt_len);
-				skb_put(priv->rx_1st_skb, pkt_len);
+							       desc_len);
+				skb_put(priv->rx_1st_skb, desc_len);
 				dev_kfree_skb(skb);
 				priv->rx_1st_skb->protocol =
 					eth_type_trans(priv->rx_1st_skb, ndev);
 				if (ndev->features & NETIF_F_RXCSUM)
 					ravb_rx_csum_gbeth(priv->rx_1st_skb);
+				stats->rx_bytes += priv->rx_1st_skb->len;
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
 				rx_packets++;
-				stats->rx_bytes += pkt_len;
 				break;
 			}
 		}
-- 
2.39.2


