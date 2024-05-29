Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E9EC25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:11:46 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.8658.1716970304604974979
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:11:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=i3drNVKk;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4202ca70270so21103655e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970303; x=1717575103; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqBLLg0SpKEPSEmPNwjc+KfOGmoOd83xGC6XKChYGtw=;
        b=i3drNVKkA59qJU01WdjnRNg4yts9vSbi7VZ1YfpPQGRz7duvqgRN28Bl+e2eobUnW6
         9yCJ+Tv0xaAGPE94m7RqHYHJZeBsFpeU/FUfetfvbVQpBrxsYkY+5dihS2SMSXD20TQ3
         /t6VcZ/DA5A1xIGvISMEjrY/5zYTb0Wx+Cxdov3iZvP3HyennohBiLPDeWMDl6nodKYs
         PukDEeS8v2BcVwQqWvIVqsOQETy9rLzpW8IPIIjNsUkFqMXMSTE5Sikf2rzV6Pq0efH3
         Pige1yxrZLtZOBcPHQFEgq8nDd3QxFxakmBseD9DAg9IY9Z3AfT5GYRzLBLy1QkJRJrW
         6/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970303; x=1717575103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqBLLg0SpKEPSEmPNwjc+KfOGmoOd83xGC6XKChYGtw=;
        b=elPReUvGU3YMjYTw918i3ZLlYvghmnmKIsHLxJe3Ano8KAn0rqaen90gdx+OqKWwTo
         kSr07HdNSDarAASB6PVPp6zlRt8PKN9/DblodtqVHGk2gXrsrUGv5sUVnePsq7q0LnMI
         zi2SmPa++kTcub7ooo0HBrozNlzIho6MYtGL+mUuCHt90WVJvlOQ9W/8E7JBoCP43DNo
         L2zH2yYJApc1E5TSrqG0GV0BS4Ja8QUZLResZqXebdXbD1mt+RFmzhmoSO419a9DyNLq
         BLG81JEjB+A4f6GWWkWw3mulQqR62T7OzTrcyM0Qx5T0WKsbJx3rZPs/8/9Th8OBhhaP
         Qoow==
X-Gm-Message-State: AOJu0YwEioTUiD15jQBIuqsaIeC2fROiZ2Mo9SRp66OhYgwCa6ufbgnP
	BcCcG7N+7sRmxV81vzviWv7iSEeQmb6AAgTys5izFC4YcH3JBf7DhspayOkPf60=
X-Google-Smtp-Source: AGHT+IHCC0YnHnLKtJ8iD4maUJZEMuBeOzuvWHBiZ43yr5WPXUaYU/oFpdDi6BL4mCI84lQi6nulwQ==
X-Received: by 2002:a05:600c:5613:b0:415:540e:74e3 with SMTP id 5b1f17b1804b1-42108aa7e26mr133704075e9.40.1716970302962;
        Wed, 29 May 2024 01:11:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:42 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 37/47] net: ravb: Return cached statistics if the interface is down
Date: Wed, 29 May 2024 11:10:29 +0300
Message-Id: <20240529081039.639010-38-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:11:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16017

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit bbf2345fa6582c5292bc5c537e7a29aad918be0c upstream.

Return the cached statistics in case the interface is down. There should be
no drawback to this, as cached statistics are updated in ravb_close().

In order to avoid accessing the IP registers while the IP is runtime
suspended pm_runtime_active() check was introduced. The device runtime
PM usage counter has been incremented to avoid disabling the device clocks
while the check is in progress (if any).

The commit prepares the code for the addition of runtime PM support.

Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 83b08ff417f6..791a65183a48 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2258,8 +2258,15 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 	struct ravb_private *priv = netdev_priv(ndev);
 	const struct ravb_hw_info *info = priv->info;
 	struct net_device_stats *nstats, *stats0, *stats1;
+	struct device *dev = &priv->pdev->dev;
 
 	nstats = &ndev->stats;
+
+	pm_runtime_get_noresume(dev);
+
+	if (!pm_runtime_active(dev))
+		goto out_rpm_put;
+
 	stats0 = &priv->stats[RAVB_BE];
 
 	if (info->tx_counters) {
@@ -2301,6 +2308,8 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 		nstats->rx_over_errors += stats1->rx_over_errors;
 	}
 
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return nstats;
 }
 
@@ -2368,6 +2377,9 @@ static int ravb_close(struct net_device *ndev)
 	if (info->nc_queues)
 		ravb_ring_free(ndev, RAVB_NC);
 
+	/* Update statistics. */
+	ravb_get_stats(ndev);
+
 	/* Set reset mode. */
 	return ravb_set_opmode(ndev, CCC_OPC_RESET);
 }
-- 
2.39.2


