Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB7DC27C51
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:26 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.8578.1716970277337611209
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=P+o6pdiJ;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42108739ed8so21250745e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970276; x=1717575076; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzoNf9JbIV0LzI7jLpdqeO6pw0YrqrRLljLSKRy/Xfg=;
        b=P+o6pdiJRLPAR9buBCgCvndFrYE+IKr5uftHwRnOu/EnY9C2d9FJlk8oLMFX57yUwc
         Mh2mrmpT34P+MZAiqNEb8Cm9x/A5Bs2rerWbEaaHZmjw/eMN7Hkg4l6OBjvf6EY3GC3h
         3jL7Gt5Y47WYfAShvot5Z5LckMdMt2cftx1dWPiepErxXpem6vrF97GHdmgJrdRCQQ7g
         ZJTgc6sDdA7AWDuBniF+69qj7PrbvyNPmMltqS5h6e2jZJAzLUsXTxnMXLOGoQ87HcsK
         suyVYE8/iiXJwCoyF2jBqRY3PkZlnV7spD7h+MjiKaccqwvljxTt0qsgcPVsaF0SKoWA
         N1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970276; x=1717575076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uzoNf9JbIV0LzI7jLpdqeO6pw0YrqrRLljLSKRy/Xfg=;
        b=UfoQPo4VEBAQjFLxDFNuIjwb3aj0sSseWY6P3/PD7Ov8rZlrVmGfd76mDAmJFdobGx
         Z58pKn5AVnPrL2/8JDWpSCMONOEyCKvOQSswxowcofb+/ySq2MD9Yr+zNIgjt5rdPOp3
         0WzWreVy2E5XErCeArDd9E4bjv6OMGRFlb986He6eq4iNy70UlVrk7z6QFZlRjaoQfvx
         NPS9xZ0MPjAsRs9pxgirFOokOKb3bK0IpGaW0iFRg8ueb8ilC8LE9WDz2OzzfYP3yEyA
         FSvYoaLoAlOqAp2wBDFBXIfPtWzs4JgeeP9zkXDxU9mq1jW+SbhYo7QvbBSF3KsOSDuQ
         FeRg==
X-Gm-Message-State: AOJu0YxzAsiHRzdi9EIzicg3ks7EZOZzL0viA8p2XhAh2gO8nZLd3Qq4
	p7j8v3V4SB/h2cs8Rwgd3newkNKVmjSEL8MZlAuc8ImlwGLcFnvPudeYmYs8SHY=
X-Google-Smtp-Source: AGHT+IEirTyfMnyoQe9iPV+BAxogPjaFp0+SENqpl0B3N9ibma2N7UfukzC90U01oJrg+4n6P8WdjQ==
X-Received: by 2002:a05:600c:3586:b0:41f:e10f:88b1 with SMTP id 5b1f17b1804b1-42108a99f18mr145555715e9.27.1716970275848;
        Wed, 29 May 2024 01:11:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:15 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 20/47] net: ravb: Let IP-specific receive function to interrogate descriptors
Date: Wed, 29 May 2024 11:10:12 +0300
Message-Id: <20240529081039.639010-21-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16000

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2b993bfdb47b3aaafd8fe9cd5038b5e297b18ee1 upstream.

ravb_poll() initial code used to interrogate the first descriptor of the
RX queue in case gPTP is false to determine if ravb_rx() should be called.
This is done for non-gPTP IPs. For gPTP IPs the driver PTP-specific
information was used to determine if receive function should be called. As
every IP has its own receive function that interrogates the RX descriptors
list in the same way the ravb_poll() was doing there is no need to double
check this in ravb_poll(). Removing the code from ravb_poll() leads to a
cleaner code.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[claudiu.beznea: fixed conflict in ravb_poll()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index ed19026e0976..546a32c6d130 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1282,24 +1282,16 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	struct net_device *ndev = napi->dev;
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
-	bool gptp = info->gptp || info->ccc_gac;
-	struct ravb_rx_desc *desc;
 	unsigned long flags;
 	int q = napi - priv->napi;
 	int mask = BIT(q);
 	int quota = budget;
-	unsigned int entry;
-	bool unmask;
 
-	if (!gptp) {
-		entry = priv->cur_rx[q] % priv->num_rx_ring[q];
-		desc = &priv->gbeth_rx_ring[entry];
-	}
 	/* Processing RX Descriptor Ring */
 	/* Clear RX interrupt */
 	ravb_write(ndev, ~(mask | RIS0_RESERVED), RIS0);
-	if (gptp || desc->die_dt != DT_FEMPTY)
-		unmask = !ravb_rx(ndev, &quota, q);
+	if (ravb_rx(ndev, &quota, q))
+		goto out;
 
 	/* Processing TX Descriptor Ring */
 	spin_lock_irqsave(&priv->lock, flags);
@@ -1309,10 +1301,6 @@ static int ravb_poll(struct napi_struct *napi, int budget)
 	netif_wake_subqueue(ndev, q);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	if (gptp || desc->die_dt != DT_FEMPTY)
-		if (!unmask)
-			goto out;
-
 	napi_complete(napi);
 
 	/* Re-enable RX/TX interrupts */
-- 
2.39.2


