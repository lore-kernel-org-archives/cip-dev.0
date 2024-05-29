Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02306C27C51
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:47 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.8660.1716970305706929806
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=SjgJg820;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4211a86f124so15064725e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970304; x=1717575104; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2Mkhe8Sds9oK4AvQt0vChY01f/jyL7Ufva/hJ3oa2w=;
        b=SjgJg820lhqqawZ+h/vAvigOKZQVfr8mrmP5Z26JHHtpx40+14Rg+s7DrSaKkPTz+B
         9KWCagHNYbDsBuv1+ll79E64kx/QUKOZGyhK7pFCdf8vCR/GoGRoQ5gMsoqSeS7Ri7um
         EcEdvWmmWGz/7e5mNxphsEfs00OeJxFo5wSoWpBa6+Fa7a8cu6pppRqqCV6gRaUsnCdU
         oS/y6JK895u59PemSHVuo4uQ2Fj/yrYQLXM4Z/J5V5YcInudIE/z2PCEg+CS0+fchRQw
         voBA1WbBv1Ot7Ljlbz20+sNp9TdDvFKjABdRYooQ1GKIPWPqiSGXuA4KzSi9JDbcO1sc
         x60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970304; x=1717575104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2Mkhe8Sds9oK4AvQt0vChY01f/jyL7Ufva/hJ3oa2w=;
        b=G0A8C3Z663ijG1h81SFxngnnSHS7QUtrufAQwwpTNcdz2vw5vWVrD9q6WduqzAvJiz
         Fa+fOg1VLX5qdfj/f7cIeseOdl8eOppW7Xgoo+gFNLuVEPdaKYeyY0fWw8HRkpsRWM7Q
         GkKk8HDdI/OX1Vxm/zHIB5wKYdHPEFyScxwu/vEoasVPweYsprSX6O0Ekmn8aFaXWxHO
         WL/p8cdJAxDDQq4RGqpVZ/3K54avXtoAthQsEubBDi8kQUGF2rONn0R/xlbnrZDMz4Zk
         AU+Jhh58s8B2IINMThHbbe42adR+nMZfzd44ZU91+cRjVJ7VKangbaUtsvV2AmTh8Kzl
         ZMEA==
X-Gm-Message-State: AOJu0YwhyWpEDdKSuDIskkBZ1D0FpjQzCQMbFZxa9y7g8+H9R3B4hcnG
	eSUhE9KuB5ZjDz1EnmNkVtQiwFQ3fjM1RvLfqFMXji+kvbf+JrRaE+FZ6s2aZSQ=
X-Google-Smtp-Source: AGHT+IEOSEqEpX4H09IbaqF0fZ6qGVyXbn2KRUrfk0XOjyopOJafom1NgX7XpxoLz79MLYxIHCISmQ==
X-Received: by 2002:a05:600c:198d:b0:41b:f41a:c67e with SMTP id 5b1f17b1804b1-42108a20cf4mr91538735e9.33.1716970304159;
        Wed, 29 May 2024 01:11:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:43 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 38/47] net: ravb: Move the update of ndev->features to ravb_set_features()
Date: Wed, 29 May 2024 11:10:30 +0300
Message-Id: <20240529081039.639010-39-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16018

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 7bddccc9911cdff377e16b9a5a386721279b4438 upstream.

Commit c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
introduced support for setting GbEth features. With this the IP-specific
features update functions update the ndev->features individually.

Next commits add runtime PM support for the ravb driver. The runtime PM
implementation will enable/disable the IP clocks on
the ravb_open()/ravb_close() functions. Accessing the IP registers with
clocks disabled blocks the system.

The ravb_set_features() function could be executed when the Ethernet
interface is closed so we need to ensure we don't access IP registers while
the interface is down when runtime PM support will be in place.

For these, move the update of ndev->features to ravb_set_features(). In
this way we update the ndev->features only when the IP-specific features
set function returns success and we can avoid code duplication when
introducing runtime PM registers protection.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 791a65183a48..2324b2dd59a5 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2556,7 +2556,6 @@ static int ravb_set_features_gbeth(struct net_device *ndev,
 			goto done;
 	}
 
-	ndev->features = features;
 done:
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -2571,8 +2570,6 @@ static int ravb_set_features_rcar(struct net_device *ndev,
 	if (changed & NETIF_F_RXCSUM)
 		ravb_set_rx_csum(ndev, features & NETIF_F_RXCSUM);
 
-	ndev->features = features;
-
 	return 0;
 }
 
@@ -2581,8 +2578,15 @@ static int ravb_set_features(struct net_device *ndev,
 {
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
+	int ret;
+
+	ret = info->set_feature(ndev, features);
+	if (ret)
+		return ret;
 
-	return info->set_feature(ndev, features);
+	ndev->features = features;
+
+	return 0;
 }
 
 static const struct net_device_ops ravb_netdev_ops = {
-- 
2.39.2


