Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5DEC27C44
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:28 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.8696.1716970518626306762
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kQFRtFSg;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42120e3911eso12067525e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970517; x=1717575317; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HO0X9jNoxwJfBZX16rch2LjhZ/J4q4jPUaEye07frbs=;
        b=kQFRtFSg3r4IspZ9nZfItz2vKfoK4MkwssVys3+wbDWyoXto+2RdepD99tAufeQcS4
         py3rTpLR9gVh//t9r86FjtXGFsxlDIT1l3xRT53bqVL3YO1VjqyPiFDRJOKb2KgKXopm
         Tc85LH4PmVALitCEZsFG9QTFWqJCpbMyYh4nno4twnz9oyTcq5yGgfxhHIQW1XRPmLeZ
         NBgWkJvcEhGxFWlU21k06dThfqWF2PrJeYxWxYFagwzHfalm4N0I205SYVPTQV+adHEO
         psHSswteDCBZdsL2F/XlS4hp6WdoxXj9AnxBrBfgWWXoj9B48zpnXGjeBNIh1xLJXHyq
         ojRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970517; x=1717575317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HO0X9jNoxwJfBZX16rch2LjhZ/J4q4jPUaEye07frbs=;
        b=V/GNfNkdg2Bz5SNGqxhhzBUFZeyYb/zyso5JtjsbKnz0qg0HM9upiser5+cFFdxXYK
         PnRp471GaUQG/yqeAXLT+i8+l9hdbP2MpZpSujNjaogy7sGcsYb8nDW5Tn4g8WxOlYN/
         PlZfM9jyJ9dswDfouQjtZ0YN90UZMHTouXLDpvkzZXycsh5AXWkzSfnZ11dHpTRkHYg5
         MH2z9sJ0I61NR1qNzoZlZzwCFwgHb6Y9d45TIDpnMmhxdXWoWUA/mHcJYsKwi28q42by
         aT3MI397LAET1ZOtPJ0A+Vus5cKg2GoTwu1baJMnqVBC3rPt4q7gcC+Tx4McKVetbwul
         LJcA==
X-Gm-Message-State: AOJu0Yy9fKIpP/LlFKjvL/tpiuFHsGKIQTKkAT4cdt1lu5jHC2u15YHe
	zpHyIUc9o4J76NjFrgEDxdt5FH0usz3uJQJSv04Sa7crKwD19xkhlV5pwKjqkj4=
X-Google-Smtp-Source: AGHT+IGxHV+njv86lakbyK/lotwnrcLfMTPn9Mnsr/oXBfI6jXhcVdBKGO50mM0AXlw91+asBalscA==
X-Received: by 2002:a05:600c:1c9f:b0:41b:b07a:c54c with SMTP id 5b1f17b1804b1-421089ccfa1mr101215985e9.9.1716970517155;
        Wed, 29 May 2024 01:15:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 25/33] net: ravb: Return cached statistics if the interface is down
Date: Wed, 29 May 2024 11:14:26 +0300
Message-Id: <20240529081434.639519-26-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16053

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
index ea741fcab46c..6494f72ff79f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2268,8 +2268,15 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
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
@@ -2311,6 +2318,8 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
 		nstats->rx_over_errors += stats1->rx_over_errors;
 	}
 
+out_rpm_put:
+	pm_runtime_put_noidle(dev);
 	return nstats;
 }
 
@@ -2378,6 +2387,9 @@ static int ravb_close(struct net_device *ndev)
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


